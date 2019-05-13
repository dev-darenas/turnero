<?php
//form.php: uso de formularios y enlace
?>
<html>
    <head>
        <title>GET REQUEST</title>
    </head>
    <body>
        <form action="pong.php" method="GET">
            <h1>Crear Turno</h1>
            cedula <input type="text" name="cedula"/>
            celular <input type="text" name="celular" value=""/>
            correo <input type="text" name="correo" value=""/>
            tiposervicio <input type="text" name="tiposervicio" value=""/>
            prioridad <input type="text" name="prioridad" value=""/>
            whatsapp <input type="text" name="notificacion_whatsapp" value=""/>
            email <input type="text" name="notificacion_email" value=""/>
            sms <input type="text" name="notificacion_sms" value=""/>
            <input type="submit" name="boton" value="Enviar"/>
        </form>

        <form action="pong.php" method="GET">
            <h1>Verificar Cliente</h1>
            cedula <input type="text" name="cedula"/>
            <input type="submit" name="boton" value="Enviar"/>
        </form>
    </body>
</html>