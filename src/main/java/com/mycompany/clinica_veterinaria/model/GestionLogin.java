package com.mycompany.clinica_veterinaria.model;
//Paquetes para base de datos
import java.sql.Connection;//Interfaz de conexion, sirve para que nos podamos comunicar no la base de datos, sirve para crear una conexión
import java.sql.PreparedStatement;//Sirve para ejecutar consultas sql 
import java.sql.ResultSet;//Guarda los resultados de las consultas sql
        

public class GestionLogin {
  
    
    //Funcion de autenticación para validar a los 3 usuarios principales que ingresan al sistema
    public Usuario autenticar(String usuario_n, String password){//Se pide por parámetros el nombre del usuario y la contraseña
        Usuario usuario = null;
        Connection con = Conexion.getConnection();
        
        String sql = "SELECT * FROM Usuario WHERE usuario_n = ? AND password = ? AND estado = 'Activo'";
        
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario_n);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                String rol = rs.getString("rol");
                
                switch(rol){
                    case "Admin":
                            usuario = new Admin(
                            rs.getInt("id_usuario"),
                            rs.getString("usuario_n"),
                            rs.getString("password"),
                            rs.getString("nombre"),
                            rs.getString("apellido"),
                            rs.getString("rol"),
                            rs.getString("estado")
                        );
                            break;
                    case "Veterinario":
                            usuario = new Veterinario(
                            rs.getString("especialidad"),
                            rs.getInt("id_usuario"),
                            rs.getString("usuario_n"),
                            rs.getString("password"),
                            rs.getString("nombre"),
                            rs.getString("apellido"),
                            rs.getString("rol"),
                            rs.getString("estado")
                            );
                            break;
                    case "Recepcionista":
                            usuario = new Recepcionista(
                            rs.getInt("id_usuario"),
                            rs.getString("usuario_n"),
                            rs.getString("password"),
                            rs.getString("nombre"),
                            rs.getString("apellido"),
                            rs.getString("rol"),
                            rs.getString("estado")
                            );
                                    
                        break;
                    
                    
                }
                
                  
            }
                rs.close();
                ps.close();
        }catch (Exception e) {
            System.out.println("Error en autenticación: " + e.getMessage());
        }
        
        return usuario;
    }
    
}
