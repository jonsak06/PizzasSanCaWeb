<%-- 
    Document   : Busqueda
    Created on : 01/11/2022, 02:33:21 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Cantidad"%>
<%@page import="java.io.IOException"%>
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
                width: 80%; 
                height: 100%; 
                overflow: auto; 
                background-color: rgb(0,0,0); 
                background-color: rgba(0,0,0,0.4); 
                text-align:  center;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 2% auto; 
                padding: 20px;
                border: 1px solid #888;
                width: 80%; 
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

        <%!
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            
            //funciones para generar modals
            public void generarModalTanda(Tanda t, JspWriter out) 
                throws IOException
            {
                generarModalReceta(t.getReceta(), out);

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
                out.println("        <p>");
                out.println("Receta: <a id='"+t.getReceta().getId()+"' onclick='closeModal(); openModalReceta(this.id);'>"+t.getReceta().getNombre()+"</a>");
                out.println("        </p>");
                if(t.getImagen() != null && !t.getImagen().equals("")) {
                    out.println("<img alt='imagen de la tanda "+t.getId()+"' src='"+t.getImagen()+"'>");
                }
                out.println("    </div>");
                out.println("");
                out.println("</div>");
            }
            public void generarModalPedido(Pedido p, JspWriter out) 
                throws IOException 
            {
                generarModalTanda(p.getTanda(), out);

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
                out.println("Descuento: " + p.getDescuento()+"%");
                out.println("        </p>");
                out.println("        <p>");
                out.println("Unidades: " + p.getUnidades());
                out.println("        </p>");
                out.println("        <p>");
                out.println("Tanda: <a id='"+p.getTanda().getId()+"' onclick='closeModal(); openModalTanda(this.id);'>["+p.getTanda().getId()+"] "+formato.format(p.getTanda().getFechaElaboracion())+"</a>");
                out.println("        </p>");
                out.println("        <p>");
                out.println("Comprador: "+p.getComprador().getNombre());
                out.println("        </p>");
                out.println("    </div>");
                out.println("");
                out.println("</div>");
            }
            public void generarModalPaquete(Paquete p, JspWriter out) 
                throws IOException 
            {
                generarModalTanda(p.getTanda(), out);
                
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
                out.println("        <p>");
                out.println("Tanda: <a id='"+p.getTanda().getId()+"' onclick='closeModal(); openModalTanda(this.id);'>["+p.getTanda().getId()+"] "+formato.format(p.getTanda().getFechaElaboracion())+"</a>");
                out.println("        </p>");
                out.println("        <p>");
                out.println("Lugar: "+p.getLugar().getNombre());
                out.println("        </p>");
                out.println("    </div>");
                out.println("");
                out.println("</div>");
            }
            public void generarModalProducto(Producto p, JspWriter out) 
                throws IOException 
            {
                generarModalProveedor(p.getProveedor(), out);
                generarModalComponente(p.getComponente(), out);

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
                out.println("        <p>");
                out.println("Cantidad: " + p.getCantidad());
                out.println("        </p>");
                out.println("        <p>");
                out.println("Proveedor: <a id='"+p.getProveedor().getId()+"' onclick='closeModal(); openModalProveedor(this.id);'>"+p.getProveedor().getNombre()+"</a>");
                out.println("        </p>");
                out.println("        <p>");
                out.println("Componente: <a id='"+p.getComponente().getId()+"' onclick='closeModal(); openModalComponente(this.id);'>"+p.getComponente().getNombre()+"</a>");
                out.println("        </p>");
                if(p.getImagen2() != null && !p.getImagen2().equals("")) {
                    out.println("<img alt='imagen del producto "+p.getId()+"' src='"+p.getImagen2()+"'>");
                }
                out.println("    </div>");
                out.println("");
                out.println("</div>");
            }
            public void generarModalProveedor(Proveedor p, JspWriter out) 
                throws IOException 
            {
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
            public void generarModalReceta(Receta r, JspWriter out) 
                throws IOException 
            {
                String unidadMedida = "";
                List<Cantidad> cantidades = PersistenciaMateriales.getInstance().listaCantidades(r.getId());

                out.println("<div id='receta" + r.getId() + "' class='modal'>");
                out.println("");
                out.println("    <div class=\"modal-content\">");
                out.println("        <span onclick='closeModal();' class=\"close\">&times;</span>");
                out.println("        <h2>Receta</h2>");
                out.println("");
                out.println("        <p>");
                out.println("Nombre: " + r.getNombre());
                out.println("        </p>");
                out.println("<br>");
                out.println("<h3>Ingredientes:</h3>");
                for(Cantidad c :cantidades) {
                    generarModalComponente(c.getComponente(), out);
                    if(c.getComponente().getUnidadDeMedida().equals("cmÂ³")) {
                        unidadMedida = "cm³";
                    } else if(c.getComponente().getUnidadDeMedida().equals("dmÂ³")) {
                        unidadMedida = "dm³";
                    } else {
                        unidadMedida = c.getComponente().getUnidadDeMedida();
                    }

                    out.println("        <p>");
                    out.println(c.getComponente().getNombre()+" : "+c.getPorReceta()+ unidadMedida);
                    out.println("        </p>");
                }
                out.println("    </div>");
                out.println("");
                out.println("</div>");
            }
        
            public void generarModalComponente(Componente c, JspWriter out) 
                throws IOException 
            {
                String unidadMedida = "";
                if(c.getUnidadDeMedida().equals("cmÂ³")) {
                    unidadMedida = "cm³";
                } else if(c.getUnidadDeMedida().equals("dmÂ³")) {
                    unidadMedida = "dm³";
                } else {
                    unidadMedida = c.getUnidadDeMedida();
                }

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
                out.println("Unidad de medida: " + unidadMedida);
                out.println("        </p>");
                out.println("        <p>");
                out.println("Cantidad de alerta: " + c.getCantidadDeAlerta());
                out.println("        </p>");
                out.println("    </div>");
                out.println("");
                out.println("</div>");
            }
        
        
        %>
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

                        generarModalTanda(t, out);
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
                        
                        generarModalPedido(p, out);
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

                        generarModalPaquete(p, out);
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
                        out.print("<tr>" + "<td>" + p.getNombre() + "</td>" + "<td>" + p.getTelefono() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalProveedor(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=proveedor-"+p.getId()+"'>Editar</a></td>" + "<td><a id=\"proveedor-" + p.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                        generarModalProveedor(p, out);
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
                        out.print("<tr>" + "<td>" + p.getMarca() + "</td>" + "<td>" + p.getComentarios() + "</td>" + "<td><a id='" + p.getId() + "' onclick='openModalProducto(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=producto-"+p.getId()+"'>Editar</a></td>" + "<td><a id=\"producto-" + p.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                        generarModalProducto(p, out);
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
                        out.print("<tr>" + "<td>" + r.getId() + "</td>" + "<td>" + r.getNombre() + "</td>" + "<td><a id='" + r.getId() + "' onclick='openModalReceta(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=receta-"+r.getId()+"'>Editar</a></td>" + "<td><a id=\"receta-" + r.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                        generarModalReceta(r, out);
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
                        String unMedida = "";
                        if(c.getUnidadDeMedida().equals("cmÂ³")) {
                            unMedida = "cm³";
                        } else if(c.getUnidadDeMedida().equals("dmÂ³")) {
                            unMedida = "dm³";
                        } else {
                            unMedida = c.getUnidadDeMedida();
                        }
                        
                        out.print("<tr>" + "<td>" + c.getNombre() + "</td>" + "<td>" + unMedida + "</td>" + "<td><a id='" + c.getId() + "' onclick='openModalComponente(this.id);'>Detalles</a></td>" + "<td><a href='http://localhost:8080/PizzasSanCaWeb/Input/modificacionEntidades.jsp?entidad=componente-"+c.getId()+"'>Editar</a></td>" + "<td><a id=\"componente-" + c.getId() + "\" onclick='eliminar(this.id);'>Eliminar</a></td>" + "</tr>");

                        generarModalComponente(c, out);
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

        <style>
            .modal {
                overflow: auto; 
            }
            .modal-content {
                width: 80%; 
            }

            .close {
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
            a {
                cursor: pointer;
            }
            h1, h2, form {
                text-align: center;
            }
            h3 {
                font-size: 20px;
            }
            form, .modal {
                padding-left: 15px;
                padding-right: 15px;
            }
            #resultado {
                margin-top: 20px;
            }
            .table-heading {
                font-size: 1.1em;
            }
            img {
                display: block;
                margin-left: auto;
                margin-right: auto;
                width: 60%;
            }
            @media (max-width: 768px) {
                img {
                    width: 80%;
                }
                .modal-content {
                    margin: 10% auto;
                }
            }
        </style>
        
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
