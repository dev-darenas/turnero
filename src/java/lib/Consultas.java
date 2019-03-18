/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lib;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dahian
 */
public class Consultas extends Conexion {
    
    public boolean autenticacion(String email, String contrasena){
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try{
            String consulta = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
            pstm = getConexion().prepareCall(consulta);
            pstm.setString(1, email);
            pstm.setString(2, contrasena);
            
            rs = pstm.executeQuery();
            
            if(rs.absolute(1)){
                return true;
            }
        } catch(Exception ex){
             Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if(getConexion() != null) getConexion().close();
                if(pstm != null ) pstm.close();
                if(rs != null ) rs.close();
            } catch (Exception ex) {
                Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        return false;
    }
    
    public static void main(String[] args) {
        Consultas c = new Consultas();
        System.out.println("lib.Consultas.main()");
        c.autenticacion("darenas@gmail.com", "123456789");
    }
}
