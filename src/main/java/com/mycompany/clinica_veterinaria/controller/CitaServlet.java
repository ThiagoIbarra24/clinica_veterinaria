package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.Cita;
import com.mycompany.clinica_veterinaria.model.CitaDAO;
import com.mycompany.clinica_veterinaria.model.Cliente;
import com.mycompany.clinica_veterinaria.model.ClienteDAO;
import com.mycompany.clinica_veterinaria.model.Mascota;
import com.mycompany.clinica_veterinaria.model.MascotaDAO;
import com.mycompany.clinica_veterinaria.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CitaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CitaDAO daoCita = new CitaDAO();

        // 1. Lista de citas (para la tabla)
        List<Cita> listaCitas = daoCita.listar();
        request.setAttribute("listaCitas", listaCitas);

        // 2. Lista de clientes (desplegable)
        ClienteDAO daoCliente = new ClienteDAO();
        List<Cliente> listaClientes = daoCliente.listar();
        request.setAttribute("listaClientes", listaClientes);

        // 3. Lista de mascotas (desplegable, con su dueño para filtrar)
        MascotaDAO daoMascota = new MascotaDAO();
        List<Mascota> listaMascotas = daoMascota.listar();
        request.setAttribute("listaMascotas", listaMascotas);

        // 4. Lista de veterinarios (desplegable)
        List<Usuario> listaVeterinarios = daoCita.listarVeterinarios();
        request.setAttribute("listaVeterinarios", listaVeterinarios);

        // 5. Enviar a la vista
        request.getRequestDispatcher("/View/listaCitas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null && accion.equals("insertar")) {
            Cita ci = new Cita();
            ci.setFecha_hora(request.getParameter("fecha_hora"));
            ci.setMotivo(request.getParameter("motivo"));
            ci.setEstado_cita(request.getParameter("estado_cita"));
            ci.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
            ci.setId_usuario(Integer.parseInt(request.getParameter("id_usuario")));
            ci.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));

            CitaDAO dao = new CitaDAO();
            dao.insertar(ci);

        } else if (accion != null && accion.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id_cita"));
            CitaDAO dao = new CitaDAO();
            dao.eliminar(id);

        } else if (accion != null && accion.equals("actualizar")) {
            Cita ci = new Cita();
            ci.setId_cita(Integer.parseInt(request.getParameter("id_cita")));
            ci.setFecha_hora(request.getParameter("fecha_hora"));
            ci.setMotivo(request.getParameter("motivo"));
            ci.setEstado_cita(request.getParameter("estado_cita"));
            ci.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
            ci.setId_usuario(Integer.parseInt(request.getParameter("id_usuario")));
            ci.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));

            CitaDAO dao = new CitaDAO();
            dao.actualizar(ci);
        }

        response.sendRedirect(request.getContextPath() + "/CitaServlet");
    }
}