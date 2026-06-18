<%-- 
    Document   : listaClientes
    Created on : 18 jun 2026, 11:52:38 a.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Cliente"%>
<%
    List<Cliente> listaClientes = (List<Cliente>) request.getAttribute("listaClientes");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Clientes</title>
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
            <h3 class="titulo">Gestión de Clientes</h3>
            <p style="color:#888; margin:0">
                <%= (listaClientes != null ? listaClientes.size() : 0) %> clientes registrados
            </p>
        </div>
        <button class="btn-nuevo" data-bs-toggle="modal" data-bs-target="#modalNuevoCliente">
            <i class="bi bi-plus-lg"></i> Nuevo Cliente
        </button>
    </div>

    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>DNI</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (listaClientes != null) {
                        for (Cliente c : listaClientes) {
                %>
                <tr>
                    <td>#<%= c.getId_cliente() %></td>
                    <td><%= c.getNombre() %></td>
                    <td><%= c.getApellido() %></td>
                    <td><%= c.getDni() %></td>
                    <td><%= c.getCorreo() %></td>
                    <td><%= c.getTelefono() %></td>
                    <td><span class="badge-estado"><%= c.getEstado() %></span></td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="bi bi-eye"></i></button>
                        <button class="btn-accion btn-editar"
                                data-bs-toggle="modal" data-bs-target="#modalEditarCliente"
                                data-id="<%= c.getId_cliente() %>"
                                data-nombre="<%= c.getNombre() %>"
                                data-apellido="<%= c.getApellido() %>"
                                data-dni="<%= c.getDni() %>"
                                data-correo="<%= c.getCorreo() %>"
                                data-telefono="<%= c.getTelefono() %>"
                                onclick="cargarDatosEditar(this)">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <form action="<%= request.getContextPath() %>/ClienteServlet" method="post" style="display:inline"
                              onsubmit="return confirm('¿Seguro que deseas eliminar este cliente?');">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id_cliente" value="<%= c.getId_cliente() %>">
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

    <!-- MODAL NUEVO CLIENTE -->
    <div class="modal fade" id="modalNuevoCliente" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Nuevo Cliente</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/ClienteServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="insertar">
              <div class="row mb-3">
                <div class="col">
                  <label class="form-label" style="font-size:14px">Nombre</label>
                  <input type="text" name="nombre" class="form-control" required>
                </div>
                <div class="col">
                  <label class="form-label" style="font-size:14px">Apellido</label>
                  <input type="text" name="apellido" class="form-control" required>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">DNI</label>
                <input type="text" name="dni" class="form-control" maxlength="8" required>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Correo</label>
                <input type="email" name="correo" class="form-control" required>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Teléfono</label>
                <input type="text" name="telefono" class="form-control" required>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn-nuevo">Crear Cliente</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- MODAL EDITAR CLIENTE -->
    <div class="modal fade" id="modalEditarCliente" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Editar Cliente</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/ClienteServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id_cliente" id="edit_id">
              <div class="row mb-3">
                <div class="col">
                  <label class="form-label" style="font-size:14px">Nombre</label>
                  <input type="text" name="nombre" id="edit_nombre" class="form-control" required>
                </div>
                <div class="col">
                  <label class="form-label" style="font-size:14px">Apellido</label>
                  <input type="text" name="apellido" id="edit_apellido" class="form-control" required>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">DNI</label>
                <input type="text" name="dni" id="edit_dni" class="form-control" maxlength="8" required>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Correo</label>
                <input type="email" name="correo" id="edit_correo" class="form-control" required>
              </div>
              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Teléfono</label>
                <input type="text" name="telefono" id="edit_telefono" class="form-control" required>
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
        document.getElementById('edit_apellido').value = boton.getAttribute('data-apellido');
        document.getElementById('edit_dni').value = boton.getAttribute('data-dni');
        document.getElementById('edit_correo').value = boton.getAttribute('data-correo');
        document.getElementById('edit_telefono').value = boton.getAttribute('data-telefono');
    }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
    </body>
</html>
