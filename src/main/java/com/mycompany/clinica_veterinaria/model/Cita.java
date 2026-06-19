package com.mycompany.clinica_veterinaria.model;

public class Cita {
    private int id_cita;
    private String fecha_hora;        // fecha y hora de la cita
    private String motivo;
    private String estado_cita;       // Pendiente / Confirmada / Cancelada
    private String estado;            // Activo / Inactivo (auditoría)
    private int id_mascota;
    private int id_usuario;           // el veterinario
    private int id_cliente;

    // Campos extra para mostrar nombres en la tabla (no son columnas)
    private String nombreMascota;
    private String nombreVeterinario;
    private String nombreCliente;

    public Cita() {
    }

    // Getters y Setters
    public int getId_cita() { return id_cita; }
    public void setId_cita(int id_cita) { this.id_cita = id_cita; }

    public String getFecha_hora() { return fecha_hora; }
    public void setFecha_hora(String fecha_hora) { this.fecha_hora = fecha_hora; }

    public String getMotivo() { return motivo; }
    public void setMotivo(String motivo) { this.motivo = motivo; }

    public String getEstado_cita() { return estado_cita; }
    public void setEstado_cita(String estado_cita) { this.estado_cita = estado_cita; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getId_mascota() { return id_mascota; }
    public void setId_mascota(int id_mascota) { this.id_mascota = id_mascota; }

    public int getId_usuario() { return id_usuario; }
    public void setId_usuario(int id_usuario) { this.id_usuario = id_usuario; }

    public int getId_cliente() { return id_cliente; }
    public void setId_cliente(int id_cliente) { this.id_cliente = id_cliente; }

    public String getNombreMascota() { return nombreMascota; }
    public void setNombreMascota(String nombreMascota) { this.nombreMascota = nombreMascota; }

    public String getNombreVeterinario() { return nombreVeterinario; }
    public void setNombreVeterinario(String nombreVeterinario) { this.nombreVeterinario = nombreVeterinario; }

    public String getNombreCliente() { return nombreCliente; }
    public void setNombreCliente(String nombreCliente) { this.nombreCliente = nombreCliente; }
}