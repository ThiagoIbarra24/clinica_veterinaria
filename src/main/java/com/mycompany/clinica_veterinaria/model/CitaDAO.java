package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    // LEER: lista las citas activas con nombres de mascota, veterinario y cliente (triple JOIN)
    public List<Cita> listar() {
        List<Cita> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT ci.*, " +
                     "m.nombre_m AS nombre_mascota, " +
                     "u.nombre AS nombre_vet, u.apellido AS apellido_vet, " +
                     "c.nombre AS nombre_cli, c.apellido AS apellido_cli " +
                     "FROM Cita ci " +
                     "INNER JOIN Mascota m ON ci.id_mascota = m.id_mascota " +
                     "INNER JOIN Usuario u ON ci.id_usuario = u.id_usuario " +
                     "INNER JOIN Cliente c ON ci.id_cliente = c.id_cliente " +
                     "WHERE ci.estado = 'Activo' ORDER BY ci.fecha_hora";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cita ci = new Cita();
                ci.setId_cita(rs.getInt("id_cita"));
                ci.setFecha_hora(rs.getString("fecha_hora"));
                ci.setMotivo(rs.getString("motivo"));
                ci.setEstado_cita(rs.getString("estado_cita"));
                ci.setEstado(rs.getString("estado"));
                ci.setId_mascota(rs.getInt("id_mascota"));
                ci.setId_usuario(rs.getInt("id_usuario"));
                ci.setId_cliente(rs.getInt("id_cliente"));
                ci.setNombreMascota(rs.getString("nombre_mascota"));
                ci.setNombreVeterinario(rs.getString("nombre_vet") + " " + rs.getString("apellido_vet"));
                ci.setNombreCliente(rs.getString("nombre_cli") + " " + rs.getString("apellido_cli"));
                lista.add(ci);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar citas: " + e.getMessage());
        }

        return lista;
    }

    // CREAR
    public boolean insertar(Cita ci) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "INSERT INTO Cita (fecha_hora, motivo, estado_cita, estado, fecha_creacion, usuario_creacion, id_mascota, id_usuario, id_cliente) " +
                     "VALUES (?, ?, ?, 'Activo', NOW(), 'sistema', ?, ?, ?)";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ci.getFecha_hora());
            ps.setString(2, ci.getMotivo());
            ps.setString(3, ci.getEstado_cita());
            ps.setInt(4, ci.getId_mascota());
            ps.setInt(5, ci.getId_usuario());
            ps.setInt(6, ci.getId_cliente());

            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al insertar cita: " + e.getMessage());
        }

        return exito;
    }

    // ELIMINAR (lógico)
    public boolean eliminar(int id_cita) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Cita SET estado = 'Inactivo', fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_cita = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id_cita);
            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al eliminar cita: " + e.getMessage());
        }

        return exito;
    }

    // ACTUALIZAR
    public boolean actualizar(Cita ci) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Cita SET fecha_hora = ?, motivo = ?, estado_cita = ?, id_mascota = ?, id_usuario = ?, id_cliente = ?, " +
                     "fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_cita = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ci.getFecha_hora());
            ps.setString(2, ci.getMotivo());
            ps.setString(3, ci.getEstado_cita());
            ps.setInt(4, ci.getId_mascota());
            ps.setInt(5, ci.getId_usuario());
            ps.setInt(6, ci.getId_cliente());
            ps.setInt(7, ci.getId_cita());

            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al actualizar cita: " + e.getMessage());
        }

        return exito;
    }

    // AUXILIAR: lista solo los usuarios con rol Veterinario (para el desplegable)
    public List<Usuario> listarVeterinarios() {
        List<Usuario> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT * FROM Usuario WHERE rol = 'Veterinario' AND estado = 'Activo' ORDER BY nombre";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                lista.add(u);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar veterinarios: " + e.getMessage());
        }

        return lista;
    }
}