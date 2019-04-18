
<%@page import="lib.ConexionUsuario"%>
<%@ page import= "java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Registro </title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        
        <div class="container">
            <div class="container-contact100">
		<div class="wrap-contact100">
                    <form class="contact100-form validate-form">
				<span class="contact100-form-title">
					Registrar Asesor
				</span>
				<div class="wrap-input100 input100-select bg1">
                                        <span class="label-input100">Tipo de documento</span>
                                        <div>
                                            <select class="js-select2" name="documento">
                                                <option>Cedula de ciudadania</option>
                                                <option>NIT</option>
                                                <option>Pasaporte</option>
                                            </select>
                                            <div class="dropDownSelect2"></div>
                                        </div>
				</div>
				<div class="wrap-input100 validate-input bg1" data-validate="Campo obligatorio">
                                    <span class="label-input100">No. del documento</span>
                                    <input class="input100" type="text" name="numero" placeholder="No. del documento">
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
					<span class="label-input100">Nombre(s)</span>
					<input class="input100" type="text" name="nombre" placeholder="Nombre">
				</div>

				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Campo obligatorio)">
					<span class="label-input100">Apellido(s)</span>
					<input class="input100" type="text" name="apellido" placeholder="Apellido">
				</div>
			
				<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
					<span class="label-input100">No. Celular</span>
					<input class="input100" type="text" name="celular" placeholder="Celular">
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
					<span class="label-input100">Correo electronico</span>
					<input class="input100" type="text" name="email" placeholder="E-mail">
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
					<span class="label-input100">Password</span>
					<input class="input100" type="text" name="poss" placeholder="Password">
				</div>			
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">ROL</span>
					<div>
						<select class="js-select2" name="documento">
							<option>Asesor</option>
							<option>Cajero</option>
							<option>Administrativo</option>
							</select>
						<div class="dropDownSelect2"></div>
					</div>
				</div>	
				<div class="container-contact100-form-btn">
					<button class="contact100-form-btn">
						<span>
							Agregar
							<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
						</span>
					</button>
				</div>
			</form>
		</div>
	</div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            <h1>Registro de Usuarios</h1>
            
            <form action = "" method= "post">
        <table border ="1" cellspacing ="4" cellpadding="6" bgcolor="WHITE">
            <tr>
                <td  bgcolor ="FF8E8E" colspan="2" align = "center" > <font face ="verdana"> <b> Ingrese los datos <b>             
                            </td>
                            </tr>
                            <tr>
                                <td> <b> Codigo </b> </td>
                                <td><input type = "text" name = "codigo"></td> 
                            </tr>
                            <tr>
                                <td> <b> Nombre </b> </td>
                                <td> <input type = "text" name = "nombre"></td> 
                            </tr>
                            <tr>
                                <td> <b> Apellido </b> </td>
                                <td> <input type = "text" name = "apellido"> <br> </td>
                            </tr>
                            <tr>
                                <td> <b> Cedula </b> </td>
                                <td> <input type = "text" name = "cedula"> </td>
                            </tr>
                            <tr>
                                <td> <b> Telefono </b> </td>
                                <td> <input type = "text" name = "telefono"> </td>
                            </tr>
                            <tr>
                                <td><b> Cargo </b> </td>
                                <td><select name = "cargo">
                                        <option> Cajero </option>
                                        <option> Asesor </option>
                                    </select> </td>
                            </tr>
                            <tr>

                                <td> <b> Email </b> </td>
                                <td> <input type = "text" name = "email"> </td>
                            </tr>
                            <tr>
                                <td> <b> Contraseña </b> </td>
                                <td><input type = "password" name = "password"> </td>
                            </tr>
                            </table><br>

                            <input type ="submit" value="Registrar"> 

                            </form>
        
        </div>
    <%@include file="/source/javascript/javalib.jsp" %>
    </body>
 
    <script>
        
    </script>
</html>
     
<% 
    
int codigo = 0; 
try {
    codigo = Integer.parseInt(request.getParameter("codigo"));
} catch(NumberFormatException e) {  
} 

String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String cedula = request.getParameter("cedula");
String telefono = request.getParameter("telefono");
String cargo = request.getParameter("cargo");
String email = request.getParameter("email");
String password = request.getParameter("password");
String estado = "Activo";

ConexionUsuario conexion = new ConexionUsuario();

 if (conexion.registro(codigo, nombre, apellido, cedula, telefono, cargo, email, password, estado)) {
    response.sendRedirect("Consulta.jsp");
    conexion.desconectar();
}

%>
                                

   