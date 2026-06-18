<%-- 
    Document   : menuRecepcionista
    Created on : 9 jun 2026, 4:24:46 p.m.
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.clinica_veterinaria.model.Usuario"%>
<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario_n");
    if (usuarioLogueado == null) {
        response.sendRedirect(request.getContextPath() + "/View/login.jsp");
        return;
    }
    String nombreCompleto = usuarioLogueado.getNombre() + " " + usuarioLogueado.getApellido();
    String rol = usuarioLogueado.getRol();
    String iniciales = ("" + usuarioLogueado.getNombre().charAt(0) + usuarioLogueado.getApellido().charAt(0)).toUpperCase();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>VetSystem - Recepcionista</title>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --azul-marino: #1a3c5e;
            --verde: #2ecc71;
            --gris-fondo: #f4f6f9;
        }
        body {
            margin: 0;
            background-color: var(--gris-fondo);
            font-family: 'Segoe UI', sans-serif;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: var(--azul-marino);
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            padding: 0;
        }
        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 20px;
            color: white;
            font-weight: bold;
            font-size: 20px;
        }
        .sidebar-logo i { color: var(--verde); font-size: 26px; }
        .rol-badge {
            background-color: rgba(46,204,113,0.2);
            color: var(--verde);
            font-size: 12px;
            padding: 2px 12px;
            border-radius: 12px;
            margin: 0 20px 16px;
            display: inline-block;
            width: fit-content;
        }
        .nav-link-custom {
            color: rgba(255,255,255,0.7);
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            font-size: 15px;
            transition: all 0.2s;
        }
        .nav-link-custom:hover {
            background-color: rgba(255,255,255,0.08);
            color: white;
        }
        .nav-link-custom.active {
            background-color: var(--verde);
            color: white;
            font-weight: 500;
        }
        .nav-link-custom i { font-size: 18px; }
        .logout {
            margin-top: auto;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        .main-content {
            margin-left: 250px;
            padding: 0;
        }
        .navbar-top {
            background-color: white;
            padding: 14px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        }
        .search-box {
            border: 1px solid #e0e0e0;
            border-radius: 20px;
            padding: 8px 16px;
            width: 320px;
            font-size: 14px;
        }
        .user-info { display: flex; align-items: center; gap: 12px; }
        .avatar {
            width: 40px; height: 40px;
            background-color: var(--azul-marino);
            color: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; font-size: 14px;
        }
        .content-body { padding: 28px; }
        .card-stat {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: none;
        }
        .card-icon {
            width: 44px; height: 44px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
        }
        .stat-number { font-size: 32px; font-weight: bold; color: var(--azul-marino); }
        .stat-label { color: #888; font-size: 14px; }
        .bell-badge {
            position: relative;
            font-size: 22px;
            color: #555;
            cursor: pointer;
        }
        .bell-badge span {
            position: absolute;
            top: -6px; right: -6px;
            background: red;
            color: white;
            font-size: 10px;
            border-radius: 50%;
            width: 18px; height: 18px;
            display: flex; align-items: center; justify-content: center;
        }
        .btn-accion-rapida {
            background: var(--azul-marino);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 14px 20px;
            font-size: 15px;
            font-weight: 500;
            width: 100%;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: background 0.2s;
        }
        .btn-accion-rapida:hover { background: var(--verde); color: white; }
    </style>
    </head>
    <body>
        <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <i class="bi bi-heart-pulse-fill"></i> VetSystem
        </div>
        <span class="rol-badge">Recepcionista</span>

        <a href="#" class="nav-link-custom active"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
        <a href="#" class="nav-link-custom"><i class="bi bi-person-lines-fill"></i> Clientes</a>
        <a href="#" class="nav-link-custom"><i class="bi bi-heart-fill"></i> Mascotas</a>
        <a href="#" class="nav-link-custom"><i class="bi bi-calendar-check-fill"></i> Citas</a>
        <a href="#" class="nav-link-custom"><i class="bi bi-file-medical-fill"></i> Historial Clínico</a>

        <a href="<%= request.getContextPath() %>/LogoutServlet" class="nav-link-custom logout">
            <i class="bi bi-box-arrow-right"></i> Cerrar sesión
        </a>
    </div>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="main-content">

        <!-- NAVBAR SUPERIOR -->
        <div class="navbar-top">
            <input type="text" class="search-box" placeholder="Buscar clientes...">
            <div class="user-info">
                <span style="color:#888; font-size:14px">domingo, 14 de junio</span>
                <div class="bell-badge">
                    <i class="bi bi-bell"></i>
                    <span>4</span>
                </div>
                <div class="avatar"><%= iniciales %></div>
                <div>
                    <div style="font-weight:600; font-size:14px"><%= nombreCompleto %></div>
                    <div style="color:var(--verde); font-size:12px"><%= rol %></div>
                </div>
            </div>
        </div>

        <!-- CUERPO -->
        <div class="content-body">
            <h3 style="color:var(--azul-marino); font-weight:bold">Dashboard</h3>
            <p style="color:#888">Bienvenido(a), <%= nombreCompleto %> — domingo, 14 de junio de 2026</p>

            <!-- CARDS ADAPTADAS A RECEPCIÓN -->
            <div class="row g-3 mt-2">
                <div class="col-md-4">
                    <div class="card-stat">
                        <div class="card-icon" style="background:#e6f1fb; color:#1a3c5e"><i class="bi bi-calendar-check"></i></div>
                        <div class="stat-label mt-3">Citas de Hoy</div>
                        <div class="stat-number">18</div>
                        <div style="color:#888; font-size:12px">Todas las citas del día</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-stat">
                        <div class="card-icon" style="background:#faecd6; color:#e8a33d"><i class="bi bi-clock-history"></i></div>
                        <div class="stat-label mt-3">Citas Pendientes</div>
                        <div class="stat-number">4</div>
                        <div style="color:#888; font-size:12px">Por confirmar</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-stat">
                        <div class="card-icon" style="background:#e1f5ee; color:#2ecc71"><i class="bi bi-people"></i></div>
                        <div class="stat-label mt-3">Clientes Registrados</div>
                        <div class="stat-number">342</div>
                        <div style="color:#888; font-size:12px">8 nuevos este mes</div>
                    </div>
                </div>
            </div>

            <!-- ACCIONES RÁPIDAS -->
            <div class="row g-3 mt-2">
                <div class="col-md-6">
                    <button class="btn-accion-rapida">
                        <i class="bi bi-calendar-plus" style="font-size:20px"></i> Agendar nueva cita
                    </button>
                </div>
                <div class="col-md-6">
                    <button class="btn-accion-rapida">
                        <i class="bi bi-person-plus" style="font-size:20px"></i> Registrar nuevo cliente
                    </button>
                </div>
            </div>

            <div class="mt-4 p-4" style="background:white; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,0.05)">
                <h5 style="color:var(--azul-marino); font-weight:bold">Citas pendientes de confirmar</h5>
                <p style="color:#888; text-align:center; margin:20px 0">Aquí aparecerán las citas por confirmar (se conectará al módulo de Citas)</p>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
