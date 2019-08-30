<%-- 

    Document   : pagina2
    Created on : 25/02/2019, 07:29:09 PM
    Author     : Dahian
--%>

<%@page import="lib.ConexionAbrirModulo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="lib.ConsultaTurno"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <%
            ConsultaTurno con = new ConsultaTurno();
            ResultSet turnos = con.obtenerTurnos();
            int promedio_espera = con.promedioEspera();
            int promedio_atencion = con.promedioAtencio();
            ConexionAbrirModulo con2 = new ConexionAbrirModulo();
            ResultSet turnos_atendiendo = con2.getTurnoModulos();
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-6">

                    <div class="row">
                      <div class="col-sm-6">
                        <div class="card">
                          <div class="card-body">
                            <h5 class="card-title">Tiempo Promedio de Espera</h5>
                            <p class="card-text"><%= promedio_espera %> Minutos</p>
                            <a href="/turnero/vistas/reporte/historico_turnos.jsp" class="btn btn-primary">Ver Reporte</a>
                          </div>
                        </div>
                      </div>
                      <div class="col-sm-6">
                        <div class="card">
                          <div class="card-body">
                            <h5 class="card-title">Tiempo Promedio de Atencion</h5>
                            <p class="card-text"><%= promedio_atencion %> Minutos</p>
                            <a href="/turnero/vistas/reporte/historico_turnos.jsp" class="btn btn-primary">Ver Reporte</a>
                          </div>
                        </div>
                      </div>
                    </div>
                    <hr>
                    <div id="chart_div"></div>
                </div>
                <div class="col-md-6">
                    <h4>Turnos Atendiendo</h4>
                    <ul class="list-group">
                        <% while(turnos_atendiendo.next()){ %>
                            <li class="list-group-item"> <%= turnos_atendiendo.getString("nombre") %> -  <%= turnos_atendiendo.getString("p") %> <%= turnos_atendiendo.getString("tp") %> <%= turnos_atendiendo.getString("num_turno") %></li>
                        <% } %>
                    </ul>
                    <h4>Turnos en espera</h4>
                    <ul class="list-group">
                        <% while(turnos.next()){ %>
                        <li class="list-group-item  
                            <% if(turnos.getString("p").equalsIgnoreCase("P")) { %>
                                <%= "list-group-item-warning" %>
                               <% } %>
                            "><%= turnos.getString("p") %> <%= turnos.getString("tp") %> <%= turnos.getString("num_turno") %> Tiempo de Espera-> <%= turnos.getString("diff") %> minutos </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
        <% con.cierraConexion(); %>
        <% con2.desconectar(); %>
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
    
    <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('timeofday', 'Time of Day');
        data.addColumn('number', 'Cantidad de personas');

        data.addRows([
          [{v: [8, 0, 0], f: '7 am'}, 11],
          [{v: [8, 0, 0], f: '8 am'}, 21],
          [{v: [9, 0, 0], f: '9 am'}, 24],
          [{v: [10, 0, 0], f:'10 am'}, 33],
          [{v: [11, 0, 0], f: '11 am'}, 40],
          [{v: [12, 0, 0], f: '12 pm'}, 32],
          [{v: [13, 0, 0], f: '1 pm'}, 62],
          [{v: [14, 0, 0], f: '2 pm'}, 45],
          [{v: [15, 0, 0], f: '3 pm'}, 44],
          [{v: [16, 0, 0], f: '4 pm'}, 93],
          [{v: [17, 0, 0], f: '5 pm'}, 54],
          [{v: [18, 0, 0], f: '6 pm'}, 60],
          [{v: [19, 0, 0], f: '7 pm'}, 50],
        ]);

        var options = {
          title: 'Total de Personas Atendidas',

          vAxis: {
            title: 'Personas Atendidas'
          }
        };

        var chart = new google.visualization.ColumnChart(
          document.getElementById('chart_div'));

        chart.draw(data, options);
      }
    </script>
</html>