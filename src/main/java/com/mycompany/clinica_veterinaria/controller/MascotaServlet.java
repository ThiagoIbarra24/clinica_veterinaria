package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.AuditoriaDAO;
import com.mycompany.clinica_veterinaria.model.Mascota;
import com.mycompany.clinica_veterinaria.model.MascotaDAO;
import com.mycompany.clinica_veterinaria.model.Cliente;
import com.mycompany.clinica_veterinaria.model.ClienteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class MascotaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lista de mascotas (para la tabla)
        MascotaDAO daoMascota = new MascotaDAO();
        List<Mascota> listaMascotas = daoMascota.listar();
        request.setAttribute("listaMascotas", listaMascotas);

        // 2. Lista de clientes (para el desplegable de dueño en el formulario)
        ClienteDAO daoCliente = new ClienteDAO();
        List<Cliente> listaClientes = daoCliente.listar();
        request.setAttribute("listaClientes", listaClientes);

        // 3. Enviar a la vista
        request.getRequestDispatcher("/View/listaMascotas.jsp").forward(request, response);
    }

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String accion = request.getParameter("accion");

    // Obtener el usuario logueado de la sesión
    jakarta.servlet.http.HttpSession session = request.getSession();
    com.mycompany.clinica_veterinaria.model.Usuario usuarioLogueado =
        (com.mycompany.clinica_veterinaria.model.Usuario) session.getAttribute("usuario_n");

    String nombreUsuario = "Desconocido";
    String rolUsuario = "Desconocido";
    if (usuarioLogueado != null) {
        nombreUsuario = usuarioLogueado.getNombre() + " " + usuarioLogueado.getApellido();
        rolUsuario = usuarioLogueado.getRol();
    }

    AuditoriaDAO auditoriaDAO = new AuditoriaDAO();

    if (accion != null && accion.equals("insertar")) {
        Mascota m = new Mascota();
        m.setNombre_m(request.getParameter("nombre_m"));
        m.setEspecie(request.getParameter("especie"));
        m.setRaza(request.getParameter("raza"));
        m.setEdad(Integer.parseInt(request.getParameter("edad")));
        m.setPeso(Double.parseDouble(request.getParameter("peso")));
        m.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));

        MascotaDAO dao = new MascotaDAO();
        dao.insertar(m);

        auditoriaDAO.registrar(nombreUsuario, rolUsuario, "CREAR", "Mascotas",
            "Creó la mascota: " + m.getNombre_m());

    } else if (accion != null && accion.equals("eliminar")) {
        int id = Integer.parseInt(request.getParameter("id_mascota"));
        MascotaDAO dao = new MascotaDAO();
        dao.eliminar(id);

        auditoriaDAO.registrar(nombreUsuario, rolUsuario, "ELIMINAR", "Mascotas",
            "Eliminó la mascota #" + id);

    } else if (accion != null && accion.equals("actualizar")) {
        Mascota m = new Mascota();
        m.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
        m.setNombre_m(request.getParameter("nombre_m"));
        m.setEspecie(request.getParameter("especie"));
        m.setRaza(request.getParameter("raza"));
        m.setEdad(Integer.parseInt(request.getParameter("edad")));
        m.setPeso(Double.parseDouble(request.getParameter("peso")));
        m.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));

        MascotaDAO dao = new MascotaDAO();
        dao.actualizar(m);

        auditoriaDAO.registrar(nombreUsuario, rolUsuario, "EDITAR", "Mascotas",
            "Editó la mascota #" + m.getId_mascota() + ": " + m.getNombre_m());
    }

    response.sendRedirect(request.getContextPath() + "/MascotaServlet");
}
}