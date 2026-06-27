package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.Cita;
import com.mycompany.clinica_veterinaria.model.ReporteDAO;
import com.mycompany.clinica_veterinaria.model.CitaDAO;
import com.mycompany.clinica_veterinaria.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ReporteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Leer los filtros de la URL (si vienen)
        String fechaDesde = request.getParameter("fechaDesde");
        String fechaHasta = request.getParameter("fechaHasta");
        String idVeterinario = request.getParameter("idVeterinario");

        // Generar el reporte con los filtros (si están vacíos, trae todo)
        ReporteDAO daoReporte = new ReporteDAO();
        List<Cita> resultados = daoReporte.generarReporte(fechaDesde, fechaHasta, idVeterinario);
        request.setAttribute("resultados", resultados);

        // Cargar la lista de veterinarios para el desplegable del filtro
        CitaDAO daoCita = new CitaDAO();
        List<Usuario> listaVeterinarios = daoCita.listarVeterinarios();
        request.setAttribute("listaVeterinarios", listaVeterinarios);

        // Reenviar los filtros usados (para que se mantengan en la pantalla)
        request.setAttribute("fechaDesde", fechaDesde);
        request.setAttribute("fechaHasta", fechaHasta);
        request.setAttribute("idVeterinario", idVeterinario);

        // Enviar a la vista
        request.getRequestDispatcher("/View/reporteria.jsp").forward(request, response);
    }
}