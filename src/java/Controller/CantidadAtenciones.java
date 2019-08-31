package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lib.ConsultaTurno;

/**
 *
 * @author jhoan
 */
@WebServlet(name = "CantidadAtenciones", urlPatterns = {"/CantidadAtenciones"})
public class CantidadAtenciones extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    StringBuffer data = null;
    try (PrintWriter out = response.getWriter()) {
      System.out.println("Controller.CantidadAtenciones.processRequest()");
      ConsultaTurno ct = new ConsultaTurno();

      ResultSet datos = ct.obtenerTurnosAtendidos();

      String lista_json = "{\"total_atentions_list\":[";

      while (datos.next()) {
        lista_json += " {\"hora\":\"" + datos.getString("hora") + "\",\"cantidad\":\"" + datos.getString("cantidad") + "\" } ";
        if (!datos.isAfterLast()) {
          lista_json += ",";
        }
      }
      lista_json += "]}";
      System.out.println(lista_json);
      data = new StringBuffer(lista_json);
      response.getWriter().write(data.toString());
    } catch (SQLException ex) {
      Logger.getLogger(CantidadAtenciones.class.getName()).log(Level.SEVERE, null, ex);
    }
  }
}
