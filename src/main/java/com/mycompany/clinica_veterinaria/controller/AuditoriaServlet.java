package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.Auditoria;
import com.mycompany.clinica_veterinaria.model.AuditoriaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AuditoriaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AuditoriaDAO dao = new AuditoriaDAO();
        List<Auditoria> listaAuditoria = dao.listar();
        request.setAttribute("listaAuditoria", listaAuditoria);

        request.getRequestDispatcher("/View/auditoria.jsp").forward(request, response);
    }
}