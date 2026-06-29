package com.mycompany.clinica_veterinaria.controller;

import com.mycompany.clinica_veterinaria.model.GestionLogin;
import com.mycompany.clinica_veterinaria.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Set;
import com.mycompany.clinica_veterinaria.model.AuditoriaDAO;

public class LoginServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/View/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //1.Recibir datos del formulario
        String usuario_n = request.getParameter("usuario_n");
        String password = request.getParameter("password");
        
        //2. Llamar al modelo para autenticar
        GestionLogin gestor = new GestionLogin();
        Usuario usuario = gestor.autenticar(usuario_n, password);
        
        //3.Verificar si el usuario existe
        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario_n", usuario);
            session.setAttribute("rol", usuario.getRol());

            // REGISTRAR EN AUDITORÍA el inicio de sesión
            AuditoriaDAO auditoriaDAO = new AuditoriaDAO();
            auditoriaDAO.registrar(
                usuario.getNombre() + " " + usuario.getApellido(),  // quién
                usuario.getRol(),                                    // su rol
                "LOGIN",                                             // qué acción
                "Sistema",                                           // módulo
                "Inició sesión en el sistema"                        // descripción
            );

    response.sendRedirect(request.getContextPath() + "/View/" + usuario.getMenuPrincipal());

            
      }else{
            //Login fallido
    request.setAttribute("error", "Usuario o contraseña incorrectos");
    request.getRequestDispatcher("/View/login.jsp").forward(request, response);
}

        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
