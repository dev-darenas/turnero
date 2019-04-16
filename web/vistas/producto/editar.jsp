<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
<%@ page import="java.io.*,java.util.*,java.net.*,java.sql.*" %>
<%--aqui se importa la clase conexion que se encuentra la carpeta conexion --%>
<%@page import="lib.ConsultasProducto"%>
<%@page import="java.sql.*"%>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%! ConsultasProducto con3 = new ConsultasProducto(); %>
        <%
        int id_producto=Integer.parseInt(request.getParameter("id_producto"));
        
                 ResultSet rs=null;
                 Statement st=null;
                  
               try{
                  
                 st=con3.getConexion().createStatement();
              rs=st.executeQuery("select * from producto where id_producto= "+ id_producto +"");
              
              while(rs.next()){
                  
             
        %>
        <h1>Editar Producto</h1>
        <form action="">
            <table border="1" width="250" >
                
                    <tr>
                        <td>Id_producto:</td>
                        <td> <input type="text" name="id_producto" value="<%= rs.getString(1) %>" />  </td>
                    </tr>
                <tr>
                        <td>Nombre</td>
                        <td><input type="text" name="nombre" value="<%= rs.getString(2) %>" />  </td>
                    </tr>
                    <tr>
                        <td>Descripcion:</td>
                        <td><input type="text" name="descripcion" value="<%= rs.getString(3) %>" />  </td>
                    </tr>
                    <tr>
                        
                        <th colspan="2"> <input type="submit" value="EDITAR" name="editar" /> </th>
                    </tr>
            </table>
            
        </form>
                        <%
                            }
}catch(Exception e){}

if(request.getParameter("editar")!=null){

    String nombre=request.getParameter("nombre");
   String descripcion=request.getParameter("descripcion");
   
st.executeUpdate("update producto set nombre='"+nombre+"',descripcion='"+descripcion+"' where id_producto="+id_producto+"");
request.getRequestDispatcher("list.jsp").forward(request, response);
}
    
%>
       
<form action="list.jsp" method="POST">
    <input type="submit" value="Volver" name="list.jsp" />
</form>        
         
                    
            
        
    </body>
</html>