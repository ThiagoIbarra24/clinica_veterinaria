package com.mycompany.clinica_veterinaria.model;

public class Mascota {
    private int id_mascota;
    private String nombre_m;
    private String especie;
    private String raza;
    private int edad;
    private double peso;
    private String estado;
    private int id_cliente;          // el dueño (FK)
    private String nombreDueno;      // para mostrar el nombre del dueño en la tabla

    // Constructor vacío
    public Mascota() {
    }

    // Getters y Setters
    public int getId_mascota() {
        return id_mascota;
    }
    public void setId_mascota(int id_mascota) {
        this.id_mascota = id_mascota;
    }

    public String getNombre_m() {
        return nombre_m;
    }
    public void setNombre_m(String nombre_m) {
        this.nombre_m = nombre_m;
    }

    public String getEspecie() {
        return especie;
    }
    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public String getRaza() {
        return raza;
    }
    public void setRaza(String raza) {
        this.raza = raza;
    }

    public int getEdad() {
        return edad;
    }
    public void setEdad(int edad) {
        this.edad = edad;
    }

    public double getPeso() {
        return peso;
    }
    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getId_cliente() {
        return id_cliente;
    }
    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getNombreDueno() {
        return nombreDueno;
    }
    public void setNombreDueno(String nombreDueno) {
        this.nombreDueno = nombreDueno;
    }
}