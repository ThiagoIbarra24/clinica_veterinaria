package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.Usuario;
import com.mycompany.clinica_veterinaria.model.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


public class UsuarioServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
 
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Pedir la lista de usuarios al DAO
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> lista = dao.listar();

        // 2. Guardar la lista en el request para que la vista la use
        request.setAttribute("listaUsuarios", lista);

        // 3. Enviar a la vista que mostrará la tabla
        request.getRequestDispatcher("/View/listaUsuarios.jsp").forward(request, response);
    }
    


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String accion = request.getParameter("accion");

    // Obtener el usuario logueado de la sesión
    jakarta.servlet.http.HttpSession session = request.getSession();
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario_n");

    String nombreUsuario = "Desconocido";
    String rolUsuario = "Desconocido";
    if (usuarioLogueado != null) {
        nombreUsuario = usuarioLogueado.getNombre() + " " + usuarioLogueado.getApellido();
        rolUsuario = usuarioLogueado.getRol();
    }

    AuditoriaDAO auditoriaDAO = new AuditoriaDAO();

    if (accion != null && accion.equals("insertar")) {
        // 1. Recibir los datos del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String usuario_n = request.getParameter("usuario_n");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        String especialidad = request.getParameter("especialidad");
        // 2. Crear el objeto Usuario con esos datos
        Usuario u = new Usuario();
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setUsuario_n(usuario_n);
        u.setPassword(password);
        u.setRol(rol);
        // 3. Llamar al DAO para guardarlo
        UsuarioDAO dao = new UsuarioDAO();
        dao.insertar(u, especialidad);

        auditoriaDAO.registrar(nombreUsuario, rolUsuario, "CREAR", "Usuarios",
            "Creó el usuario: " + nombre + " " + apellido + " (" + rol + ")");

    }     else if (accion != null && accion.equals("eliminar")) {
        int id = Integer.parseInt(request.getParameter("id_usuario"));
        UsuarioDAO dao = new UsuarioDAO();
        dao.eliminar(id);

        auditoriaDAO.registrar(nombreUsuario, rolUsuario, "ELIMINAR", "Usuarios",
            "Eliminó el usuario #" + id);

    }   else if (accion != null && accion.equals("actualizar")) {
        // Recibir los datos del formulario de edición
        int id = Integer.parseInt(request.getParameter("id_usuario"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String usuario_n = request.getParameter("usuario_n");
        String rol = request.getParameter("rol");
        String especialidad = request.getParameter("especialidad");
        // Crear el objeto Usuario con los datos
        Usuario u = new Usuario();
        u.setId_usuario(id);
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setUsuario_n(usuario_n);
        u.setRol(rol);
        // Llamar al DAO para actualizar
        UsuarioDAO dao = new UsuarioDAO();
        dao.actualizar(u, especialidad);

        auditoriaDAO.registrar(nombreUsuario, rolUsuario, "EDITAR", "Usuarios",
            "Editó el usuario #" + id + ": " + nombre + " " + apellido);
    }
     // 4. Volver a la lista de usuarios (recargar la tabla)
    response.sendRedirect(request.getContextPath() + "/UsuarioServlet");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
