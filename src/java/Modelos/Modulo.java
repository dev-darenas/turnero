

package Modelos;

public class Modulo {
private int cod_modulo;
private String nombre;
private String estado;
private String descripcion;


public Modulo(int cod_modulo, String nombre,String estado, String descripcion) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.estado=estado;
        this.cod_modulo=cod_modulo;
    }

    public String getNombre() {
        return nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public int getCod_modulo() {
        return cod_modulo;
    }

    public void setCod_modulo(int cod_modulo) {
        this.cod_modulo = cod_modulo;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
    
}

    

