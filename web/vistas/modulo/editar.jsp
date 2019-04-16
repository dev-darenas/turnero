<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
<%@ page import="java.io.*,java.util.*,java.net.*,java.sql.*" %>
<%--aqui se importa la clase conexion que se encuentra la carpeta conexion --%>
<%@page import="lib.ConsultasModulo"%>
<%@page import="java.sql.*"%>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%! ConsultasModulo con3 = new ConsultasModulo(); %>
        <%
        int cod_modulo=Integer.parseInt(request.getParameter("cod_modulo"));
        
                 ResultSet rs=null;
                 Statement st=null;
                  
               try{
                  
                 st=con3.getConexion().createStatement();
              rs=st.executeQuery("select * from modulo where cod_modulo= "+ cod_modulo +"");
              
              while(rs.next()){
                  
             
        %>
        <h1 aling=" center">Editar Producto</h1>
        <form action="">
            <table border="1" width="250" aling="center">
                
                    <tr>
                        <td>Id_producto:</td>
                        <td> <input type="text" name="cod_modulo" value="<%= rs.getString(1) %>" />  </td>
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
                        
                        <th colspan="2"> <input type="submit" value="EDITAR MODULO" name="editar" /> </th>
                    </tr>
            </table>
            
        </form>
                        <%
                            }
}catch(Exception e){}

if(request.getParameter("editar")!=null){

    String nombre=request.getParameter("nombre");
   String descripcion=request.getParameter("descripcion");
   
st.executeUpdate("update modulo set nombre='"+nombre+"',descripcion='"+descripcion+"' where cod_modulo="+cod_modulo+"");
request.getRequestDispatcher("list.jsp").forward(request, response);
}
    
%>
       
<form action="list.jsp" method="POST">
    <input type="submit" value="REGRESAR" name="list.jsp" />
</form>        
         
                    
            
        
    </body>
</html> 