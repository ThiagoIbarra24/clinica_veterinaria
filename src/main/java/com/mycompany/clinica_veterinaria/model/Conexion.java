
package com.mycompany.clinica_veterinaria.model;
import java.sql.Connection;
import java.sql.DriverManager;


//Este es mi clase singleton para la conexion a base de datos
public class Conexion {
    private static Connection instancia = null;
    private static final String URL =
        "jdbc:sqlserver://THIAGOLAPTOP:1433;" +
        "databaseName=clinica_veterinaria;" +
        "trustServerCertificate=true;";
    
    private static final String USER = "admin_clinica";
    private static final String PASSWORD = "Admin123*";
    
     public static Connection getConnection() {
        try {
            if (instancia == null || instancia.isClosed()) {
                instancia = DriverManager.getConnection(URL);
                System.out.println("Conexión exitosa a SQL Server");
            }
        } catch(Exception e) {
            System.out.println("Error de conexión: " + e.getMessage());
        }
        return instancia;     
}
     
     
             
   public static void cerrarConexion() {
        try {
            if (instancia != null && !instancia.isClosed()) {
                instancia.close();
                instancia = null;
                System.out.println("Conexión cerrada");
            }
        } catch (Exception e) {
            System.out.println("Error al cerrar: " + e.getMessage());
        }
   }
     
         }
