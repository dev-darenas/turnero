<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
 

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse</title>
    </head>

    <body>
        <%@page import=" Controller.RegistroProducto" %>
        
                       
         <h1 aling=" center">Registro Producto</h1>
        <form action="/turnero1/RegistroProducto" method="post">
                    
    <table border="1" width="250" aling="center">
                
        
                <tr>
                        <td>Nombre:</td>
                        <td><input type="text" name="nom"/>  </td>
                    </tr>
                    <tr>
                        <td>Descripcion:</td>
                        <td><input type="text" name="des"/>  </td>
                    </tr>
                    <tr>
                        
                        <th colspan="2"> <input type="submit" value="Registrarme"/> </th>
                    </tr>
            </table>
            

            
        </form>
         
        
        
         
               <a href="list.jsp">Regresar</a>
               
               
    
    </body>
</html>