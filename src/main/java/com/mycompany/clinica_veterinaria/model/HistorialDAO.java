package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HistorialDAO {

    // LEER: lista los historiales con info de la mascota y la cita (JOIN)
    public List<Historial> listar() {
        List<Historial> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT h.*, m.nombre_m AS nombre_mascota, " +
                     "ci.motivo AS motivo_cita, CAST(ci.fecha_hora AS TEXT) AS fecha_cita " +
                     "FROM Historial_Medico h " +
                     "INNER JOIN Mascota m ON h.id_mascota = m.id_mascota " +
                     "INNER JOIN Cita ci ON h.id_cita = ci.id_cita " +
                     "WHERE h.estado = 'Activo' ORDER BY h.id_historial DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Historial h = new Historial();
                h.setId_historial(rs.getInt("id_historial"));
                h.setDiagnostico(rs.getString("diagnostico"));
                h.setTratamiento(rs.getString("tratamiento"));
                h.setObservacion(rs.getString("observacion"));
                h.setEstado(rs.getString("estado"));
                h.setId_cita(rs.getInt("id_cita"));
                h.setId_mascota(rs.getInt("id_mascota"));
                h.setNombreMascota(rs.getString("nombre_mascota"));
                h.setMotivoCita(rs.getString("motivo_cita"));
                h.setFechaCita(rs.getString("fecha_cita"));
                lista.add(h);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar historiales: " + e.getMessage());
        }

        return lista;
    }

    // CREAR
    public boolean insertar(Historial h) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "INSERT INTO Historial_Medico (diagnostico, tratamiento, observacion, estado, fecha_creacion, usuario_creacion, id_cita, id_mascota) " +
                     "VALUES (?, ?, ?, 'Activo', NOW(), 'sistema', ?, ?)";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, h.getDiagnostico());
            ps.setString(2, h.getTratamiento());
            ps.setString(3, h.getObservacion());
            ps.setInt(4, h.getId_cita());
            ps.setInt(5, h.getId_mascota());

            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al insertar historial: " + e.getMessage());
        }

        return exito;
    }

    // ELIMINAR (lógico)
    public boolean eliminar(int id_historial) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Historial_Medico SET estado = 'Inactivo', fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_historial = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id_historial);
            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al eliminar historial: " + e.getMessage());
        }

        return exito;
    }

    // ACTUALIZAR
    public boolean actualizar(Historial h) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Historial_Medico SET diagnostico = ?, tratamiento = ?, observacion = ?, id_cita = ?, id_mascota = ?, " +
                     "fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_historial = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, h.getDiagnostico());
            ps.setString(2, h.getTratamiento());
            ps.setString(3, h.getObservacion());
            ps.setInt(4, h.getId_cita());
            ps.setInt(5, h.getId_mascota());
            ps.setInt(6, h.getId_historial());

            int filas = ps.executeUpdate();
            if (filas > 0) exito = true;
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al actualizar historial: " + e.getMessage());
        }

        return exito;
    }

    // AUXILIAR: lista las citas con su mascota (para el desplegable y deducir la mascota)
    public List<Cita> listarCitasConMascota() {
        List<Cita> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT ci.id_cita, ci.motivo, ci.id_mascota, m.nombre_m " +
                     "FROM Cita ci " +
                     "INNER JOIN Mascota m ON ci.id_mascota = m.id_mascota " +
                     "WHERE ci.estado = 'Activo' ORDER BY ci.id_cita";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cita ci = new Cita();
                ci.setId_cita(rs.getInt("id_cita"));
                ci.setMotivo(rs.getString("motivo"));
                ci.setId_mascota(rs.getInt("id_mascota"));
                ci.setNombreMascota(rs.getString("nombre_m"));
                lista.add(ci);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar citas con mascota: " + e.getMessage());
        }

        return lista;
    }
}