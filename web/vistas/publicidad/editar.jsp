<%-- 
    Document   : editar
    Created on : 6/04/2019, 12:00:31 PM
    Author     : Dahian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrar publicidad</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">
            <h1>Administrar Publicidad</h1>
            <form action="uploadPublicidad" method="post" enctype="multipart/form-data">
                <input type="file" name="file" />
                <input type="submit" />
            </form>            
        </div>    
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
</html>
