/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;
import java.sql.ResultSet;
import lib.Consultas;
        
public class Usuario {
    String email;
    String password;

    public Usuario(String email, String password) {
        this.email = email;
        this.password = password;
    }
    
    public boolean hacer_login(){
        Consultas co = new Consultas();
        return co.autenticacion(email, password);
    }
    
    public static String rol_name(String rol_id){
        String rol = "";
        switch(rol_id){
            case "1":
                rol = "Administracion";
            break;
            case "2":
                rol = "Asesor";
            break;
            case "3":
                rol = "Cajero";
            break;
            default:
                rol = "";
        }
       return rol; 
    }
    
    public ResultSet get_iduser(){
        Consultas co = new Consultas();
        return co.get_user(email, password);
    }
}