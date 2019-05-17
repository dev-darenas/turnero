package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lib.Bot;

/**
 *
 * @author jhoan
 */
@WebServlet(name = "ControlBot", urlPatterns = {"/ControlBot"})
public class ControlBot extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            System.out.println("************************************************************************");

            String perfil = request.getParameter("perfil");
            String numero = request.getParameter("numero");
            String turno = request.getParameter("turno");
            String accion = request.getParameter("accion");
            
            Bot bot = new Bot();
            
            bot.setPerfil(perfil);
            
            bot.conectarCuenta();           

            

//            bot.setPerfil(perfil);
//            bot.setNumero(numero);
//            bot.setMensaje("Su turno " + turno + "sera el proximo en ser atendido");
//
//            bot.iniciar();
//            bot.mandarAlerta();
            
            response.sendRedirect("/turnero/vistas/comunicacion/whatsapp/ConectarConModeloTurno.jsp");

        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
