{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql


getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")
    
    
getHomeR :: Handler Html
getHomeR = do 
    defaultLayout $ do 
    addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead[julius|
            function ola(){
                alert("HELLO!");
            }
        |]
        
        
        toWidgetHead[lucius|
            h1{
                color:red;
            }
        |]
        
        [whamlet|
            <h1>Hello World!!
            <h2>Olá mundo
            <img src=@{StaticR pikachu_png>
        |]
        
getPage1R :: Handler Html
getPage1R = do
    defaultLayout $ do addScript (StaticR ola_js)
        [whamlet|
            <h1>
                Pag1
            
            <a href={HomeR}>
                Voltar
            
            |]