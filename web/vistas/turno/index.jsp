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
        <title>TV</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" rel="stylesheet">
        <%@include file="/source/styles/visualizador.jsp" %>
    </head>
    <body>
        <center>
            <div class="up">
                <div class="d-block p-2 text-white font-weight-bold" style="background-color: #000099">
                    <br>
                    <label style="color: white;"> ESTAMOS PARA SERVIR</label>
                    <br>
                    <br>
                </div>
            </div>
        </center>
        <div class="up">
            <div class="col-xs-5">
                <div >
                    <button></button>  
                    <center>
                        <script type="text/javascript">
                            var date = new Date();
                            var d = date.getDate();
                            var day = (d < 10) ? '0' + d : d;
                            var m = date.getMonth() + 1;
                            var month = (m < 10) ? '0' + m : m;
                            var yy = date.getYear();
                            var year = (yy < 1000) ? yy + 1900 : yy;
                            document.write('Fecha:' + day + "/" + month + "/" + year);
                        </script>   
                    </center>
                    <center>
                        <script type="text/javascript">
                            function startTime() {
                                today = new Date();
                                h = today.getHours();
                                m = today.getMinutes();
                                s = today.getSeconds();
                                m = checkTime(m);
                                s = checkTime(s);
                                document.getElementById('reloj').innerHTML = h + ":" + m + ":" + s;
                                t = setTimeout('startTime()', 500);
                            }
                            function checkTime(i)
                            {
                                if (i < 10) {
                                    i = "0" + i;
                                }
                                return i;
                            }
                            window.onload = function () {
                                startTime();
                            }
                        </script> 
                    </center>
                    <div id="reloj" style="font-size:20px;"></div> 
                    <ul class="list-group">

                    </ul> 

                </div>
                <br>
            </div>
        </div>

        <div class=" izq">
            <br>
            <br>
            <video class="video" id="video" width="530" height="430" controls muted loop>
                <source src="/turnero/source/videos/Intro.mp4" type="video/mp4">
            </video>
        </div>

        <script>
            var vid = document.getElementById('video');
            vid.autoplay = true;
            vid.load();;
        </script>



        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <center> 
            <div class="col-xl-12" style="position: absolute; bottom: 0%;">
                <div class="d-block p-2 text-white" style="background-color: #000099">
                    <marquee><h1><label style="color: white;">¡Bienvenidos! Nuestros horario de atención es de lunes a sabado de 9:00 am a 7:30 pm  Domingos 10:00 am a 2:00 pm </label></h1></marquee>
                </div>
            </div>
        </center>

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
                      let row = "<li class=\"list-group-item\"> " + value.nombre + " : " + value.turno +" </li>"
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
          sound.src = '/turnero/source/sound/S-TURNO.wav'
          sound.play()
        }
    </script>
</html>
