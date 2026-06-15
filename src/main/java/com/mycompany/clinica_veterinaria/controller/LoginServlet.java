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
        response.sendRedirect(request.getContextPath() + "/vista/login.jsp");
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
        if(usuario != null){
            //Guardando usuario en la sesion
            HttpSession session = request.getSession();
            session.setAttribute("usuario_n", usuario);
            session.setAttribute("rol", usuario.getRol());
            
            
            //Redigir segun el rol del usuario
            String menu = usuario.getMenuPrincipal();
            response.sendRedirect(request.getContextPath() + "/View/"+menu);
            
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
