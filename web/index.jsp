<%-- 
    Document   : index
    Created on : 25/02/2019, 07:30:09 PM
    Author     : Dahian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>
    <body>
        
        <form action="login" method="post">
            <table cellspacing="3" cellpadding="3" border="1" >
            <tr>
            <td align="right"> Nombre: </td>
            <td>
                <input type="text" name="email">
            </td>
            </tr>
            <tr>
                <td align="right"> Password: </td>
                <td>
                   <input type="text" name="pass">
                </td>
            </tr>
            </table>

            <input type="reset" value="Borrar">
            <input type="submit" value="Enviar">
        </form>
        <a href=pagina3.jsp > pagina 3</a>
        <a href=RegistroClientes.jsp > Registro de clientes</a>
    </body>
</html>
