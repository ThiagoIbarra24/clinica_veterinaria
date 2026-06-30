package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.AuditoriaDAO;
import com.mycompany.clinica_veterinaria.model.Cliente;
import com.mycompany.clinica_veterinaria.model.ClienteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Pedir la lista de clientes al DAO
        ClienteDAO dao = new ClienteDAO();
        List<Cliente> lista = dao.listar();

        // Guardar la lista en el request para la vista
        request.setAttribute("listaClientes", lista);

        // Enviar a la vista que mostrará la tabla
        request.getRequestDispatcher("/View/listaClientes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null && accion.equals("insertar")) {
            // Recibir datos del formulario
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String dni = request.getParameter("dni");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");

            // Crear objeto Cliente
            Cliente c = new Cliente();
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setDni(dni);
            c.setCorreo(correo);
            c.setTelefono(telefono);

            // Guardar
            ClienteDAO dao = new ClienteDAO();
            dao.insertar(c);

        } else if (accion != null && accion.equals("eliminar")) {
            int id = Integer.parseInt(request.getParameter("id_cliente"));
            ClienteDAO dao = new ClienteDAO();
            dao.eliminar(id);

        } else if (accion != null && accion.equals("actualizar")) {
            int id = Integer.parseInt(request.getParameter("id_cliente"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String dni = request.getParameter("dni");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");

            Cliente c = new Cliente();
            c.setId_cliente(id);
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setDni(dni);
            c.setCorreo(correo);
            c.setTelefono(telefono);

            ClienteDAO dao = new ClienteDAO();
            dao.actualizar(c);
        }

        // Volver a la lista (recargar la tabla)
        response.sendRedirect(request.getContextPath() + "/ClienteServlet");
    }
}