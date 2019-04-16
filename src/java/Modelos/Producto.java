package Modelos;


public class Producto {
    private int id_producto;
private String nombre;
private String descripcion;

public Producto(int id_producto, String nombre, String descripcion) {
        this.nombre = nombre;
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

}