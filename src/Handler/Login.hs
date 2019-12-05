{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Login where

import Import
import Text.Lucius
import Text.Julius
import Database.Persist.Postgresql

formLogin :: Form (Text, Text)
formLogin = renderBootstrap $ (,)
    <$> areq emailField "E-mail: " Nothing
    <*> areq passwordField "Senha: " Nothing

postSairR :: Handler Html
postSairR = do 
    deleteSession "_NOME"
    redirect HomeR

getEntrarR :: Handler Html
getEntrarR = do 
    (widget,_) <- generateFormPost formLogin
    msg <- getMessage
    defaultLayout $ do 
        setTitle "Administrador"
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheetRemote "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        addStylesheetRemote "https://code.jquery.com/jquery-3.4.1.min.js"
        [whamlet|
            $maybe mensa <- msg 
                <div class="mx-auto">
                    ^{mensa}
            
            <h1 class="mx-auto center">
                ENTRAR
            
            <form method=post action=@{EntrarR} class="container">
                ^{widget}
                <input type="submit" value="Entrar" class="btn btn-danger">
        |]

postEntrarR :: Handler Html
postEntrarR = do 
    ((result,_),_) <- runFormPost formLogin
    case result of 
        FormSuccess ("root@root.com","root125") -> do 
            setSession "_NOME" "admin"
            redirect AdminR
        FormSuccess (email,senha) -> do 
           -- select * from usuario where email=digitado.email
           usuario <- runDB $ getBy (UniqueEmailIx email)
           case usuario of 
                Nothing -> do 
                    setMessage [shamlet|
                        <div>
                            <h4>Tente Novamente!
                    |]
                    redirect EntrarR
                Just (Entity _ usu) -> do 
                    if (usuarioSenha usu == senha) then do
                        setSession "_NOME" (usuarioNome usu)
                        redirect HomeR
                    else do 
                        setMessage [shamlet|
                            <div>
                                <h4>Senha Incorreta!
                        |]
                        redirect EntrarR 
        _ -> redirect HomeR

    
getAdminR :: Handler Html
getAdminR = do 
    foo <- runDB $ selectList [] [] :: Handler [Entity Lista]
    defaultLayout $ do 
        setTitle "Administrador"
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheetRemote "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        addStylesheetRemote "https://code.jquery.com/jquery-3.4.1.min.js"
        [whamlet|
            <ul class="list-group">
                $forall Entity listaId Lista {..} <- foo
                    <li class="list-group-item active">#{listaEmailSin}
                    <li class="list-group-item">#{listaNomeSin}
                    <li class="list-group-item">#{listaTelSin}
                    <li class="list-group-item">#{listaAdress}
                    <li class="list-group-item">#{listaCep}
                    <li class="list-group-item">#{listaNumero}
                    <li class="list-group-item" style="margin-bottom:4vh;">#{listaObs}
                
                

            <form method=post action=@{SairR} style="margin-left:5vh;">
                <input type="submit" value="Sair" class="btn btn-secondary">
        |]