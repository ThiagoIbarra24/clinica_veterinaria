<%-- 
    Document   : reporteria
    Created on : 27 jun 2026, 6:34:39 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Cita"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Usuario"%>
<%
    List<Cita> resultados = (List<Cita>) request.getAttribute("resultados");
    List<Usuario> listaVeterinarios = (List<Usuario>) request.getAttribute("listaVeterinarios");
    String fechaDesde = (String) request.getAttribute("fechaDesde");
    String fechaHasta = (String) request.getAttribute("fechaHasta");
    String idVetSeleccionado = (String) request.getAttribute("idVeterinario");
    if (fechaDesde == null) fechaDesde = "";
    if (fechaHasta == null) fechaHasta = "";
    if (idVetSeleccionado == null) idVetSeleccionado = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Reportería de Citas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; padding: 30px; }
        .titulo { color: #1a3c5e; font-weight: bold; }
        .card-tabla { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card-filtros { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
        table { font-size: 14px; }
        th { color: #888; font-weight: 600; border-bottom: 2px solid #eee; }
        td { vertical-align: middle; }
        .badge-cita { padding: 4px 12px; border-radius: 12px; font-size: 12px; }
        .estado-pendiente { background: #fff3cd; color: #e8a33d; }
        .estado-confirmada { background: #e1f5ee; color: #2ecc71; }
        .estado-cancelada { background: #fae6e6; color: #e74c3c; }
        .btn-generar { background: #1a3c5e; color: white; border: none; border-radius: 8px; padding: 10px 20px; font-size: 14px; }
        .btn-generar:hover { background: #2ecc71; color: white; }
        .btn-limpiar { background: #f4f6f9; color: #555; border: 1px solid #ddd; border-radius: 8px; padding: 10px 20px; font-size: 14px; text-decoration: none; }
        .resumen { background: #e6f1fb; color: #1a3c5e; padding: 12px 18px; border-radius: 10px; font-weight: 500; }
    </style>
    </head>
    <body>
         <h3 class="titulo">Reportería de Citas</h3>
    <p style="color:#888">Consulta las citas filtrando por fecha y veterinario</p>

    <!-- FILTROS -->
    <div class="card-filtros">
        <form action="<%= request.getContextPath() %>/ReporteServlet" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label" style="font-size:14px">Fecha desde</label>
                    <input type="date" name="fechaDesde" class="form-control" value="<%= fechaDesde %>">
                </div>
                <div class="col-md-3">
                    <label class="form-label" style="font-size:14px">Fecha hasta</label>
                    <input type="date" name="fechaHasta" class="form-control" value="<%= fechaHasta %>">
                </div>
                <div class="col-md-3">
                    <label class="form-label" style="font-size:14px">Veterinario</label>
                    <select name="idVeterinario" class="form-select">
                        <option value="">Todos los veterinarios</option>
                        <%
                            if (listaVeterinarios != null) {
                                for (Usuario v : listaVeterinarios) {
                                    String selected = idVetSeleccionado.equals(String.valueOf(v.getId_usuario())) ? "selected" : "";
                        %>
                        <option value="<%= v.getId_usuario() %>" <%= selected %>>
                            <%= v.getNombre() %> <%= v.getApellido() %>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn-generar">
                        <i class="bi bi-search"></i> Generar Reporte
                    </button>
                    <a href="<%= request.getContextPath() %>/ReporteServlet" class="btn-limpiar">Limpiar</a>
                </div>
            </div>
        </form>
    </div>

    <!-- RESUMEN -->
    <div class="mb-3">
        <span class="resumen">
            <i class="bi bi-clipboard-data"></i>
            Total de citas encontradas: <%= (resultados != null ? resultados.size() : 0) %>
        </span>
    </div>

    <!-- TABLA DE RESULTADOS -->
    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Fecha y Hora</th>
                    <th>Mascota</th>
                    <th>Dueño</th>
                    <th>Veterinario</th>
                    <th>Motivo</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (resultados != null && !resultados.isEmpty()) {
                        for (Cita ci : resultados) {
                            String claseEstado = "estado-pendiente";
                            if ("Confirmada".equals(ci.getEstado_cita())) claseEstado = "estado-confirmada";
                            else if ("Cancelada".equals(ci.getEstado_cita())) claseEstado = "estado-cancelada";
                %>
                <tr>
                    <td>#<%= ci.getId_cita() %></td>
                    <td><%= ci.getFecha_hora() %></td>
                    <td><%= ci.getNombreMascota() %></td>
                    <td><%= ci.getNombreCliente() %></td>
                    <td><%= ci.getNombreVeterinario() %></td>
                    <td><%= ci.getMotivo() %></td>
                    <td><span class="badge-cita <%= claseEstado %>"><%= ci.getEstado_cita() %></span></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" style="text-align:center; color:#888; padding:30px">
                        No se encontraron citas con los filtros seleccionados.
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
