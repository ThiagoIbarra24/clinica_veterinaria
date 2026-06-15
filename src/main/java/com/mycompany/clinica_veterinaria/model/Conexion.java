
package com.mycompany.clinica_veterinaria.model;
import java.sql.Connection;
import java.sql.DriverManager;


//Este es mi clase singleton para la conexion a base de datos
public class Conexion {
   private static Connection instancia = null;
    public static String ultimoError = "sin intento";

    // Lee las variables de entorno que Railway inyecta automáticamente
    private static final String HOST = System.getenv("PGHOST");
    private static final String PORT = System.getenv("PGPORT");
    private static final String DB = System.getenv("PGDATABASE");
    private static final String USER = System.getenv("PGUSER");
    private static final String PASSWORD = System.getenv("PGPASSWORD");

    public static Connection getConnection() {
        try {
            if (instancia == null || instancia.isClosed()) {
                Class.forName("org.postgresql.Driver");

                String url = "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DB;
                instancia = DriverManager.getConnection(url, USER, PASSWORD);
                ultimoError = "CONEXION EXITOSA";
            }
        } catch (Exception e) {
            ultimoError = e.getClass().getName() + " --- " + e.getMessage();
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
