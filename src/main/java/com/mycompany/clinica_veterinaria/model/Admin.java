
package com.mycompany.clinica_veterinaria.model;


public class Admin extends Usuario{
    
    public Admin(){ 
    }

    public Admin(int id_usuario, String usuario_n, String password, String nombre, String apellido, String rol, String estado) {
        super(id_usuario, usuario_n, password, nombre, apellido, rol, estado);
    }

     
        @Override
        public String getMenuPrincipal(){
            return "menuAdmin.jsp";
            
        }
        public void editrUsuario(){
            System.out.println("Editando usuario ...");
        }
        
       
}
