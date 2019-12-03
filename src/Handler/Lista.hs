{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Lista where

import Import
import Text.Lucius
import Text.Julius
import Database.Persist.Postgresql

-- renderDivs
formUsu :: Form Lista
formUsu = renderBootstrap $ (,)
    <$> (CadastroLista 
        <$> areq textField "Nome: " Nothing
        <*> areq emailField "E-mail: " Nothing
        <*> areq telField "Telefone: " Nothing
        <*> areq adressField "Endereço: " Nothing
        <*> areq cepField "CEP: " Nothing
        <*> areq numField "Número: " Nothing
        <*> areq obsField "Observações: " Nothing)
    <*> areq passwordField "Digite Novamente: " Nothing

getUsuarioR :: Handler Html
getUsuarioR = do 
    (widget,_) <- generateFormPost formUsu
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRAR PRÉDIO
            
            <form method=post action=@{ListaR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

postUsuarioR :: Handler Html
postUsuarioR = do 
    ((result,_),_) <- runFormPost formUsu
    case result of 
        FormSuccess (usuario,veri) -> do 
            if (usuarioSenha usuario == veri) then do 
                runDB $ insert usuario 
                setMessage [shamlet|
                    <div>
                        USUARIO INCLUIDO
                |]
                redirect UsuarioR
            else do 
                setMessage [shamlet|
                    <div>
                        SENHA E VERIFICACAO N CONFEREM
                |]
                redirect UsuarioR
        _ -> redirect HomeR