package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lib.ConsultaReporte;

/**
 *
 * @author jhoan
 */
@WebServlet(name = "GenerarReporte", urlPatterns = {"/GenerarReporte"})
public class GenerarReporte extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            System.out.println("************************************************************************");

            String fechaIni = request.getParameter("fechaini");
            String fechaFin = request.getParameter("fechafin");
            String usuario = request.getParameter("usuario");
            String checkPrioridad = request.getParameter("prioridad");
            String checkTitular = request.getParameter("titular");
            String checkParticular = request.getParameter("particular");
            int total = Integer.parseInt(request.getParameter("total"));

            ConsultaReporte cr = new ConsultaReporte();
            System.out.println("Controller.GenerarTurno.processRequest()");
            //se guarda el arraylist y se envia
            List<List<String>> datos = cr.generarReporte(fechaIni, fechaFin, usuario, checkPrioridad, checkTitular, checkParticular);
            response.sendRedirect("/turnero/vistas/turno/generar.jsp?datos=" + datos);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(GenerarReporte.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(GenerarReporte.class.getName()).log(Level.SEVERE, null, ex);
        }
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
