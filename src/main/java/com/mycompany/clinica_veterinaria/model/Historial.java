package com.mycompany.clinica_veterinaria.model;

public class Historial {
    private int id_historial;
    private String diagnostico;
    private String tratamiento;
    private String observacion;
    private String estado;
    private int id_cita;
    private int id_mascota;

    // Campos extra para mostrar en la tabla (no son columnas)
    private String nombreMascota;
    private String motivoCita;
    private String fechaCita;

    public Historial() {
    }

    // Getters y Setters
    public int getId_historial() { return id_historial; }
    public void setId_historial(int id_historial) { this.id_historial = id_historial; }

    public String getDiagnostico() { return diagnostico; }
    public void setDiagnostico(String diagnostico) { this.diagnostico = diagnostico; }

    public String getTratamiento() { return tratamiento; }
    public void setTratamiento(String tratamiento) { this.tratamiento = tratamiento; }

    public String getObservacion() { return observacion; }
    public void setObservacion(String observacion) { this.observacion = observacion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getId_cita() { return id_cita; }
    public void setId_cita(int id_cita) { this.id_cita = id_cita; }

    public int getId_mascota() { return id_mascota; }
    public void setId_mascota(int id_mascota) { this.id_mascota = id_mascota; }

    public String getNombreMascota() { return nombreMascota; }
    public void setNombreMascota(String nombreMascota) { this.nombreMascota = nombreMascota; }

    public String getMotivoCita() { return motivoCita; }
    public void setMotivoCita(String motivoCita) { this.motivoCita = motivoCita; }

    public String getFechaCita() { return fechaCita; }
    public void setFechaCita(String fechaCita) { this.fechaCita = fechaCita; }
}