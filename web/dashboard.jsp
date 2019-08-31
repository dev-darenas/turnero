<%-- 

    Document   : pagina2
    Created on : 25/02/2019, 07:29:09 PM
    Author     : Dahian
--%>

<%@page import="lib.ConexionAbrirModulo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="lib.ConsultaTurno"%>
<%@page import="Controller.CantidadAtenciones"%>
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
                  <p class="card-text"><%= promedio_espera%> Minutos</p>
                  <a href="/turnero/vistas/reporte/historico_turnos.jsp" class="btn btn-primary">Ver Reporte</a>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">Tiempo Promedio de Atencion</h5>
                  <p class="card-text"><%= promedio_atencion%> Minutos</p>
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
            <% if (turnos_atendiendo.next()) {
                do {%>
            <li class="list-group-item"> <%= turnos_atendiendo.getString("nombre")%> -  <%= turnos_atendiendo.getString("p")%> <%= turnos_atendiendo.getString("tp")%> <%= turnos_atendiendo.getString("num_turno")%></li>
              <% } while (turnos_atendiendo.next());
              } else { %>
            <li class="list-group-item">No hay turnos siendo atendidos</li>
              <% }; %>
          </ul>
          <h4>Turnos en Espera</h4>
          <ul class="list-group">
            <% if (turnos.next()) {
                do {%>
            <li class="list-group-item  
                <% if (turnos.getString("p").equalsIgnoreCase("P")) {%>
                <%= "list-group-item-warning"%>
                <% }%>
                "><%= turnos.getString("p")%> <%= turnos.getString("tp")%> <%= turnos.getString("num_turno")%> Tiempo de Espera-> <%= turnos.getString("diff")%> minutos </li>
              <% } while (turnos.next());
              } else { %>
            <li class="list-group-item">No hay turnos en espera</li>
              <% }; %>
          </ul>
        </div>
      </div>
    </div>
    <% con.cierraConexion(); %>
    <% con2.desconectar();%>
    <%@include file="/source/javascript/javalib.jsp" %>
  </body>

  <%

  %>

  <script type="text/javascript">

    // Load the Visualization API and the corechart package.
    google.charts.load('current', {'packages': ['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);

    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {
      $.ajax(
              'CantidadAtenciones'
              ).done((data) => {
        console.log(data);
        data = data.replace(",]", "]");
        data = JSON.parse(data);
        let value = data.total_atentions_list;
        let sieteam; 
        let ochoam; let nueveam; let diezam;
        let onceam; let docepm; let unopm;
        let dospm; let trespm; let cuatropm;
        let cincopm; let seispm; let sietepm;
        for (let x in value) {
          if (value[x].hora === "7") { sieteam = parseInt(value[x].cantidad); };
          if (value[x].hora === "8") { ochoam = parseInt(value[x].cantidad); };
          if (value[x].hora === "9") { nueveam = parseInt(value[x].cantidad); };
          if (value[x].hora === "10") { diezam = parseInt(value[x].cantidad); };
          if (value[x].hora === "11") { onceam = parseInt(value[x].cantidad); };
          if (value[x].hora === "12") { docepm = parseInt(value[x].cantidad); };
          if (value[x].hora === "13") { unopm = parseInt(value[x].cantidad); };
          if (value[x].hora === "14") { dospm = parseInt(value[x].cantidad); };
          if (value[x].hora === "15") { trespm = parseInt(value[x].cantidad); };
          if (value[x].hora === "16") { cuatropm = parseInt(value[x].cantidad); };
          if (value[x].hora === "17") { cincopm = parseInt(value[x].cantidad); };
          if (value[x].hora === "18") { seispm = parseInt(value[x].cantidad); };
          if (value[x].hora === "19") { sietepm = parseInt(value[x].cantidad); };
        }
        let table = new google.visualization.DataTable();
        table.addColumn('timeofday', 'Time of Day');
        table.addColumn('number', 'Cantidad de personas');
        table.addRows([
          [{v: [7, 0, 0], f: '7 am'}, sieteam],
          [{v: [8, 0, 0], f: '8 am'}, ochoam],
          [{v: [9, 0, 0], f: '9 am'}, nueveam],
          [{v: [10, 0, 0], f: '10 am'}, diezam],
          [{v: [11, 0, 0], f: '11 am'}, onceam],
          [{v: [12, 0, 0], f: '12 pm'}, docepm],
          [{v: [13, 0, 0], f: '1 pm'}, unopm],
          [{v: [14, 0, 0], f: '2 pm'}, dospm],
          [{v: [15, 0, 0], f: '3 pm'}, trespm],
          [{v: [16, 0, 0], f: '4 pm'}, cuatropm],
          [{v: [17, 0, 0], f: '5 pm'}, cincopm],
          [{v: [18, 0, 0], f: '6 pm'}, seispm],
          [{v: [19, 0, 0], f: '7 pm'}, sietepm],
        ]);
        var options = {
          title: 'Total de Personas Atendidas',
          vAxis: {
            title: 'Personas Atendidas'
          }
        };
        var chart = new google.visualization.ColumnChart(
                document.getElementById('chart_div'));
        chart.draw(table, options);
        });
      };
  </script>
</html>