package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {

    // Cuenta el total de clientes activos
    public int contarClientes() {
        int total = 0;
        Connection con = Conexion.getConnection();
        String sql = "SELECT COUNT(*) FROM Cliente WHERE estado = 'Activo'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al contar clientes: " + e.getMessage());
        }
        return total;
    }

    // Cuenta el total de mascotas activas
    public int contarMascotas() {
        int total = 0;
        Connection con = Conexion.getConnection();
        String sql = "SELECT COUNT(*) FROM Mascota WHERE estado = 'Activo'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al contar mascotas: " + e.getMessage());
        }
        return total;
    }

    // Cuenta el total de citas activas
    public int contarCitas() {
        int total = 0;
        Connection con = Conexion.getConnection();
        String sql = "SELECT COUNT(*) FROM Cita WHERE estado = 'Activo'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al contar citas: " + e.getMessage());
        }
        return total;
    }

    // Cuenta las citas de HOY
    public int contarCitasHoy() {
        int total = 0;
        Connection con = Conexion.getConnection();
        String sql = "SELECT COUNT(*) FROM Cita WHERE estado = 'Activo' AND CAST(fecha_hora AS DATE) = CURRENT_DATE";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al contar citas de hoy: " + e.getMessage());
        }
        return total;
    }
}