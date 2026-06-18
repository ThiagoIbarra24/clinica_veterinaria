package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MascotaDAO {

    // LEER: lista las mascotas activas, incluyendo el nombre del dueño (con JOIN)
    public List<Mascota> listar() {
        List<Mascota> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT m.*, c.nombre AS nombre_cliente, c.apellido AS apellido_cliente " +
                     "FROM Mascota m " +
                     "INNER JOIN Cliente c ON m.id_cliente = c.id_cliente " +
                     "WHERE m.estado = 'Activo' ORDER BY m.id_mascota";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Mascota m = new Mascota();
                m.setId_mascota(rs.getInt("id_mascota"));
                m.setNombre_m(rs.getString("nombre_m"));
                m.setEspecie(rs.getString("especie"));
                m.setRaza(rs.getString("raza"));
                m.setEdad(rs.getInt("edad"));
                m.setPeso(rs.getDouble("peso"));
                m.setEstado(rs.getString("estado"));
                m.setId_cliente(rs.getInt("id_cliente"));
                // Combinamos nombre + apellido del dueño
                m.setNombreDueno(rs.getString("nombre_cliente") + " " + rs.getString("apellido_cliente"));
                lista.add(m);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar mascotas: " + e.getMessage());
        }

        return lista;
    }

    // CREAR: inserta una nueva mascota
    public boolean insertar(Mascota m) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "INSERT INTO Mascota (nombre_m, especie, raza, edad, peso, estado, fecha_creacion, usuario_creacion, id_cliente) " +
                     "VALUES (?, ?, ?, ?, ?, 'Activo', NOW(), 'sistema', ?)";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, m.getNombre_m());
            ps.setString(2, m.getEspecie());
            ps.setString(3, m.getRaza());
            ps.setInt(4, m.getEdad());
            ps.setDouble(5, m.getPeso());
            ps.setInt(6, m.getId_cliente());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al insertar mascota: " + e.getMessage());
        }

        return exito;
    }

    // ELIMINAR (lógico)
    public boolean eliminar(int id_mascota) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Mascota SET estado = 'Inactivo', fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_mascota = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id_mascota);

            int filas = ps.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al eliminar mascota: " + e.getMessage());
        }

        return exito;
    }

    // ACTUALIZAR
    public boolean actualizar(Mascota m) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Mascota SET nombre_m = ?, especie = ?, raza = ?, edad = ?, peso = ?, id_cliente = ?, " +
                     "fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_mascota = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, m.getNombre_m());
            ps.setString(2, m.getEspecie());
            ps.setString(3, m.getRaza());
            ps.setInt(4, m.getEdad());
            ps.setDouble(5, m.getPeso());
            ps.setInt(6, m.getId_cliente());
            ps.setInt(7, m.getId_mascota());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al actualizar mascota: " + e.getMessage());
        }

        return exito;
    }
}