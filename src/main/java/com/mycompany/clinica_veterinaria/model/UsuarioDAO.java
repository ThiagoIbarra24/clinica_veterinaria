/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    // LEER: devuelve la lista de todos los usuarios activos
    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT * FROM Usuario WHERE estado = 'Activo' ORDER BY id_usuario";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setUsuario_n(rs.getString("usuario_n"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                lista.add(u);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }

        return lista;
    }
    // CREAR: inserta un nuevo usuario en la BD
public boolean insertar(Usuario u, String especialidad) {
    boolean exito = false;
    Connection con = Conexion.getConnection();

    String sql = "INSERT INTO Usuario (usuario_n, password, nombre, apellido, rol, especialidad, estado, fecha_creacion, usuario_creacion) " +
                 "VALUES (?, ?, ?, ?, ?, ?, 'Activo', NOW(), 'sistema')";

    try {
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, u.getUsuario_n());
        ps.setString(2, u.getPassword());
        ps.setString(3, u.getNombre());
        ps.setString(4, u.getApellido());
        ps.setString(5, u.getRol());

        // Si es veterinario usa la especialidad, si no, va null
        if (u.getRol().equals("Veterinario")) {
            ps.setString(6, especialidad);
        } else {
            ps.setNull(6, java.sql.Types.VARCHAR);
        }

        int filas = ps.executeUpdate();
        if (filas > 0) {
            exito = true;
        }
        ps.close();
    } catch (Exception e) {
        System.out.println("Error al insertar usuario: " + e.getMessage());
    }

    return exito;
}
// ELIMINAR (lógico): cambia el estado a 'Inactivo'
public boolean eliminar(int id_usuario) {
    boolean exito = false;
    Connection con = Conexion.getConnection();

    String sql = "UPDATE Usuario SET estado = 'Inactivo', fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_usuario = ?";

    try {
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id_usuario);

        int filas = ps.executeUpdate();
        if (filas > 0) {
            exito = true;
        }
        ps.close();
    } catch (Exception e) {
        System.out.println("Error al eliminar usuario: " + e.getMessage());
    }

    return exito;
}

// ACTUALIZAR: modifica los datos de un usuario existente
public boolean actualizar(Usuario u, String especialidad) {
    boolean exito = false;
    Connection con = Conexion.getConnection();

    String sql = "UPDATE Usuario SET nombre = ?, apellido = ?, usuario_n = ?, rol = ?, especialidad = ?, " +
                 "fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_usuario = ?";

    try {
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, u.getNombre());
        ps.setString(2, u.getApellido());
        ps.setString(3, u.getUsuario_n());
        ps.setString(4, u.getRol());

        if (u.getRol().equals("Veterinario")) {
            ps.setString(5, especialidad);
        } else {
            ps.setNull(5, java.sql.Types.VARCHAR);
        }

        ps.setInt(6, u.getId_usuario());

        int filas = ps.executeUpdate();
        if (filas > 0) {
            exito = true;
        }
        ps.close();
    } catch (Exception e) {
        System.out.println("Error al actualizar usuario: " + e.getMessage());
    }

    return exito;
}
}
