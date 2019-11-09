{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where
    
import Import
import Data.FileEmbed (embedFile)
import Text.Lucius
import Text.Julius

--import Network.HTTP.Types.Status
import Database.Persist.Postgresql


getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")
    

getPage2R :: Handler Html
getPage2R = do
    defaultLayout $ do 
        $(whamletFile "templates/page2.hamlet")
        toWidgetHead$(luciusFile "templates/page2.lucius")
        toWidgetHead$(juliusFile "templates/page2.julius")
    
getHomeR :: Handler Html
getHomeR = do 
    defaultLayout $ do 
        -- addScriptRemote "url" -> CHAMA JS EXTERNO
        -- addScript (StaticR script_js), ONDE script 
        -- eh o nome do seu script.
        -- pasta css, arquivo: bootstrap.css
        addStylesheet (StaticR css_bootstrap_css)
        
        toWidgetHead [julius|
            function ola(){
                alert("ola");
            }
        |]
        toWidgetHead [lucius|
            h1 {
                color : red;
            }
        |]
        [whamlet|
            <h1>
                OLA MUNDO!
            
            <ul>
                <li>
                    
                        PAGINA 1
            
            <button class="btn btn-danger" onclick="ola()">
                OLA
        |]