<%-- 
    Document   : Auditoria
    Created on : 29 jun 2026, 5:21:05 p.m.
    Author     : LENOVO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Auditoria"%>
<%
    List<Auditoria> listaAuditoria = (List<Auditoria>) request.getAttribute("listaAuditoria");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Auditoría del Sistema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; padding: 30px; }
        .titulo { color: #1a3c5e; font-weight: bold; }
        .card-tabla { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        table { font-size: 14px; }
        th { color: #888; font-weight: 600; border-bottom: 2px solid #eee; }
        td { vertical-align: middle; }
        .badge-accion { padding: 4px 12px; border-radius: 12px; font-size: 12px; font-weight: 500; }
        .accion-login { background: #e6f1fb; color: #1a3c5e; }
        .accion-crear { background: #e1f5ee; color: #2ecc71; }
        .accion-editar { background: #fff3cd; color: #e8a33d; }
        .accion-eliminar { background: #fae6e6; color: #e74c3c; }
        .resumen { background: #e6f1fb; color: #1a3c5e; padding: 12px 18px; border-radius: 10px; font-weight: 500; }
    </style>
    </head>
    <body>
        <h3 class="titulo">Auditoría del Sistema</h3>
    <p style="color:#888">Registro de todas las acciones realizadas en el sistema</p>

    <!-- RESUMEN -->
    <div class="mb-3">
        <span class="resumen">
            <i class="bi bi-shield-check"></i>
            Total de registros: <%= (listaAuditoria != null ? listaAuditoria.size() : 0) %>
        </span>
    </div>

    <!-- TABLA -->
    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Rol</th>
                    <th>Acción</th>
                    <th>Módulo</th>
                    <th>Descripción</th>
                    <th>Fecha y Hora</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (listaAuditoria != null && !listaAuditoria.isEmpty()) {
                        for (Auditoria a : listaAuditoria) {
                            String claseAccion = "accion-login";
                            if ("CREAR".equals(a.getAccion())) claseAccion = "accion-crear";
                            else if ("EDITAR".equals(a.getAccion())) claseAccion = "accion-editar";
                            else if ("ELIMINAR".equals(a.getAccion())) claseAccion = "accion-eliminar";
                %>
                <tr>
                    <td>#<%= a.getId_auditoria() %></td>
                    <td><%= a.getUsuario() %></td>
                    <td><%= a.getRol() %></td>
                    <td><span class="badge-accion <%= claseAccion %>"><%= a.getAccion() %></span></td>
                    <td><%= a.getModulo() %></td>
                    <td><%= a.getDescripcion() %></td>
                    <td><%= a.getFecha_hora() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" style="text-align:center; color:#888; padding:30px">
                        No hay registros de auditoría todavía.
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
