package Controller;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "GenerarTurno", urlPatterns = {"/GenerarTurno"})
public class GenerarTurno extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            System.out.println("entra al controller");

            String cedula = request.getParameter("cedula");
            String celular = request.getParameter("celular");
            String correo = request.getParameter("correo");
            String tipoServicio = request.getParameter("tiposervicio");
            String prioridad = request.getParameter("prioridad");
            String notwhatsapp = request.getParameter("notificacion_whatsapp");
            String notemail = request.getParameter("notificacion_email");
            String notsms = request.getParameter("notificacion_sms");

            ConsultaTurno co = new ConsultaTurno();

            String turno = co.crearTurno(cedula, celular, correo, tipoServicio, Integer.parseInt(prioridad), Integer.parseInt(notwhatsapp), Integer.parseInt(notemail), Integer.parseInt(notsms));
            if (!turno.equals("")) {
                response.sendRedirect("vistas/usuarios/ ventana true turno");
            } else {
                response.sendRedirect("vistas/usuarios/ ventana false turno");
            }

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
