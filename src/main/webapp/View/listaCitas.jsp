<%-- 
    Document   : listaCitas
    Created on : 18 jun 2026, 7:14:30 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Cita"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Cliente"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Mascota"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Usuario"%>
<%
    List<Cita> listaCitas = (List<Cita>) request.getAttribute("listaCitas");
    List<Cliente> listaClientes = (List<Cliente>) request.getAttribute("listaClientes");
    List<Mascota> listaMascotas = (List<Mascota>) request.getAttribute("listaMascotas");
    List<Usuario> listaVeterinarios = (List<Usuario>) request.getAttribute("listaVeterinarios");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Citas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; padding: 30px; }
        .titulo { color: #1a3c5e; font-weight: bold; }
        .card-tabla { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        table { font-size: 14px; }
        th { color: #888; font-weight: 600; border-bottom: 2px solid #eee; }
        td { vertical-align: middle; }
        .badge-cita { padding: 4px 12px; border-radius: 12px; font-size: 12px; }
        .estado-pendiente { background: #fff3cd; color: #e8a33d; }
        .estado-confirmada { background: #e1f5ee; color: #2ecc71; }
        .estado-cancelada { background: #fae6e6; color: #e74c3c; }
        .btn-nuevo { background: #1a3c5e; color: white; border: none; border-radius: 8px; padding: 10px 18px; font-size: 14px; }
        .btn-nuevo:hover { background: #2ecc71; color: white; }
        .btn-accion { border: none; border-radius: 6px; padding: 6px 10px; margin: 0 2px; }
        .btn-editar { background: #e6f1fb; color: #1a3c5e; }
        .btn-eliminar { background: #fae6e6; color: #e74c3c; }
    </style>
    </head>
    <body>
            <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="titulo">Gestión de Citas</h3>
            <p style="color:#888; margin:0">
                <%= (listaCitas != null ? listaCitas.size() : 0) %> citas registradas
            </p>
        </div>
        <button class="btn-nuevo" data-bs-toggle="modal" data-bs-target="#modalNuevaCita">
            <i class="bi bi-plus-lg"></i> Agendar Cita
        </button>
    </div>

    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Mascota</th>
                    <th>Dueño</th>
                    <th>Veterinario</th>
                    <th>Fecha y Hora</th>
                    <th>Motivo</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (listaCitas != null) {
                        for (Cita ci : listaCitas) {
                            String claseEstado = "estado-pendiente";
                            if ("Confirmada".equals(ci.getEstado_cita())) claseEstado = "estado-confirmada";
                            else if ("Cancelada".equals(ci.getEstado_cita())) claseEstado = "estado-cancelada";
                %>
                <tr>
                    <td>#<%= ci.getId_cita() %></td>
                    <td><%= ci.getNombreMascota() %></td>
                    <td><%= ci.getNombreCliente() %></td>
                    <td><%= ci.getNombreVeterinario() %></td>
                    <td><%= ci.getFecha_hora() %></td>
                    <td><%= ci.getMotivo() %></td>
                    <td><span class="badge-cita <%= claseEstado %>"><%= ci.getEstado_cita() %></span></td>
                    <td>
                        <button class="btn-accion btn-editar"
                                data-bs-toggle="modal" data-bs-target="#modalEditarCita"
                                data-id="<%= ci.getId_cita() %>"
                                data-fecha="<%= ci.getFecha_hora() %>"
                                data-motivo="<%= ci.getMotivo() %>"
                                data-estadocita="<%= ci.getEstado_cita() %>"
                                data-mascota="<%= ci.getId_mascota() %>"
                                data-vet="<%= ci.getId_usuario() %>"
                                data-cliente="<%= ci.getId_cliente() %>"
                                onclick="cargarDatosEditar(this)">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <form action="<%= request.getContextPath() %>/CitaServlet" method="post" style="display:inline"
                              onsubmit="return confirm('¿Seguro que deseas eliminar esta cita?');">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id_cita" value="<%= ci.getId_cita() %>">
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

    <!-- MODAL NUEVA CITA -->
    <div class="modal fade" id="modalNuevaCita" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Agendar Cita</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/CitaServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="insertar">

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Cliente (dueño)</label>
                <select name="id_cliente" id="select_cliente" class="form-select" required onchange="filtrarMascotas()">
                  <option value="">Seleccione un cliente...</option>
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

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Mascota</label>
                <select name="id_mascota" id="select_mascota" class="form-select" required>
                  <option value="">Primero seleccione un cliente...</option>
                </select>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Veterinario</label>
                <select name="id_usuario" class="form-select" required>
                  <option value="">Seleccione un veterinario...</option>
                  <%
                      if (listaVeterinarios != null) {
                          for (Usuario v : listaVeterinarios) {
                  %>
                  <option value="<%= v.getId_usuario() %>"><%= v.getNombre() %> <%= v.getApellido() %></option>
                  <%
                          }
                      }
                  %>
                </select>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Fecha y Hora</label>
                <input type="datetime-local" name="fecha_hora" class="form-control" required>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Motivo</label>
                <input type="text" name="motivo" class="form-control" required>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Estado</label>
                <select name="estado_cita" class="form-select" required>
                  <option value="Pendiente">Pendiente</option>
                  <option value="Confirmada">Confirmada</option>
                  <option value="Cancelada">Cancelada</option>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn-nuevo">Agendar</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- MODAL EDITAR CITA -->
    <div class="modal fade" id="modalEditarCita" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Editar Cita</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/CitaServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id_cita" id="edit_id">

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Cliente (dueño)</label>
                <select name="id_cliente" id="edit_cliente" class="form-select" required onchange="filtrarMascotasEditar()">
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

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Mascota</label>
                <select name="id_mascota" id="edit_mascota" class="form-select" required></select>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Veterinario</label>
                <select name="id_usuario" id="edit_vet" class="form-select" required>
                  <%
                      if (listaVeterinarios != null) {
                          for (Usuario v : listaVeterinarios) {
                  %>
                  <option value="<%= v.getId_usuario() %>"><%= v.getNombre() %> <%= v.getApellido() %></option>
                  <%
                          }
                      }
                  %>
                </select>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Fecha y Hora</label>
                <input type="datetime-local" name="fecha_hora" id="edit_fecha" class="form-control" required>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Motivo</label>
                <input type="text" name="motivo" id="edit_motivo" class="form-control" required>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Estado</label>
                <select name="estado_cita" id="edit_estadocita" class="form-select" required>
                  <option value="Pendiente">Pendiente</option>
                  <option value="Confirmada">Confirmada</option>
                  <option value="Cancelada">Cancelada</option>
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
    // Lista de todas las mascotas con su dueño (generada desde Java)
    var todasMascotas = [
        <%
            if (listaMascotas != null) {
                for (int i = 0; i < listaMascotas.size(); i++) {
                    Mascota m = listaMascotas.get(i);
        %>
        { id: <%= m.getId_mascota() %>, nombre: "<%= m.getNombre_m() %>", idCliente: <%= m.getId_cliente() %> }<%= (i < listaMascotas.size()-1) ? "," : "" %>
        <%
                }
            }
        %>
    ];

    // Filtra el desplegable de mascotas según el cliente elegido (modal nuevo)
    function filtrarMascotas() {
        var idCliente = document.getElementById('select_cliente').value;
        var selectMascota = document.getElementById('select_mascota');
        selectMascota.innerHTML = '<option value="">Seleccione una mascota...</option>';

        todasMascotas.forEach(function(m) {
            if (m.idCliente == idCliente) {
                var opcion = document.createElement('option');
                opcion.value = m.id;
                opcion.textContent = m.nombre;
                selectMascota.appendChild(opcion);
            }
        });
    }

    // Versión para el modal de editar
    function filtrarMascotasEditar() {
        var idCliente = document.getElementById('edit_cliente').value;
        var selectMascota = document.getElementById('edit_mascota');
        selectMascota.innerHTML = '';

        todasMascotas.forEach(function(m) {
            if (m.idCliente == idCliente) {
                var opcion = document.createElement('option');
                opcion.value = m.id;
                opcion.textContent = m.nombre;
                selectMascota.appendChild(opcion);
            }
        });
    }

    // Carga los datos en el modal de editar
    function cargarDatosEditar(boton) {
        document.getElementById('edit_id').value = boton.getAttribute('data-id');
        document.getElementById('edit_fecha').value = boton.getAttribute('data-fecha');
        document.getElementById('edit_motivo').value = boton.getAttribute('data-motivo');
        document.getElementById('edit_estadocita').value = boton.getAttribute('data-estadocita');
        document.getElementById('edit_cliente').value = boton.getAttribute('data-cliente');
        document.getElementById('edit_vet').value = boton.getAttribute('data-vet');

        // Filtrar mascotas de ese cliente y luego seleccionar la correcta
        filtrarMascotasEditar();
        document.getElementById('edit_mascota').value = boton.getAttribute('data-mascota');
    }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
