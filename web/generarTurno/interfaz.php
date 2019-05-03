<?php
//form.php: uso de formularios y enlace
//Fijarte dentro del form, que la acción a realizar es enviar los parámetros a parametros.php
?>
<html>
    <head>
        <title>GET, GET, REQUEST</title>
    </head>
    <body>
        <form action="pong.php" method="GET">
            <h1> Ping Pong</h1>
            <input type="text" name="cedula"/>
            <input type="text" name="comunicacion" value=""/>
            <input type="text" name="tipocomunicacion" value=""/>
            <input type="text" name="tiposervicio" value=""/>
            <input type="text" name="prioridad" value=""/>
            <input type="submit" name="boton" value="Enviar"/>
        </form>
    </body>
</html>