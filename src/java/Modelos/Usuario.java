/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;
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
}
