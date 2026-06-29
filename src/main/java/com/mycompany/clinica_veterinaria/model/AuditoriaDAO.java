package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AuditoriaDAO {

    // REGISTRAR: anota una acción en la auditoría (lo llama el sistema automáticamente)
    public void registrar(String usuario, String rol, String accion, String modulo, String descripcion) {
        Connection con = Conexion.getConnection();

        String sql = "INSERT INTO Auditoria (usuario, rol, accion, modulo, descripcion, fecha_hora) " +
                     "VALUES (?, ?, ?, ?, ?, NOW())";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, rol);
            ps.setString(3, accion);
            ps.setString(4, modulo);
            ps.setString(5, descripcion);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al registrar auditoría: " + e.getMessage());
        }
    }

    // LISTAR: trae todos los registros, los más recientes primero
    public List<Auditoria> listar() {
        List<Auditoria> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT id_auditoria, usuario, rol, accion, modulo, descripcion, " +
                     "CAST(fecha_hora AS TEXT) AS fecha " +
                     "FROM Auditoria ORDER BY id_auditoria DESC";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Auditoria a = new Auditoria();
                a.setId_auditoria(rs.getInt("id_auditoria"));
                a.setUsuario(rs.getString("usuario"));
                a.setRol(rs.getString("rol"));
                a.setAccion(rs.getString("accion"));
                a.setModulo(rs.getString("modulo"));
                a.setDescripcion(rs.getString("descripcion"));
                a.setFecha_hora(rs.getString("fecha"));
                lista.add(a);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar auditoría: " + e.getMessage());
        }

        return lista;
    }
}