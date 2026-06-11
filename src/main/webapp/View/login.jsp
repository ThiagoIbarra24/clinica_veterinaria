<%-- 
    Document   : login
    Created on : 9 jun 2026, 4:23:41 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    
     <style>
        body {
            background: linear-gradient(135deg, #1a3c5e 0%, #2ecc71 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .logo-box {
            background-color: #2d6a4f;
            border-radius: 16px;
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
        }
        .logo-box i {
            font-size: 36px;
            color: #2ecc71;
        }
        .card-login {
            border-radius: 20px;
            border: none;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
            width: 100%;
            max-width: 420px;
            padding: 32px;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 16px 12px 42px;
            border: 1px solid #e0e0e0;
            background-color: #f8f9fa;
            font-size: 14px;
        }
        .form-control:focus {
            border-color: #1a3c5e;
            box-shadow: 0 0 0 3px rgba(26,60,94,0.1);
            background-color: #fff;
        }
        .input-wrapper {
            position: relative;
        }
        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 16px;
            z-index: 1;
        }
        .btn-ingresar {
            background-color: #1a3c5e;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 13px;
            font-size: 15px;
            font-weight: 500;
            width: 100%;
            transition: background-color 0.2s;
        }
        .btn-ingresar:hover {
            background-color: #2ecc71;
            color: white;
        }
        .toggle-password {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
            font-size: 16px;
        }
        .demo-box {
            background-color: #f0faf4;
            border: 1px solid #b7e4c7;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 13px;
            color: #2d6a4f;
        }
        .footer-text {
            color: rgba(255,255,255,0.6);
            font-size: 13px;
            margin-top: 24px;
        }
    </style>
</head>
<body>

    <!-- Logo y título -->
    <div class="text-center mb-3">
        <div class="logo-box">
            <i class="bi bi-patch-heart-fill"></i>
        </div>
        <h4 class="text-white fw-bold mb-1">VetSystem</h4>
        <p class="text-white-50" style="font-size:14px">Sistema de Gestión Veterinaria</p>
    </div>

    <!-- Card login -->
    <div class="card-login bg-white">
        <h5 class="fw-bold text-center mb-4" style="color:#1a3c5e">Iniciar Sesión</h5>

        <!-- Mensaje de error -->
        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="alert alert-danger py-2 text-center" style="font-size:13px">
                <i class="bi bi-exclamation-circle me-1"></i><%= error %>
            </div>
        <% } %>

        <!-- Formulario -->
        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">

            <!-- Usuario -->
            <div class="mb-3">
                <label class="form-label fw-medium" style="font-size:14px">Usuario</label>
                <div class="input-wrapper">
                    <i class="bi bi-person input-icon"></i>
                    <input type="text" name="usuario_n" class="form-control"
                           placeholder="Ingrese su usuario" required>
                </div>
            </div>

            <!-- Contraseña -->
            <div class="mb-4">
                <label class="form-label fw-medium" style="font-size:14px">Contraseña</label>
                <div class="input-wrapper">
                    <i class="bi bi-lock input-icon"></i>
                    <input type="password" name="password" id="passwordField"
                           class="form-control" placeholder="Ingrese su contraseña" required>
                    <i class="bi bi-eye toggle-password" id="togglePassword"></i>
                </div>
            </div>

            <!-- Botón -->
            <button type="submit" class="btn-ingresar mb-3">Ingresar</button>

        </form>

    </div>

    <!-- Footer -->
    <p class="footer-text">VetSystem © 2026 — Todos los derechos reservados</p>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mostrar/ocultar contraseña
        document.getElementById('togglePassword').addEventListener('click', function() {
            const field = document.getElementById('passwordField');
            if (field.type === 'password') {
                field.type = 'text';
                this.classList.replace('bi-eye', 'bi-eye-slash');
            } else {
                field.type = 'password';
                this.classList.replace('bi-eye-slash', 'bi-eye');
            }
        });
    </script>
</body>
    
</html>
