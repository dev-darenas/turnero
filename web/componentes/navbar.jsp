<%
    Cookie[] cookieList = request.getCookies();
    String id_rol = "";
    for (int i = 0; i < cookieList.length; i++) { 
        if(cookieList[i].getName().equals("id_rol")){
            id_rol = cookieList[i].getValue();
        }
    } 
%>

<header id="header">
    <nav class="menu">
        <div class="logo">
            <a href="/turnero/dashboard.jsp"><img src="/turnero/source/img/LogoCompletoFinalReducido.png"></a>
            <a href="" class="btn-menu" id="btn-menu">
            <i class="fas fa-bars"></i></a>
        </div>
        <div class="enlaces">
            <% if(id_rol.equalsIgnoreCase("1")){ %>
              <a href="/turnero/vistas/clientes/RegistroClientes.jsp">Clientes</a>
              <a href="/turnero/vistas/usuarios/Consulta.jsp">Usuarios</a>
              <a href="/turnero/vistas/producto/list.jsp">Producto</a>
              <a href="/turnero/vistas/modulo/list.jsp">Modulo</a>
            <% }else if(id_rol.equalsIgnoreCase("2")){ %>
                <a href="/turnero/vistas/clientes/RegistroClientes.jsp">Clientes</a>
            <% } %>
            <a href="/turnero/vistas/activacionModulo/AbrirModulo.jsp">Atender</a>
            <a href="/turnero/vistas/turno/generar.jsp">Generar Turno</a>
            <a href="/turnero/vistas/turno/index.jsp" target="_black">TV</a>
            <a href="/turnero/destroySession">Salir</a>
        </div>
    </nav>
</header>
