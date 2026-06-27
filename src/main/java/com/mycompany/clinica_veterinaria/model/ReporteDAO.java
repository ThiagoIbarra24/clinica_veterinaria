
package com.mycompany.clinica_veterinaria.model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ReporteDAO {
    public List<Cita> generarReporte(String fechaDesde, String fechaHasta, String idVeterinario){
        List<Cita> lista = new ArrayList<>();
        Connection con = Conexion.getConnection();
      // Construimos la consulta base con el triple JOIN (igual que en citas)
        StringBuilder sql = new StringBuilder(
            "SELECT ci.*, " +
            "m.nombre_m AS nombre_mascota, " +
            "u.nombre AS nombre_vet, u.apellido AS apellido_vet, " +
            "c.nombre AS nombre_cli, c.apellido AS apellido_cli " +
            "FROM Cita ci " +
            "INNER JOIN Mascota m ON ci.id_mascota = m.id_mascota " +
            "INNER JOIN Usuario u ON ci.id_usuario = u.id_usuario " +
            "INNER JOIN Cliente c ON ci.id_cliente = c.id_cliente " +
            "WHERE ci.estado = 'Activo' "
        );

        // Agregamos los filtros SOLO si tienen valor (filtros dinámicos)
        if (fechaDesde != null && !fechaDesde.isEmpty()) {
            sql.append("AND ci.fecha_hora >= CAST(? AS TIMESTAMP) ");
        }
        if (fechaHasta != null && !fechaHasta.isEmpty()) {
            sql.append("AND ci.fecha_hora <= CAST(? AS TIMESTAMP) ");
        }
        if (idVeterinario != null && !idVeterinario.isEmpty()) {
            sql.append("AND ci.id_usuario = ? ");
        }

        sql.append("ORDER BY ci.fecha_hora");

        try {
            PreparedStatement ps = con.prepareStatement(sql.toString());

            // Asignamos los valores a los ? en el mismo orden en que los agregamos
            int posicion = 1;
            if (fechaDesde != null && !fechaDesde.isEmpty()) {
                ps.setString(posicion, fechaDesde + " 00:00:00");
                posicion++;
            }
            if (fechaHasta != null && !fechaHasta.isEmpty()) {
                ps.setString(posicion, fechaHasta + " 23:59:59");
                posicion++;
            }
            if (idVeterinario != null && !idVeterinario.isEmpty()) {
                ps.setInt(posicion, Integer.parseInt(idVeterinario));
                posicion++;
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cita ci = new Cita();
                ci.setId_cita(rs.getInt("id_cita"));
                ci.setFecha_hora(rs.getString("fecha_hora"));
                ci.setMotivo(rs.getString("motivo"));
                ci.setEstado_cita(rs.getString("estado_cita"));
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
            System.out.println("Error al generar reporte: " + e.getMessage());
        }

        return lista;
    }
}
    

