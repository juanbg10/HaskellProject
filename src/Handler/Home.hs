{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getPage3R :: Handler Html
getPage3R = do 
    defaultLayout $ do 
        $(whamletFile "templates/page3.hamlet")

getPage2R :: Handler Html
getPage2R = do 
    defaultLayout $ do 
        $(whamletFile "templates/page2.hamlet")
        toWidgetHead $(luciusFile "templates/page2.lucius")
        toWidgetHead $(juliusFile "templates/page2.julius")

getPage1R :: Handler Html
getPage1R = do 
    defaultLayout $ do 
        [whamlet|
            <h1>
                PAGINA 1
            
            <div>
                <a href=@{HomeR}>
                    Voltar
        |]

getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")

getHomeR :: Handler Html
getHomeR = do 
    defaultLayout $ do 
        -- addScriptRemote "url" -> CHAMA JS EXTERNO
        -- addScript (StaticR script_js), ONDE script 
        -- eh o nome do seu script.
        -- pasta css, arquivo: bootstrap.css
        setTitle "The Crabs"
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
         
            <!-- Navigation -->
            <nav class="navbar navbar-light bg-light static-top">
                <div class="container">
                    <a class="navbar-brand" href="#">The Crabs
            
            
            <!-- Masthead -->
            <header class="masthead text-white text-center">
                <div class="overlay">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-9 mx-auto">
                            <h1 class="mb-5">Gerencie suas tarefas prediais com mais facilidade e conforto!
                        
                        <div class="col-md-10 col-lg-8 col-xl-7 mx-auto">
                            <form>
                                <div class="form-row">
                                    <div class="col-12 col-md-9 mb-2 mb-md-0">
                                        <input type="email" class="form-control form-control-lg" placeholder="Digite o seu email...">
                                    
                                    <div class="col-12 col-md-3">
                                        <button type="submit" class="btn btn-block btn-lg btn-danger">Enviar!
                                    
                                
                            
                        
                    
                
            
            
            <!-- Icons Grid -->
            <section class="features-icons bg-light text-center">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex">
                                    <i class="icon-screen-desktop m-auto text-primary">
                                
                                <h3>Totalmente Responsivo
                                <p class="lead mb-0">Feito para dispositivos móveis
                            
                        
                        <div class="col-lg-4">
                            <div class="features-icons-item mx-auto mb-5 mb-lg-0 mb-lg-3">
                                <div class="features-icons-icon d-flex">
                                    <i class="icon-layers m-auto text-primary">
                                
                                <h3>Fácil e Prático
                                <p class="lead mb-0">Conecte-se e resolve suas pendências sem mais problemas ou empecilhos.
                            
                        
                        <div class="col-lg-4">
                            <div class="features-icons-item mx-auto mb-0 mb-lg-3">
                                <div class="features-icons-icon d-flex">
                                    <i class="icon-check m-auto text-primary">
                                
                                <h3>Testado e aprovado
                                <p class="lead mb-0">Versão beta disponível para testes!
                            
                        
                    
                
            
            
            <!-- Image Showcases -->
            <section class="showcase">
                <div class="container-fluid p-0">
                    <div class="row no-gutters">
                        <div class="col-lg-6 order-lg-2 text-white showcase-img" style="background-image: url('banner2.jpg');">
                        
                        <div class="col-lg-6 order-lg-1 my-auto showcase-text">
                            <h2>Totalmente Responsivo
                            <p class="lead mb-0">Fica ótimo em qualquer dispositivo, seja um telefone, tablet ou desktop, a página se comportará de maneira responsiva!!
                
                    
                    <div class="row no-gutters">
                        <div class="col-lg-6 text-white showcase-img" style="background-image: url('banner3.jpg');">
                        <div class="col-lg-6 my-auto showcase-text">
                            <h2>Fácil e Prático
                            <p class="lead mb-0">Feito pensando na usabilidade, para todas as idades!
                        
                    
                    <div class="row no-gutters">
                        <div class="col-lg-6 order-lg-2 text-white showcase-img" style="background-image: url('banner4.jpg');">
                        <div class="col-lg-6 order-lg-1 my-auto showcase-text">
                            <h2>Testado e aprovado
                            <p class="lead mb-0">Alguns condomínios já estão usando a versão beta disponível na playStore!
                    
                
            
            
            <!-- Testimonials -->
            <section class="testimonials text-center bg-light">
                <div class="container">
                    <h2 class="mb-5">Desenvolvedores...
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                <img src=@{StaticR user1_jpg}>
                                <h5>Juan Bertoluzzi Garcia
                                <p class="font-weight-light mb-0">"Desenvolvedor Front"
                            
                        
                        <div class="col-lg-4">
                            <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                <img src=@{StaticR user2_jpg}>
                                <h5>Tais Cristina da Silva
                                <p class="font-weight-light mb-0">"Desenvolvedora Front."
                            
                        
                        <div class="col-lg-4">
                            <div class="testimonial-item mx-auto mb-5 mb-lg-0">
                                <img src=@{StaticR user3_jpg}>
                                <h5>Franciele Zanella
                                <p class="font-weight-light mb-0">"Desenvolvedora Front!"
                            
            
            <!-- Call to Action -->
            <section class="call-to-action text-white text-center">
                <div class="overlay">
                
                <div class="container">
                    <div class="row">
                        <div class="col-xl-9 mx-auto">
                            <h2 class="mb-4">Vamos começar? Envie-nos um email agora!
                        
                        <div class="col-md-10 col-lg-8 col-xl-7 mx-auto">
                            <form>
                                <div class="form-row">
                                    <div class="col-12 col-md-9 mb-2 mb-md-0">
                                        <input type="email" class="form-control form-control-lg" placeholder="Digite seu email...">
                                    
                                    <div class="col-12 col-md-3">
                                        <button type="submit" class="btn btn-block btn-lg btn-danger">Enviar
                                    
                                
                            
                        
                    
                
            
            <h1>
                OLA MUNDO!
        
            <ul>
                <li>
                    <a href=@{Page1R}>
                        PAGINA 1
                
                <li>
                    <a href=@{Page2R}>
                        PAGINA 2
                
                <li>
                    <a href=@{Page3R}>
                        PAGINA 3
            
            
            <button class="btn btn-danger" onclick="ola()">
                OLA

            
            <!-- Footer -->
            <footer class="footer bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 h-100 text-center text-lg-left my-auto">
                            <ul class="list-inline mb-2">
                                <li class="list-inline-item">
                                    <a href="#">Sobre
                                
                                <li class="list-inline-item">&sdot;
                                
                                <li class="list-inline-item">
                                    <a href="#">Contato
                                
                                <li class="list-inline-item">&sdot;
                                
                                <li class="list-inline-item">
                                    <a href="#">Termos de uso
                                
                                <li class="list-inline-item">&sdot;
                                
                                <li class="list-inline-item">
                                    <a href="#">Politica e privacidade
                                
                            
                            <p class="text-muted small mb-4 mb-lg-0">&copy; The Crabs 2019. Todos os direitos Reservados.
                        
                        <div class="col-lg-6 h-100 text-center text-lg-right my-auto">
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item mr-3">
                                    <a href="#">
                                        <i class="fab fa-facebook fa-2x fa-fw">
                                    
                                
                                <li class="list-inline-item mr-3">
                                    <a href="#">
                                        <i class="fab fa-twitter-square fa-2x fa-fw">
                                   
                                <li class="list-inline-item">
                                    <a href="#">
                                        <i class="fab fa-instagram fa-2x fa-fw">
                                    
                            
                      
            
            <!-- Bootstrap core JavaScript -->
            <script src="vendor/jquery/jquery.min.js">
            <script src="vendor/bootstrap/js/bootstrap.bundle.min.js">
            


        |]