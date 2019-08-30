/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lib.ConexionAbrirModulo;

/**
 *
 * @author Dahian
 */
@WebServlet(name = "abrirModulo", urlPatterns = {"/abrirModulo"})
public class abrirModulo extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            Cookie[] cookieList = request.getCookies();
            
            String user_id = "";
            String id_rol = "";
            for (int i = 0; i < cookieList.length; i++) { 
                if(cookieList[i].getName().equals("id_user")){
                    user_id = cookieList[i].getValue();
                }
            } 

            ResultSet resultado1;
            String nombre = "";

            ConexionAbrirModulo conexion = new ConexionAbrirModulo();
            int id_usuario = Integer.parseInt(user_id);
            String id_modulo = "";

            if(request.getParameter("id_modulo") != null ){
                id_modulo = request.getParameter("id_modulo");

                conexion.ActivarModulo(id_modulo, id_usuario);
                conexion.OcuparModulo(id_modulo);  

                ResultSet resultado2;
                int codigo;

                resultado2 = conexion.codigo(id_modulo, id_usuario);
                resultado2.next();

                codigo = resultado2.getInt("id");
                nombre = resultado2.getString("nombre");
                        
                conexion.desconectar();
                
                response.sendRedirect("/turnero/vistas/activacionModulo/ModeloTurno.jsp?codigo="+codigo+"&nombre="+nombre); 
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(abrirModulo.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(abrirModulo.class.getName()).log(Level.SEVERE, null, ex);
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
