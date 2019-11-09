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
    
    
getHomeR :: Handler Html
getHomeR = do 
    defaultLayout $ do             
            [whamlet|
                    <body>
                        <h1>Hello World!!
                        <h2>Olá mundo!!

                    |]
        
-- getPage1R :: Handler Html
-- getPage1R = -- do
--     defaultLayout -- $ do addScript (StaticR ola_js)
--         [whamlet|
--                     <h1>
--                         Pag1
                    
--                     <a href={HomeR}>
--                         Voltar
                    
--         |]
            
            
-- getPage2R :: Handler Html
-- getPage2R = do
--     defaultLayout $ do 
--         $(whamletFile "templates/page2.hamlet")
--         toWidgetHead$(luciusFile "templates/page2.lucius")
--         toWidgetHead$(juliusFile "templates/page2.julius")