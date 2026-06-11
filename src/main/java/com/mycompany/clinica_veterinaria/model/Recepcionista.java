package com.mycompany.clinica_veterinaria.model;

public class Recepcionista extends Usuario{

    public Recepcionista(){}

    public Recepcionista(int id_usuario, String usuario_n, String password, String nombre, String apellido, String rol, String estado) {
        super(id_usuario, usuario_n, password, nombre, apellido, rol, estado);
    }

    
    @Override
    public String getMenuPrincipal(){
        return "menuRecepcionista.jsp";
    }
    
    
}
