<%-- 
    Document   : listaUsuarios
    Created on : 14 jun 2026, 5:38:07 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Usuario"%>
<%
    List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; padding: 30px; }
        .titulo { color: #1a3c5e; font-weight: bold; }
        .card-tabla { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        table { font-size: 14px; }
        th { color: #888; font-weight: 600; border-bottom: 2px solid #eee; }
        td { vertical-align: middle; }
        .badge-rol { padding: 4px 12px; border-radius: 12px; font-size: 12px; }
        .rol-admin { background: #fae6e6; color: #e74c3c; }
        .rol-vet { background: #e1f5ee; color: #2ecc71; }
        .rol-rec { background: #e6f1fb; color: #1a3c5e; }
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
            <h3 class="titulo">Gestión de Usuarios</h3>
            <p style="color:#888; margin:0">
                <%= (listaUsuarios != null ? listaUsuarios.size() : 0) %> usuarios registrados
            </p>
        </div>
<button class="btn-nuevo" data-bs-toggle="modal" data-bs-target="#modalNuevoUsuario">
    <i class="bi bi-plus-lg"></i> Nuevo Usuario
</button>
    </div>

    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (listaUsuarios != null) {
                        for (Usuario u : listaUsuarios) {
                            String claseRol = "rol-rec";
                            if (u.getRol().equals("Admin")) claseRol = "rol-admin";
                            else if (u.getRol().equals("Veterinario")) claseRol = "rol-vet";
                %>
                <tr>
                    <td>#<%= u.getId_usuario() %></td>
                    <td><%= u.getUsuario_n() %></td>
                    <td><%= u.getNombre() %></td>
                    <td><%= u.getApellido() %></td>
                    <td><span class="badge-rol <%= claseRol %>"><%= u.getRol() %></span></td>
                    <td><span class="badge-estado"><%= u.getEstado() %></span></td>
                    <td>
                        
                        <button class="btn-accion btn-editar"
                                data-bs-toggle="modal" data-bs-target="#modalEditarUsuario"
                                data-id="<%= u.getId_usuario() %>"
                                data-nombre="<%= u.getNombre() %>"
                                data-apellido="<%= u.getApellido() %>"
                                data-usuario="<%= u.getUsuario_n() %>"
                                data-rol="<%= u.getRol() %>"
                                onclick="cargarDatosEditar(this)">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <form action="<%= request.getContextPath() %>/UsuarioServlet" method="post" style="display:inline"
                           onsubmit="return confirm('¿Seguro que deseas eliminar este usuario?');">
                          <input type="hidden" name="accion" value="eliminar">
                          <input type="hidden" name="id_usuario" value="<%= u.getId_usuario() %>">
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
            <!-- MODAL NUEVO USUARIO -->
<div class="modal fade" id="modalNuevoUsuario" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content" style="border-radius:16px;">
      <div class="modal-header">
        <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Nuevo Usuario</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form action="<%= request.getContextPath() %>/UsuarioServlet" method="post">
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
            <label class="form-label" style="font-size:14px">Usuario</label>
            <input type="text" name="usuario_n" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label" style="font-size:14px">Contraseña</label>
            <input type="password" name="password" class="form-control" required>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label class="form-label" style="font-size:14px">Rol</label>
              <select name="rol" id="selectRol" class="form-select" onchange="mostrarEspecialidad()">
                <option value="Recepcionista">Recepcionista</option>
                <option value="Veterinario">Veterinario</option>
                <option value="Admin">Admin</option>
              </select>
            </div>
            <div class="col" id="campoEspecialidad" style="display:none">
              <label class="form-label" style="font-size:14px">Especialidad</label>
              <input type="text" name="especialidad" class="form-control">
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn-nuevo">Crear Usuario</button>
        </div>
      </form>
    </div>
  </div>
</div>
        
        <!-- MODAL EDITAR USUARIO -->
<div class="modal fade" id="modalEditarUsuario" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content" style="border-radius:16px;">
      <div class="modal-header">
        <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Editar Usuario</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form action="<%= request.getContextPath() %>/UsuarioServlet" method="post">
        <div class="modal-body">
          <input type="hidden" name="accion" value="actualizar">
          <input type="hidden" name="id_usuario" id="edit_id">

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
            <label class="form-label" style="font-size:14px">Usuario</label>
            <input type="text" name="usuario_n" id="edit_usuario" class="form-control" required>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label class="form-label" style="font-size:14px">Rol</label>
              <select name="rol" id="edit_rol" class="form-select" onchange="mostrarEspecialidadEditar()">
                <option value="Recepcionista">Recepcionista</option>
                <option value="Veterinario">Veterinario</option>
                <option value="Admin">Admin</option>
              </select>
            </div>
            <div class="col" id="edit_campoEspecialidad" style="display:none">
              <label class="form-label" style="font-size:14px">Especialidad</label>
              <input type="text" name="especialidad" id="edit_especialidad" class="form-control">
            </div>
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
    document.getElementById('edit_usuario').value = boton.getAttribute('data-usuario');
    document.getElementById('edit_rol').value = boton.getAttribute('data-rol');
    mostrarEspecialidadEditar();
}

function mostrarEspecialidadEditar() {
    var rol = document.getElementById('edit_rol').value;
    var campo = document.getElementById('edit_campoEspecialidad');
    if (rol === 'Veterinario') {
        campo.style.display = 'block';
    } else {
        campo.style.display = 'none';
    }
}
function mostrarEspecialidad() {
    var rol = document.getElementById('selectRol').value;
    var campo = document.getElementById('campoEspecialidad');
    if (rol === 'Veterinario') {
        campo.style.display = 'block';
    } else {
        campo.style.display = 'none';
    }
}
</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
