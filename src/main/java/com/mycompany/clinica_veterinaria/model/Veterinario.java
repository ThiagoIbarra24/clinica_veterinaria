package com.mycompany.clinica_veterinaria.model;

public class Veterinario extends Usuario{

    private String especialidad;
    
    public Veterinario() {
    }

    public Veterinario(String especialidad, int id_usuario, String usuario_n, String password, String nombre, String apellido, String rol, String estado) {
        super(id_usuario, usuario_n, password, nombre, apellido, rol, estado);
        this.especialidad = especialidad;
    }

    
    public void getEspecialidad(String especialidad){
        this.especialidad = especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }


    @Override
    public String getMenuPrincipal(){
        return "menuVeterinario.jsp";
        
    }
    
    
}
