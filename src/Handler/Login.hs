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
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                ENTRAR
            
            <form method=post action=@{EntrarR}>
                ^{widget}
                <input type="submit" value="Entrar">
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
                            Tente Novamente!
                    |]
                    redirect EntrarR
                Just (Entity _ usu) -> do 
                    if (usuarioSenha usu == senha) then do
                        setSession "_NOME" (usuarioNome usu)
                        redirect HomeR
                    else do 
                        setMessage [shamlet|
                            <div>
                                Senha Incorreta!
                        |]
                        redirect EntrarR 
        _ -> redirect HomeR
    
getAdminR :: Handler Html
getAdminR = do 
    foo <- runDB $ selectList [] [] :: Handler [Entity Lista]
    defaultLayout [whamlet|

        $forall Entity listaId Lista {..} <- foo
            listaEmailSin
            listaNomeSin
            listaTelSin
            listaAdress
            listaCep
            listaNumero
            listaObs
        
        
            <h1>
            Realize seu Login!
    |]