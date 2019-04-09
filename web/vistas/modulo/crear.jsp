<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
 
<%@page import="java.sql.*"%>
<%@page import="Modelos.Modulo"%>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%@page import="Modelos.Modulo" %>
        
        
        
              
                      
        
 
         
        <h1 aling=" center">Registro Modulo</h1>
        <form>
            
           
          
                
            <table border="1" width="250" aling="center">
                
            <tr>
                        <td>Cod_modulo:</td>
                        <td><input type="text" name="cod_modulo" value="" />  </td>
                    </tr>
                <tr>
                        <td>Nombre</td>
                        <td><input type="text" name="nombre" value="" />  </td>
                    </tr>
                    <tr>
                        <td>Descripcion:</td>
                        <td><input type="text" name="descripcion" value="" />  </td>
                    </tr>
                    <tr>
                        
                        <th colspan="2"> <input type="submit" value="GRABAR MODULO" name="grabar" /> </th>
                    </tr>
            </table>
            

            
        </form>
        
        
       
         
               <a href="list.jsp">Regresar</a>
    
    </body>
</html>
