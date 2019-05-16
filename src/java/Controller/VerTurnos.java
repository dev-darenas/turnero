/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.resource.cci.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lib.ConexionAbrirModulo;

/**
 *
 * @author Dahian
 */
@WebServlet(name = "VerTurnos", urlPatterns = {"/VerTurnos"})
public class VerTurnos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        StringBuffer data = null;
        
        try (PrintWriter out = response.getWriter()) {
            ConexionAbrirModulo conexion = new ConexionAbrirModulo();
            
            java.sql.ResultSet turno_modulos = conexion.getTurnoModulos();
            
            String turnos_json = "{ \"turnos\": [";
            
            while(turno_modulos.next()){
                turnos_json += " { \"id\": \" "+ turno_modulos.getString("id") +" \", \"nombre\": \" "+ turno_modulos.getString("nombre") +" \", \"turno\": \" "+ turno_modulos.getString("p") +" "+ turno_modulos.getString("num_turno") +" \" } ";
                if (!turno_modulos.isAfterLast()) {
                   turnos_json += ",";
                }
            }
            
            turnos_json += "]}";
            
            data = new StringBuffer(turnos_json);
            response.getWriter().write(data.toString());
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
        } catch (SQLException ex) {
            Logger.getLogger(VerTurnos.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(VerTurnos.class.getName()).log(Level.SEVERE, null, ex);
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
