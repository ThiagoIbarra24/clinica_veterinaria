package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.Historial;
import com.mycompany.clinica_veterinaria.model.HistorialDAO;
import com.mycompany.clinica_veterinaria.model.Cita;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class HistorialServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HistorialDAO dao = new HistorialDAO();

        // 1. Lista de historiales (para la tabla)
        List<Historial> listaHistoriales = dao.listar();
        request.setAttribute("listaHistoriales", listaHistoriales);

        // 2. Lista de citas con su mascota (para el desplegable y deducir la mascota)
        List<Cita> listaCitas = dao.listarCitasConMascota();
        request.setAttribute("listaCitas", listaCitas);

        // 3. Enviar a la vista
        request.getRequestDispatcher("/View/listaHistorial.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null && accion.equals("insertar")) {
            Historial h = new Historial();
            h.setDiagnostico(request.getParameter("diagnostico"));
            h.setTratamiento(request.getParameter("tratamiento"));
            h.setObservacion(request.getParameter("observacion"));
            h.setId_cita(Integer.parseInt(request.getParameter("id_cita")));
            h.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));

            HistorialDAO dao = new HistorialDAO();
            dao.insertar(h);

        } else if (accion != null && accion.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id_historial"));
            HistorialDAO dao = new HistorialDAO();
            dao.eliminar(id);

        } else if (accion != null && accion.equals("actualizar")) {
            Historial h = new Historial();
            h.setId_historial(Integer.parseInt(request.getParameter("id_historial")));
            h.setDiagnostico(request.getParameter("diagnostico"));
            h.setTratamiento(request.getParameter("tratamiento"));
            h.setObservacion(request.getParameter("observacion"));
            h.setId_cita(Integer.parseInt(request.getParameter("id_cita")));
            h.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));

            HistorialDAO dao = new HistorialDAO();
            dao.actualizar(h);
        }

        response.sendRedirect(request.getContextPath() + "/HistorialServlet");
    }
}