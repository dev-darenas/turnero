<%-- 
    Document   : conectarModulo
    Created on : 16/05/2019, 011:33:01 AM
    Author     : jhoan
--%>

<%@page import="java.io.File"%>
<%@page import="lib.Bot"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <h1>Hello World!</h1>

        <form method="POST" action="/turnero/ControlBot">
            <br/>
            conectar perfil 
            <br/>
            Modulo: <input type="text" name="perfil">
            <br/>
            <input type="text" name="accion" value="conectar" style="visibility: hidden"></div>
            <br/>

            <br/>
            enviar mensaje 
            <br/>
            <br/>
            numero <input type="text" name="numero" ></div>
            <br/>  
            <input type="text" name="accion" value="mensaje" style="visibility: hidden"></div>
            <br/>
            <input type="submit" value="conectar" name="boton"> 
            <br/>
        </form>

    </body>
</html>
