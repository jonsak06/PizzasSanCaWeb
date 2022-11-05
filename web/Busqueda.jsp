<%-- 
    Document   : Busqueda
    Created on : 01/11/2022, 02:33:21 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Componente"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Producto"%>
<%@page import="Entidades.Proveedor"%>
<%@page import="Entidades.Paquete"%>
<%@page import="Entidades.Pedido"%>
<%@page import="Entidades.Tanda"%>
<%@page import="Entidades.Comprador"%>
<%@page import="Entidades.Lugar"%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Búsqueda</title>
        <style>
            .modal {
                display: none; 
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%; 
                height: 100%; 
                overflow: auto; 
                background-color: rgb(0,0,0); 
                background-color: rgba(0,0,0,0.4); 
                text-align:  center;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 15% auto; 
                padding: 20px;
                border: 1px solid #888;
                width: 80%; 
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>

    </head>
    <body>
        <h1>Búsqueda</h1>

        <details>
            <summary>Lugares</summary>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Dirección</th>
                    <th></th>
                    <th></th>
                </tr>
                <%
                    List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
                    for (Lugar l : lugares) {
                        out.print("<tr>" + "<td>" + l + "</td>" + "<td>" + l.getDireccion() + "</td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                    }


                %>

            </table>
        </details>
        <details>
            <summary>Compradores</summary>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Teléfono</th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();

                    for (Comprador c : compradores) {
                        out.print("<tr>" + "<td>" + c + "</td>" + "<td>" + c.getTelefono() + "</td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                    }

                %>

            </table>
        </details>
        <details>
            <summary>Tandas</summary>
            <table>
                <tr>
                    <th>Fecha elaboración</th>
                    <th>Valoración</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();

                    for (Tanda t : tandas) {
                        out.print("<tr>" + "<td>" + t.getFechaElaboracion() + "</td>" + "<td>" + t.getValoracion() + "</td>" + "<td><a id='" + t.getId() + "' onclick='openModalTanda(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='tanda" + t.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Tanda</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Fecha elaboración: " + t.getFechaElaboracion());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Valoración: " + t.getValoracion());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Precio unitario: " + t.getPrecioUnitario());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Cantidad unidades: " + t.getCantidadUnidades());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Cantidad consumida: " + t.getCantidadConsumida());
                        out.println("        </p>");
//                        out.println("        <p>");
//                        out.println("Imagen: " + t.getImagen());
//                        out.println("        </p>");
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>
        <details>
            <summary>Pedidos</summary>
            <table>
                <tr>
                    <th>Fecha</th>
                    <th>Descuento</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Pedido> pedidos = PersistenciaMateriales.getInstance().listaPedidos();

                    for (Pedido p : pedidos) {
                        out.print("<tr>" + "<td>" + p.getFecha() + "</td>" + "<td>" + p.getDescuento() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalPedido(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='pedido" + p.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Pedido</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Fecha: " + p.getFecha());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Descuento: " + p.getDescuento());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Unidades: " + p.getUnidades());
                        out.println("        </p>");
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>
        <details>
            <summary>Paquetes</summary>
            <table>
                <tr>
                    <th>Fecha</th>
                    <th>Unidades llevadas</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Paquete> paquetes = PersistenciaMateriales.getInstance().listaPaquetes();

                    for (Paquete p : paquetes) {
                        out.print("<tr>" + "<td>" + p.getFecha() + "</td>" + "<td>" + p.getUnidadesLlevadas() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalPaquete(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='paquete" + p.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Paquete</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Fecha: " + p.getFecha());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Unidades llevadas: " + p.getUnidadesLlevadas());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Unidades vendidas: " + p.getUnidadesVendidas());
                        out.println("        </p>");
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>
        <details>
            <summary>Proveedores</summary>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Teléfono</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();

                    for (Proveedor p : proveedores) {
                        out.print("<tr>" + "<td>" + p.getNombre() + "</td>" + "<td>" + p.getTelefono() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalProveedor(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='proveedor" + p.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Proveedor</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Nombre: " + p.getNombre());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Teléfono: " + p.getTelefono());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Dirección: " + p.getDireccion());
                        out.println("        </p>");
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>
        <details>
            <summary>Productos</summary>
            <table>
                <tr>
                    <th>Marca</th>
                    <th>Información</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Producto> productos = PersistenciaMateriales.getInstance().listaProductos();

                    for (Producto p : productos) {
                        out.print("<tr>" + "<td>" + p.getMarca() + "</td>" + "<td>" + p.getComentarios() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalProducto(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='producto" + p.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Producto</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Marca: " + p.getMarca());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Información: " + p.getComentarios());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Precio: " + p.getPrecio());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Valoración: " + p.getValoracion());
                        out.println("        </p>");
//                        out.println("        <p>");
//                        out.println("Imagen: " + p.getImagen());
//                        out.println("        </p>");
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>
        <details>
            <summary>Recetas</summary>
            <table>
                <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
                    for (Receta r : recetas) {
                        out.print("<tr>" + "<td>" + r.getId() + "</td>" + "<td>" + r.getNombre() + "</td>" + "<td><a id='" + r.getId() + "' onclick='openModalReceta(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='receta" + r.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Receta</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Nombre: " + r.getNombre());
                        out.println("        </p>");
                        // componentes y cantidades?
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>
        <details>
            <summary>Componentes</summary>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Unidad de medida</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();

                    for (Componente c : componentes) {
                        out.print("<tr>" + "<td>" + c.getNombre() + "</td>" + "<td>" + c.getUnidadDeMedida() + "</td>" + "<td><a id='" + c.getId() + "' onclick='openModalComponente(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='componente" + c.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Componente</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Nombre: " + c.getNombre());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Unidad de medida: " + c.getUnidadDeMedida());
                        out.println("        </p>");
                        out.println("        <p>");
                        out.println("Cantidad de alerta: " + c.getCantidadDeAlerta());
                        out.println("        </p>");
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }

                %>

            </table>
        </details>

        <script>
            let modal = null;
            
            function openModalTanda(clicked_id) {
                modal = document.getElementById("tanda" + clicked_id);
                modal.style.display = "block";
            }

            function openModalPedido(clicked_id) {
                modal = document.getElementById("pedido" + clicked_id);
                modal.style.display = "block";
            }

            function openModalPaquete(clicked_id) {
                modal = document.getElementById("paquete" + clicked_id);
                modal.style.display = "block";
            }
            
            function openModalProducto(clicked_id) {
                modal = document.getElementById("producto" + clicked_id);
                modal.style.display = "block";
            }

            function openModalProveedor(clicked_id) {
                modal = document.getElementById("proveedor" + clicked_id);
                modal.style.display = "block";
            }

            function openModalComponente(clicked_id) {
                modal = document.getElementById("componente" + clicked_id);
                modal.style.display = "block";
            }

            function openModalReceta(clicked_id) {
                modal = document.getElementById("receta" + clicked_id);
                modal.style.display = "block";
            }

            function closeModal() {
                    modal.style.display = "none";
            }

            window.onclick = function (event) {
                if (event.target === modal) {
                    closeModal();
                }
            }
        </script>
    </body>
</html>
