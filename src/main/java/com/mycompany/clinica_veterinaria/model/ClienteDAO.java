package com.mycompany.clinica_veterinaria.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    // LEER: devuelve la lista de todos los clientes activos
    public List<Cliente> listar() {
        List<Cliente> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();

        String sql = "SELECT * FROM Cliente WHERE estado = 'Activo' ORDER BY id_cliente";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setApellido(rs.getString("apellido"));
                c.setDni(rs.getString("dni"));
                c.setCorreo(rs.getString("correo"));
                c.setTelefono(rs.getString("telefono"));
                c.setEstado(rs.getString("estado"));
                lista.add(c);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al listar clientes: " + e.getMessage());
        }

        return lista;
    }

    // CREAR: inserta un nuevo cliente
    public boolean insertar(Cliente c) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "INSERT INTO Cliente (nombre, apellido, dni, correo, telefono, estado, fecha_creacion, usuario_creacion) " +
                     "VALUES (?, ?, ?, ?, ?, 'Activo', NOW(), 'sistema')";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getDni());
            ps.setString(4, c.getCorreo());
            ps.setString(5, c.getTelefono());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al insertar cliente: " + e.getMessage());
        }

        return exito;
    }

    // ELIMINAR (lógico): cambia el estado a 'Inactivo'
    public boolean eliminar(int id_cliente) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Cliente SET estado = 'Inactivo', fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_cliente = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id_cliente);

            int filas = ps.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al eliminar cliente: " + e.getMessage());
        }

        return exito;
    }

    // ACTUALIZAR: modifica los datos de un cliente existente
    public boolean actualizar(Cliente c) {
        boolean exito = false;
        Connection con = Conexion.getConnection();

        String sql = "UPDATE Cliente SET nombre = ?, apellido = ?, dni = ?, correo = ?, telefono = ?, " +
                     "fecha_modificacion = NOW(), usuario_modificacion = 'sistema' WHERE id_cliente = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getDni());
            ps.setString(4, c.getCorreo());
            ps.setString(5, c.getTelefono());
            ps.setInt(6, c.getId_cliente());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                exito = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
        }

        return exito;
    }
}