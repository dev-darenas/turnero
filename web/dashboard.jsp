<%-- 
    Document   : pagina2
    Created on : 25/02/2019, 07:29:09 PM
    Author     : Dahian
--%>

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
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div id="chart_div"></div>
                </div>
                <div class="col-md-6">
                    <h4>Turnos</h4>
                    <ul class="list-group">
                      <li class="list-group-item">C - 10</li>
                      <li class="list-group-item">A - 2</li>
                      <li class="list-group-item">A - 3</li>
                      <li class="list-group-item">A - 4</li>
                      <li class="list-group-item">C - 11</li>
                    </ul>
                </div>
            </div>
        </div>
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

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Mushrooms', 3],
          ['Onions', 1],
          ['Olives', 1],
          ['Zucchini', 1],
          ['Pepperoni', 2]
        ]);

        // Set chart options
        var options = {'title':'How Much Pizza I Ate Last Night',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
</html>
