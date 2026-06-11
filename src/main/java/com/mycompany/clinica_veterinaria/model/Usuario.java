
package com.mycompany.clinica_veterinaria.model;


public class Usuario {
    protected int id_usuario;
    protected String usuario_n;
    protected String password;
    protected String nombre;
    protected String apellido;
    protected String rol;
    protected String estado;
    
    public Usuario(){}

    public Usuario(int id_usuario, String usuario_n, String password, String nombre, String apellido, String rol, String estado) {
        this.id_usuario = id_usuario;
        this.usuario_n = usuario_n;
        this.password = password;
        this.nombre = nombre;
        this.apellido = apellido;
        this.rol = rol;
        this.estado = estado;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario_n() {
        return usuario_n;
    }

    public void setUsuario_n(String usuario_n) {
        this.usuario_n = usuario_n;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }


    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
 
    public String getMenuPrincipal(){
        return "Menu general";
    }
    
}
