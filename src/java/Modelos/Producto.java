package Modelos;


public class Producto {
    private int id_producto;
private String nombre;
private String estado;
private String descripcion;

public Producto(int id_producto, String nombre,String estado, String descripcion) {
        this.nombre = nombre;
        this.estado=estado;
        this.descripcion = descripcion;
        this.id_producto=id_producto;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
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