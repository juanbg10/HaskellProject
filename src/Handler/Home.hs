{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where
    
import Import
import Data.FileEmbed (embedFile)
--import Text.Lucius
--import Text.Julius

--import Network.HTTP.Types.Status
import Database.Persist.Postgresql


getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")
    
    
getHomeR :: Handler Html
getHomeR = do 
    defaultLayout $ do             
            [whamlet|
                    <head>
                            <script type="text/javascript" async="async" >
                            var elem = document.createElement('script');
                            elem.src = 'https://quantcast.mgr.consensu.org/cmp.js';
                            elem.async = true;
                            elem.type = "text/javascript";
                            var scpt = document.getElementsByTagName('script')[0];
                            scpt.parentNode.insertBefore(elem, scpt);
                            (function() {
                            var gdprAppliesGlobally = false;
                            function addFrame() {
                                if (!window.frames['__cmpLocator']) {
                                if (document.body) {
                                    var body = document.body,
                                        iframe = document.createElement('iframe');
                                    iframe.style = 'display:none';
                                    iframe.name = '__cmpLocator';
                                    body.appendChild(iframe);
                                } else {
                                    setTimeout(addFrame, 5);
                                }
                                }
                            }
                            addFrame();
                            function cmpMsgHandler(event) {
                                var msgIsString = typeof event.data === "string";
                                var json;
                                if(msgIsString) {
                                json = event.data.indexOf("__cmpCall") != -1 ? JSON.parse(event.data) : {};
                                } else {
                                json = event.data;
                                }
                                if (json.__cmpCall) {
                                var i = json.__cmpCall;
                                window.__cmp(i.command, i.parameter, function(retValue, success) {
                                    var returnMsg = {"__cmpReturn": {
                                    "returnValue": retValue,
                                    "success": success,
                                    "callId": i.callId
                                    }};
                                    event.source.postMessage(msgIsString ?
                                    JSON.stringify(returnMsg) : returnMsg, '*');
                                });
                                }
                            }
                            window.__cmp = function (c) {
                                var b = arguments;
                                if (!b.length) {
                                return __cmp.a;
                                }
                                else if (b[0] === 'ping') {
                                b[2]({"gdprAppliesGlobally": gdprAppliesGlobally,
                                    "cmpLoaded": false}, true);
                                } else if (c == '__cmp')
                                return false;
                                else {
                                if (typeof __cmp.a === 'undefined') {
                                    __cmp.a = [];
                                }
                                __cmp.a.push([].slice.apply(b));
                                }
                            }
                            window.__cmp.gdprAppliesGlobally = gdprAppliesGlobally;
                            window.__cmp.msgHandler = cmpMsgHandler;
                            if (window.addEventListener) {
                                window.addEventListener('message', cmpMsgHandler, false);
                            }
                            else {
                                window.attachEvent('onmessage', cmpMsgHandler);
                            }
                            })();
                            window.__cmp('init', {
                                    'Language': 'pt',
                                'Initial Screen Body Text Option': 1,
                                'Publisher Name': 'Moneytizer',
                                'Default Value for Toggles': 'off',
                                'UI Layout': 'banner',
                                'No Option': false,
                            });
                    
                        <style>
                            .qc-cmp-button,
                            .qc-cmp-button.qc-cmp-secondary-button:hover {
                                background-color: #000000 !important;
                                border-color: #000000 !important;
                            }
                            .qc-cmp-button:hover,
                            .qc-cmp-button.qc-cmp-secondary-button {
                                background-color: transparent !important;
                                border-color: #000000 !important;
                            }
                            .qc-cmp-alt-action,
                            .qc-cmp-link {
                                color: #000000 !important;
                            }
                            .qc-cmp-button,
                            .qc-cmp-button.qc-cmp-secondary-button:hover {
                                color: #ffffff !important;
                            }
                            .qc-cmp-button:hover,
                            .qc-cmp-button.qc-cmp-secondary-button {
                                color: #000000 !important;
                            }
                            .qc-cmp-small-toggle,
                            .qc-cmp-toggle {
                                background-color: #000000 !important;
                                border-color: #000000 !important;
                            }
                            .qc-cmp-main-messaging,
                            .qc-cmp-messaging,
                            .qc-cmp-sub-title,
                            .qc-cmp-privacy-settings-title,
                            .qc-cmp-purpose-list,
                            .qc-cmp-tab,
                            .qc-cmp-title,
                            .qc-cmp-vendor-list,
                            .qc-cmp-vendor-list-title,
                            .qc-cmp-enabled-cell,
                            .qc-cmp-toggle-status,
                            .qc-cmp-table,
                            .qc-cmp-table-header {
                                color: #000000 !important;
                            }
                                
                            .qc-cmp-ui {
                                background-color: #ffffff !important;
                            }
                    
                               .qc-cmp-table,
                            .qc-cmp-table-row {
                                border: 1px solid !important;
                                border-color: #000000 !important;
                            } 
                            #qcCmpButtons a {
                                text-decoration: none !important;
                    
                           }
                                
                            #qcCmpButtons button {
                            margin-top: 65px;
                             }
                             c-  cmp-qc-link-container{
                                display:none;}
                    
                            
                




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