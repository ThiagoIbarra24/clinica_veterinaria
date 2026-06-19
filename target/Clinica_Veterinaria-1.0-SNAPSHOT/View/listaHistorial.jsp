<%-- 
    Document   : listaHistorial
    Created on : 18 jun 2026, 9:04:58 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Historial"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Cita"%>
<%
    List<Historial> listaHistoriales = (List<Historial>) request.getAttribute("listaHistoriales");
    List<Cita> listaCitas = (List<Cita>) request.getAttribute("listaCitas");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial Clínico</title>
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
        .btn-editar { background: #e6f1fb; color: #1a3c5e; }
        .btn-eliminar { background: #fae6e6; color: #e74c3c; }
    </style>
    </head>
    <body>
        <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="titulo">Historial Clínico</h3>
            <p style="color:#888; margin:0">
                <%= (listaHistoriales != null ? listaHistoriales.size() : 0) %> registros en total
            </p>
        </div>
        <button class="btn-nuevo" data-bs-toggle="modal" data-bs-target="#modalNuevoHistorial">
            <i class="bi bi-plus-lg"></i> Nueva Entrada
        </button>
    </div>

    <div class="card-tabla">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Mascota</th>
                    <th>Motivo Cita</th>
                    <th>Diagnóstico</th>
                    <th>Tratamiento</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (listaHistoriales != null) {
                        for (Historial h : listaHistoriales) {
                %>
                <tr>
                    <td>#<%= h.getId_historial() %></td>
                    <td><%= h.getNombreMascota() %></td>
                    <td><%= h.getMotivoCita() %></td>
                    <td><%= h.getDiagnostico() %></td>
                    <td><%= h.getTratamiento() %></td>
                    <td><span class="badge-estado"><%= h.getEstado() %></span></td>
                    <td>
                        <button class="btn-accion btn-editar"
                                data-bs-toggle="modal" data-bs-target="#modalEditarHistorial"
                                data-id="<%= h.getId_historial() %>"
                                data-diagnostico="<%= h.getDiagnostico() %>"
                                data-tratamiento="<%= h.getTratamiento() %>"
                                data-observacion="<%= h.getObservacion() %>"
                                data-cita="<%= h.getId_cita() %>"
                                data-mascota="<%= h.getId_mascota() %>"
                                onclick="cargarDatosEditar(this)">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <form action="<%= request.getContextPath() %>/HistorialServlet" method="post" style="display:inline"
                              onsubmit="return confirm('¿Seguro que deseas eliminar este registro?');">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id_historial" value="<%= h.getId_historial() %>">
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

    <!-- MODAL NUEVO HISTORIAL -->
    <div class="modal fade" id="modalNuevoHistorial" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Nueva Entrada Clínica</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/HistorialServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="insertar">
              <!-- campo oculto donde se guardará la mascota deducida de la cita -->
              <input type="hidden" name="id_mascota" id="hidden_mascota">

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Cita</label>
                <select name="id_cita" id="select_cita" class="form-select" required onchange="deducirMascota()">
                  <option value="">Seleccione una cita...</option>
                  <%
                      if (listaCitas != null) {
                          for (Cita ci : listaCitas) {
                  %>
                  <option value="<%= ci.getId_cita() %>" data-mascota="<%= ci.getId_mascota() %>">
                      Cita #<%= ci.getId_cita() %> - <%= ci.getNombreMascota() %> (<%= ci.getMotivo() %>)
                  </option>
                  <%
                          }
                      }
                  %>
                </select>
                <small style="color:#888" id="info_mascota"></small>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Diagnóstico</label>
                <input type="text" name="diagnostico" class="form-control" required>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Tratamiento</label>
                <textarea name="tratamiento" class="form-control" rows="2" required></textarea>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Observación</label>
                <textarea name="observacion" class="form-control" rows="2" required></textarea>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn-nuevo">Guardar</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- MODAL EDITAR HISTORIAL -->
    <div class="modal fade" id="modalEditarHistorial" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" style="border-radius:16px;">
          <div class="modal-header">
            <h5 class="modal-title" style="color:#1a3c5e; font-weight:bold">Editar Entrada Clínica</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <form action="<%= request.getContextPath() %>/HistorialServlet" method="post">
            <div class="modal-body">
              <input type="hidden" name="accion" value="actualizar">
              <input type="hidden" name="id_historial" id="edit_id">
              <input type="hidden" name="id_mascota" id="edit_hidden_mascota">

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Cita</label>
                <select name="id_cita" id="edit_cita" class="form-select" required onchange="deducirMascotaEditar()">
                  <%
                      if (listaCitas != null) {
                          for (Cita ci : listaCitas) {
                  %>
                  <option value="<%= ci.getId_cita() %>" data-mascota="<%= ci.getId_mascota() %>">
                      Cita #<%= ci.getId_cita() %> - <%= ci.getNombreMascota() %> (<%= ci.getMotivo() %>)
                  </option>
                  <%
                          }
                      }
                  %>
                </select>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Diagnóstico</label>
                <input type="text" name="diagnostico" id="edit_diagnostico" class="form-control" required>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Tratamiento</label>
                <textarea name="tratamiento" id="edit_tratamiento" class="form-control" rows="2" required></textarea>
              </div>

              <div class="mb-3">
                <label class="form-label" style="font-size:14px">Observación</label>
                <textarea name="observacion" id="edit_observacion" class="form-control" rows="2" required></textarea>
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
    // Deduce la mascota de la cita elegida (modal nuevo)
    function deducirMascota() {
        var select = document.getElementById('select_cita');
        var opcion = select.options[select.selectedIndex];
        var idMascota = opcion.getAttribute('data-mascota');
        document.getElementById('hidden_mascota').value = idMascota;
        if (idMascota) {
            document.getElementById('info_mascota').textContent = 'Mascota asignada automáticamente desde la cita.';
        }
    }

    // Versión para editar
    function deducirMascotaEditar() {
        var select = document.getElementById('edit_cita');
        var opcion = select.options[select.selectedIndex];
        var idMascota = opcion.getAttribute('data-mascota');
        document.getElementById('edit_hidden_mascota').value = idMascota;
    }

    // Carga datos en el modal de editar
    function cargarDatosEditar(boton) {
        document.getElementById('edit_id').value = boton.getAttribute('data-id');
        document.getElementById('edit_diagnostico').value = boton.getAttribute('data-diagnostico');
        document.getElementById('edit_tratamiento').value = boton.getAttribute('data-tratamiento');
        document.getElementById('edit_observacion').value = boton.getAttribute('data-observacion');
        document.getElementById('edit_cita').value = boton.getAttribute('data-cita');
        document.getElementById('edit_hidden_mascota').value = boton.getAttribute('data-mascota');
    }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
