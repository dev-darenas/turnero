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
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <h1>Hello World!</h1>
        <button></button>
        
        <ul class="list-group">
            
        </ul>
        
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
    <%@include file="/source/javascript/javalib.jsp" %>
     
    <script>
        $( document ).ready(function() {
            var turnos = [];
            
            window.setInterval(function(){
                llamar_turno()
            }, 10000);
            
            const button = document.querySelector("button")
            button.addEventListener('click', playSound)
                
            function llamar_turno(){
                $.ajax(
                  '/turnero/VerTurnos'
                ).done(function(data) {
                  
                  data = data.replace(",]", "]");

                  data = JSON.parse(data).turnos;
                  
                  
                   $(".list-group").empty();
                  $.each(data, function( index, value ) {
                      let row = "<li class=\"list-group-item\"> " + value.nombre + " : "+ value.turno +" </li>"
                      $(".list-group").append(row);
                  });
                  
                  // comparar los arreglos
                  console.log(data)
                  console.log(turnos)
                  $.each(data, function( index, value ) {
                      $.each(turnos, function( index, value2 ) {
                          if(value.nombre == value2.nombre){
                              if( value.turno != value2.turno){
                                console.log("llama truno")
                                $( "button" ).click();
                              }
                          }
                      });
                  });
                  turnos = data;
                }).fail(function(jqXHR) {
                  console.log(jqXHR.statusText);
                });
            }
        });
        
        function playSound() {
          const sound = new Audio()
          sound.src = '/turnero/sound/S-TURNO.wav'
          sound.play()
        }
    </script>
</html>
