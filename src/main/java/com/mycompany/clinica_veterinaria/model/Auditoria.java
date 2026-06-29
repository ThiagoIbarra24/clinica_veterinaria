package com.mycompany.clinica_veterinaria.model;

public class Auditoria {
    private int id_auditoria;
    private String usuario;
    private String rol;
    private String accion;
    private String modulo;
    private String descripcion;
    private String fecha_hora;

    public Auditoria() {
    }

    public int getId_auditoria() { return id_auditoria; }
    public void setId_auditoria(int id_auditoria) { this.id_auditoria = id_auditoria; }

    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public String getAccion() { return accion; }
    public void setAccion(String accion) { this.accion = accion; }

    public String getModulo() { return modulo; }
    public void setModulo(String modulo) { this.modulo = modulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getFecha_hora() { return fecha_hora; }
    public void setFecha_hora(String fecha_hora) { this.fecha_hora = fecha_hora; }
}