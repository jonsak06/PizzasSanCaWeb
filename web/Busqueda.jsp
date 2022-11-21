<%-- 
    Document   : Busqueda
    Created on : 01/11/2022, 02:33:21 PM
    Author     : Usuario
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
                text-align: right;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            h1, h2, form {
                text-align: center;
            }
            form, .modal {
                padding-left: 15px;
                padding-right: 15px;
            }
            #resultado {
                margin-top: 20px;
            }
            .table-heading {
                font-size: 16px;
            }
            img {
                width: 80%;
                display: block;
                margin-left: auto;
                margin-right: auto;
                width: 50%;
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script>
            function buscar() {
                const form = document.forms["buscarEntidad"];
                const boton = document.getElementById("boton");
                const busqueda = form["busqueda"].value.trim();
                const fecha = form["fecha"].value;
                const cmbEntidad = form["entidad"];
                const entidad = cmbEntidad.options[cmbEntidad.selectedIndex].value;
                
                if (entidad === "Seleccione..."){
                    boton.disabled = false;
                    alert("Debe seleccionar una entidad");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/realizarBusqueda.jsp", true);
                    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    let params = "busqueda=" + busqueda + "&fecha=" + fecha + "&entidad=" + entidad;
                    http.send(params);
                    http.onload = function() {
                        $('#resultado').load(document.URL +  ' #resultado');
                        boton.disabled = false;
                    };
                }
            }
            
        </script>
    </head>
    <body>
        <jsp:include page="Input/barraNavegacion.jsp" />
        
        <h1>Búsqueda</h1>

        <div>
            <form name="buscarEntidad" onsubmit="event.preventDefault(); buscar();">
                <input class="form-control" type="text" name="busqueda" id="busqueda">
                <br>
                <input class="form-control" type="date" id="fecha" name="fecha">
                <br>
                <select class="form-select" name="entidad">
                    <option selected>Seleccione...</option>
                    <option value="lugar">Lugar</option>
                    <option value="comprador">Comprador</option>
                    <option value="tanda">Tanda</option>
                    <option value="pedido">Pedido</option>
                    <option value="paquete">Paquete</option>
                    <option value="proveedor">Proveedor</option>
                    <option value="producto">Producto</option>
                    <option value="receta">Receta</option>
                    <option value="componente">Componente</option>
                </select>
                <br>
                <input class="btn btn-primary" type="submit" id="boton" value="Buscar">
            </form>
        </div>
        <div id="resultado">
            <%
                List<Lugar> lugares = (List<Lugar>) session.getAttribute("listaLugares");
                List<Comprador> compradores = (List<Comprador>) session.getAttribute("listaCompradores");
                List<Tanda> tandas = (List<Tanda>) session.getAttribute("listaTandas");
                List<Pedido> pedidos = (List<Pedido>) session.getAttribute("listaPedidos");
                List<Paquete> paquetes = (List<Paquete>) session.getAttribute("listaPaquetes");
                List<Proveedor> proveedores = (List<Proveedor>) session.getAttribute("listaProveedores");
                List<Producto> productos = (List<Producto>) session.getAttribute("listaProductos");
                List<Receta> recetas = (List<Receta>) session.getAttribute("listaRecetas");
                List<Componente> componentes = (List<Componente>) session.getAttribute("listaComponentes");
                
                SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");


                if(lugares != null && lugares.isEmpty() || compradores != null && compradores.isEmpty() || tandas != null && tandas.isEmpty() || 
                        pedidos != null && pedidos.isEmpty() || paquetes != null && paquetes.isEmpty() || proveedores != null && proveedores.isEmpty() 
                        || productos != null && productos.isEmpty() || recetas != null && recetas.isEmpty() || componentes != null && componentes.isEmpty()) {
                    out.println("<h2>No se encontraron resultados</h2>");

                }else if(lugares != null) {
                    out.println("<h2>Lugares: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Nombre</th>");
                    out.println("        <th class='table-heading'>Dirección</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Lugar l : lugares) {
                        out.print("<tr>" + "<td>" + l + "</td>" + "<td>" + l.getDireccion() + "</td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=lugar-"+l.getId()+"'>Editar</a></td>" + "<td><a id='lugar-" + l.getId() + "' onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");
                    }
                    out.println("</table>");
                } 
                else if(compradores != null) {
                    out.println("<h2>Compradores: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Nombre</th>");
                    out.println("        <th class='table-heading'>Teléfono</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Comprador c : compradores) {
                        out.print("<tr>" + "<td>" + c + "</td>" + "<td>" + c.getTelefono() + "</td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=comprador-"+c.getId()+"'>Editar</a></td>" + "<td><a id=\"comprador-" + c.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                    }
                    out.println("</table>");
                }
                else if(tandas != null){
                    out.println("<h2>Tandas: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Fecha elaboración</th>");
                    out.println("        <th class='table-heading'>Valoración</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Tanda t : tandas) {
                        out.print("<tr>" + "<td>" + formato.format(t.getFechaElaboracion()) + "</td>" + "<td>" + t.getValoracion() + "</td>" + "<td><a id='" + t.getId() + "' onclick='openModalTanda(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=tanda-"+t.getId()+"'>Editar</a></td>" + "<td><a id=\"tanda-" + t.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='tanda" + t.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Tanda</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Fecha elaboración: " + formato.format(t.getFechaElaboracion()));
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
                        if(t.getImagen() != null && !t.getImagen().equals("")) {
//                           out.println("        <p>");
                            out.println("<img alt='imagen de tanda "+t.getId()+"' src='"+t.getImagen()+"'>");
//                            out.println("        </p>"); 
                        }
                        out.println("    </div>");
                        out.println("");
                        out.println("</div>");
                    }
                    out.println("</table>");
                } else if(pedidos != null) {
                    out.println("<h2>Pedidos: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Fecha</th>");
                    out.println("        <th class='table-heading'>Descuento</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for(Pedido p :pedidos) {
                        out.print("<tr>" + "<td>" + formato.format(p.getFecha()) + "</td>" + "<td>" + p.getDescuento() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalPedido(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=pedido-"+p.getId()+"'>Editar</a></td>" + "<td><a id=\"pedido-" + p.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");                    
                        
                        out.println("<div id='pedido" + p.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Pedido</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Fecha: " + formato.format(p.getFecha()));
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
                    out.println("</table>");
                } else if(paquetes != null) {
                    out.println("<h2>Paquetes: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Fecha</th>");
                    out.println("        <th class='table-heading'>Unidades llevadas</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Paquete p : paquetes) {
                        out.print("<tr>" + "<td>" + formato.format(p.getFecha()) + "</td>" + "<td>" + p.getUnidadesLlevadas() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalPaquete(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=paquete-"+p.getId()+"'>Editar</a></td>" + "<td><a id=\"paquete-" + p.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                        out.println("<div id='paquete" + p.getId() + "' class='modal'>");
                        out.println("");
                        out.println("    <div class=\"modal-content\">");
                        out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                        out.println("        <h2>Paquete</h2>");
                        out.println("");
                        out.println("        <p>");
                        out.println("Fecha: " + formato.format(p.getFecha()));
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
                    out.println("</table>");
                } else if(proveedores != null) {
                    out.println("<h2>Proveedores: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Nombre</th>");
                    out.println("        <th class='table-heading'>Teléfono</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Proveedor p : proveedores) {
                        out.print("<tr>" + "<td>" + p.getNombre() + "</td>" + "<td>" + p.getTelefono() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalProveedor(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a id=\"proveedor-" + p.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

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
                    out.println("</table>");
                } else if(productos != null) {
                    out.println("<h2>Productos: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Marca</th>");
                    out.println("        <th class='table-heading'>Información</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Producto p : productos) {
                        out.print("<tr>" + "<td>" + p.getMarca() + "</td>" + "<td>" + p.getComentarios() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalProducto(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a id=\"producto-" + p.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

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
                    out.println("</table>");
                } else if(recetas != null) {
                    out.println("<h2>Recetas: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Código</th>");
                    out.println("        <th class='table-heading'>Nombre</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Receta r : recetas) {
                        out.print("<tr>" + "<td>" + r.getId() + "</td>" + "<td>" + r.getNombre() + "</td>" + "<td><a id='" + r.getId() + "' onclick='openModalReceta(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a id=\"receta-" + r.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

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
                    out.println("</table>");
                } else if(componentes != null) {
                    out.println("<h2>Componentes: </h2>");
                    out.println("<table class='table table-dark table-striped'>");
                    out.println("    <tr>");
                    out.println("        <th class='table-heading'>Nombre</th>");
                    out.println("        <th class='table-heading'>Unidad de medida</th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("        <th class='table-heading'></th>");
                    out.println("    </tr>");
                    for (Componente c : componentes) {
                        out.print("<tr>" + "<td>" + c.getNombre() + "</td>" + "<td>" + c.getUnidadDeMedida() + "</td>" + "<td><a id='" + c.getId() + "' onclick='openModalComponente(this.id);'>Detalles</a></td>" + "<td><a href='#'>Editar</a></td>" + "<td><a id=\"componente-" + c.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

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
                    out.println("</table>");
                }
                
                session.removeAttribute("listaLugares");
                session.removeAttribute("listaCompradores");
                session.removeAttribute("listaTandas");
                session.removeAttribute("listaPedidos");
                session.removeAttribute("listaPaquetes");
                session.removeAttribute("listaProveedores");
                session.removeAttribute("listaProductos");
                session.removeAttribute("listaRecetas");
                session.removeAttribute("listaComponentes");



            %>
        </div>

        <script>
            function eliminar(ent) {
                let http = new XMLHttpRequest();
                http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/eliminarEntidad.jsp", true);
                http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                let param = "eliminar=" + ent;
                http.send(param);
                http.onload = function () {
                alert("Entidad eliminada");
                const elem = document.getElementById(ent).parentElement.parentElement;
                elem.remove();
                };
            }

        </script>
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
