<%-- 
    Document   : index
    Created on : 13/05/2019, 07:46:59 PM
    Author     : Dahian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <button></button>
    </body>
    <%@include file="/source/javascript/javalib.jsp" %>
     
    <script>
        $( document ).ready(function() {
            var turnos = [];
            
            window.setInterval(function(){
                llamar_turno()
            }, 5000);
            
            const button = document.querySelector("button")
            button.addEventListener('click', playSound)
                
            function llamar_turno(){
                $.ajax(
                  '/turnero/VerTurnos'
                ).done(function(data) {
                  data = JSON.parse(data).turnos;
                  turnos = data;
                  $.each(data, function( index, value ) {
                    console.log( index + ": " + value.nombre );
                  });
                  
                  $( "button" ).click();
                }).fail(function(jqXHR) {
                  console.log(jqXHR.statusText);
                });
            }
        });
        
        function playSound() {
          const sound = new Audio()
          sound.src = '/turnero/sound/click.mp3'
          sound.play()
        }
    </script>
</html>
