<%-- 
    Document   : barraNavegacion
    Created on : 21/11/2022, 12:31:53 AM
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/mdb.dark.min.css" />
        <style>
            nav {
                margin-bottom: 20px;
            }
            body {
                margin-bottom: 35px;
            }
            @media (max-width: 768px) {
                html {
                    font-size: 18px;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-dark navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand text-light" href="http://localhost:8080/PizzasSanCaWeb/index.jsp">PizzasSanCa</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="http://localhost:8080/PizzasSanCaWeb/index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="http://localhost:8080/PizzasSanCaWeb/Busqueda.jsp">Búsqueda</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Insertar
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/Comprador.jsp">Comprador</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/Lugar.jsp">Lugar</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/Paquete.jsp">Paquete</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/Pedido.jsp">Pedido</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/Tanda.jsp">Tanda</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/crearComponente.jsp">Componente</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/crearProducto.jsp">Producto</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/crearProveedor.jsp">Proveedor</a></li>
                                <li><a class="dropdown-item" href="http://localhost:8080/PizzasSanCaWeb/crearReceta.jsp">Receta</a></li>
                            </ul>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>

    </body>
</html>
