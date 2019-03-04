/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

public class Usuario {
    String nombre;
    String password;

    public Usuario(String nombre, String password) {
        this.nombre = nombre;
        this.password = password;
    }
    
    public boolean hacer_login(){
        //Aqui es donde nos deberiamos comunicar con la bd para verificas que el ususrio exista
        return true;
    }
}
