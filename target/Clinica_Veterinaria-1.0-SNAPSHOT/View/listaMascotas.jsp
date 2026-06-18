<%-- 
    Document   : listaMascotas
    Created on : 18 jun 2026, 6:26:53 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Mascota"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Cliente"%>
<%
    List<Mascota> listaMascotas = (List<Mascota>) request.getAttribute("listaMascotas");
    List<Cliente> listaClientes = (List<Cliente>) request.getAttribute("listaClientes");
%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Mascotas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; padding: 30px; }
        .titulo { color: #1a3c5e; font-weight: bold; }
        .card-tabla { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        table { font-size: 14px; }
        th { color: #888; font-weight: 600; border-bottom: 2px solid #eee; }
        td { vertical-align: middle; }
        .badge-estado { background: #e1f5ee; color: #2ecc71; padding: 4px 12px; border-radius: 12px; font-size: 12px; }
        .btn-nuevo { background: #1a3c5e; color: white; border: none; border-radius: 8px; padding: 10px 18px; font-size: 14px; }
        .btn-nuevo:hover { background: #2ecc71; color: white; }
        .btn-accion { border: none; border-radius: 6px; padding: 6px 10px; margin: 0 2px; }
        .btn-ver { background: #e1f5ee; color: #2ecc71; }
        .btn-editar { background: #e6f1fb; color: #1a3c5e; }
        .btn-eliminar { background: #fae6e6; color: #e74c3c; }
    </style>
    </head>
    <body>
        
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="titulo">Gestión de Mascotas</h3>
            <p style="color:#888; margin:0">
                <%= (listaMascotas != null ? listaMascotas.size() : 0) %> mascotas registradas
            </p>
        </div>
        <button class="btn-nuevo" data-bs-toggle="modal" data-bs-target="#modalNuevaMascota">
            <i class="bi bi-plus-lg"></i> Nueva Mascota
        </button>
    </div>

    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Especie</th>
                    <th>Raza</th>
                    <th>Edad</th>
                    <th>Peso (kg)</th>
                    <th>Dueño</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (listaMascotas != null) {
                        for (Mascota m : listaMascotas) {
                %>
                <tr>
                    <td>#<%= m.getId_mascota() %></td>
                    <td><%= m.getNombre_m() %></td>
                    <td><%= m.getEspecie() %></td>
                    <td><%= m.getRaza() %></td>
                    <td><%= m.getEdad() %> años</td>
                    <td><%= m.getPeso() %></td>
                    <td><%= m.getNombreDueno() %></td>
                    <td><span class="badge-estado"><%= m.getEstado() %></span></td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="bi bi-eye"></i></button>
                        <button class="btn-accion btn-editar"
                                data-bs-toggle="modal" data-bs-target="#modalEditarMascota"
                                data-id="<%= m.getId_mascota() %>"
                                data-nombre="<%= m.getNombre_m() %>"
                                data-especie="<%= m.getEspecie() %>"
                                data-raza="<%= m.getRaza() %>"
                                data-edad="<%= m.getEdad() %>"
                                data-peso="<%= m.getPeso() %>"
                                data-cliente="<%= m.getId_cliente() %>"
                                onclick="cargarDatosEditar(this)">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <form action="<%= request.getContextPath() %>/MascotaServlet" method="post" style="display:inline"
                              onsubmit="return confirm('¿Seguro que deseas eliminar esta mascota?');">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id_mascota" value="<%= m.getId_mascota() %>">
                            <button type="submit" class="btn-accion btn-eliminar"><i class="bi bi-trash"></i></button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- MODAL NUEVA MASCOTA -->
    <div class="modal fade" id="modalNuevaMascota" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Nueva Mascota</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/MascotaServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="insertar">
              <div class="row mb-3">
                <div class="col">
                  <label class="form-label" style="font-size:14px">Nombre</label>
                  <input type="text" name="nombre_m" class="form-control" required>
                </div>
                <div class="col">
                  <label class="form-label" style="font-size:14px">Especie</label>
                  <input type="text" name="especie" class="form-control" required>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col">
                  <label class="form-label" style="font-size:14px">Raza</label>
                  <input type="text" name="raza" class="form-control" required>
                </div>
                <div class="col">
                  <label class="form-label" style="font-size:14px">Edad (años)</label>
                  <input type="number" name="edad" class="form-control" required>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Peso (kg)</label>
                <input type="number" step="0.1" name="peso" class="form-control" required>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Dueño</label>
                <select name="id_cliente" class="form-select" required>
                  <option value="">Seleccione un dueño...</option>
                  <%
                      if (listaClientes != null) {
                          for (Cliente c : listaClientes) {
                  %>
                  <option value="<%= c.getId_cliente() %>"><%= c.getNombre() %> <%= c.getApellido() %></option>
                  <%
                          }
                      }
                  %>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn-nuevo">Crear Mascota</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- MODAL EDITAR MASCOTA -->
    <div class="modal fade" id="modalEditarMascota" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Editar Mascota</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/MascotaServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id_mascota" id="edit_id">
              <div class="row mb-3">
                <div class="col">
                  <label class="form-label" style="font-size:14px">Nombre</label>
                  <input type="text" name="nombre_m" id="edit_nombre" class="form-control" required>
                </div>
                <div class="col">
                  <label class="form-label" style="font-size:14px">Especie</label>
                  <input type="text" name="especie" id="edit_especie" class="form-control" required>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col">
                  <label class="form-label" style="font-size:14px">Raza</label>
                  <input type="text" name="raza" id="edit_raza" class="form-control" required>
                </div>
                <div class="col">
                  <label class="form-label" style="font-size:14px">Edad (años)</label>
                  <input type="number" name="edad" id="edit_edad" class="form-control" required>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Peso (kg)</label>
                <input type="number" step="0.1" name="peso" id="edit_peso" class="form-control" required>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Dueño</label>
                <select name="id_cliente" id="edit_cliente" class="form-select" required>
                  <%
                      if (listaClientes != null) {
                          for (Cliente c : listaClientes) {
                  %>
                  <option value="<%= c.getId_cliente() %>"><%= c.getNombre() %> <%= c.getApellido() %></option>
                  <%
                          }
                      }
                  %>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn-nuevo">Guardar Cambios</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
    function cargarDatosEditar(boton) {
        document.getElementById('edit_id').value = boton.getAttribute('data-id');
        document.getElementById('edit_nombre').value = boton.getAttribute('data-nombre');
        document.getElementById('edit_especie').value = boton.getAttribute('data-especie');
        document.getElementById('edit_raza').value = boton.getAttribute('data-raza');
        document.getElementById('edit_edad').value = boton.getAttribute('data-edad');
        document.getElementById('edit_peso').value = boton.getAttribute('data-peso');
        document.getElementById('edit_cliente').value = boton.getAttribute('data-cliente');
    }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
