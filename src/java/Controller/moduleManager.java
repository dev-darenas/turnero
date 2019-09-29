package Controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lib.ConexionAbrirModulo;

@WebServlet(name = "moduleManager", urlPatterns = {"/moduleManager"})
public class moduleManager extends HttpServlet {

  public volatile String status;
  String id_usuario;

  public moduleManager() {
    setStatus("activo");
    hilo h = new hilo();
    h.start();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    System.out.println("Controller.moduleManager()");
    String estado = request.getParameter("estado");
    id_usuario = request.getParameter("id_usuario");
    setStatus(estado);
  }

  public class hilo extends Thread {

    @Override
    public synchronized void run() {
      while (true) {
        if (getStatus().equals("inactivo")) {
          ConexionAbrirModulo ca = new ConexionAbrirModulo();
          ca.actualizacionModulo(id_usuario);
          ca.cierraConexion();
          System.out.println("estado: " + getStatus() + " usuario: " + id_usuario);
          setStatus("espera");
        } else if (getStatus().equals("activo")) {
          System.out.println("estado: " + getStatus() + " usuario: " + id_usuario);
          setStatus("inactivo");
        }
        try {
          this.wait(20000);
        } catch (InterruptedException ex) {
          Logger.getLogger(moduleManager.class.getName()).log(Level.SEVERE, null, ex);
        }
      }
    }
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
