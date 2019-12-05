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
formLis :: Form Lista
formLis = renderBootstrap $  Lista
        <$> areq textField "Nome: " Nothing
        <*> areq textField "E-mail: " Nothing
        <*> areq intField  "Telefone: " Nothing
        <*> areq textField "Endereço: " Nothing
        <*> areq intField   "CEP: " Nothing
        <*> areq intField   "Número: " Nothing
        <*> areq textField "Observações: " Nothing

getListaR :: Handler Html
getListaR = do 
    (widget,_) <- generateFormPost formLis
    msg <- getMessage
    defaultLayout $ do
        setTitle "Cadastro"
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheetRemote "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        addStylesheetRemote "https://code.jquery.com/jquery-3.4.1.min.js"
        [whamlet|
            $maybe mensa <- msg 
                <div class="container">
                    ^{mensa}
            
            <h1>
                CADASTRAR PRÉDIO
            
            <form method=post action=@{ListaR}>
                ^{widget}
                <input type="submit" value="Cadastrar" class="btn btn-danger">
        |]

postListaR :: Handler Html
postListaR = do 
    ((result,_),_) <- runFormPost formLis
    case result of 
        FormSuccess serie -> do 
            runDB $ insert serie 
            setMessage [shamlet|
                <div class="container">
                    CONDOMÍNIO INCLUIDO
            |]
            redirect ListaR
        _ -> redirect HomeR