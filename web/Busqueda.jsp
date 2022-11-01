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

                <%                    
                    List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();

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
                        out.print("<tr>" + "<td>" + t.getFechaElaboracion() + "</td>" + "<td>" + t.getValoracion() + "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

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
                        out.print("<tr>" + "<td>" + p.getFecha()+ "</td>" + "<td>" + p.getDescuento()+ "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

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
                        out.print("<tr>" + "<td>" + p.getFecha()+ "</td>" + "<td>" + p.getUnidadesLlevadas()+ "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

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

                    for (Proveedor p :proveedores) {
                        out.print("<tr>" + "<td>" + p.getNombre()+ "</td>" + "<td>" + p.getTelefono()+ "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

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
                        out.print("<tr>" + "<td>" + p.getMarca()+ "</td>" + "<td>" + p.getComentarios()+ "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

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
                        out.print("<tr>" + "<td>" + r.getId() + "</td>" + "<td>" + r.getNombre()+ "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                    }

                %>

            </table>
        </details>
        <details>
            <summary>Componentes</summary>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Unidad</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();

                    for (Componente c : componentes) {
                        out.print("<tr>" + "<td>" + c.getNombre()+ "</td>" + "<td>" + c.getUnidadDeMedida()+ "</td>" + "<td><a href='#'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a href='#'>Eliminar</a></td>" + "</tr>");

                    }

                %>

            </table>
        </details>
    </body>
</html>
