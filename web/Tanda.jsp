<%-- 
    Document   : Tanda
    Created on : 24/10/2022, 10:24:04 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" media="" href="css/estilosCelular.css">
        <title>Tanda</title>
        <script>
            function procesar(){
                const boton = document.getElementById("boton");
                const form = document.forms["crearTanda"];
                const fecha = form["fecha"].value;
                const cmbValoracion = form["valoracion"];
                const valoracion = cmbValoracion.options[cmbValoracion.selectedIndex].value;
                const precioUnitario = form["precioUnitario"].value.trim();
                const cantUnidades = form["cantUnidades"].value.trim();                
                const cantConsumida = form["cantConsumida"].value.trim();
//                const imagen = form["imagen"].value;
                const cmbReceta = form["receta"];
                const receta = cmbReceta.options[cmbReceta.selectedIndex].value;
                
                boton.disabled = true;
                if (fecha === null || fecha === "") {
                    boton.disabled = false;
                    alert("Fecha requerida");
                    return false;
                }
                else if(receta === "Seleccione..."){
                    boton.disabled = false;
                    alert("Debe seleccionar una receta");
                    return false;
                } else if(valoracion === "Seleccione...") {
                    boton.disabled = false;
                    alert("Debe seleccionar una valoración");
                    return false;
                }
                else if(cantConsumida > cantUnidades) {
                    boton.disabled = false;
                    alert("La cantidad consumida no puede superar a la cantidad de unidades");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputTanda.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "fecha=" + fecha + "&valoracion=" + valoracion + "&precioUnitario=" + precioUnitario + "&cantUnidades=" 
                                + cantUnidades + "&cantConsumida=" + cantConsumida /*+ "&imagen=" + imagen */+ "&receta=" + receta;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        form.reset();
                        alert("Tanda creada");
                    };
                }
            }
            
            function modificar(){
                const boton = document.getElementById("boton");
                const form = document.forms["modificarTanda"];
                const id = form["id"].value;
                const fecha = form["fecha"].value;
                const cmbValoracion = form["valoracion"];
                const valoracion = cmbValoracion.options[cmbValoracion.selectedIndex].value;
                const precioUnitario = form["precioUnitario"].value.trim();
                const cantUnidades = form["cantUnidades"].value.trim();                
                const cantConsumida = form["cantConsumida"].value.trim();
//                const imagen = form["imagen"].value;
                const cmbReceta = form["receta"];
                const receta = cmbReceta.options[cmbReceta.selectedIndex].value;
                
                boton.disabled = true;
                if (fecha === null || fecha === "") {
                    boton.disabled = false;
                    alert("Fecha requerida");
                    return false;
                }
                else if(valoracion === "Seleccione...") {
                    boton.disabled = false;
                    alert("Debe seleccionar una valoración");
                    return false;
                }
                else if(cantConsumida > cantUnidades) {
                    boton.disabled = false;
                    alert("La cantidad consumida no puede superar a la cantidad de unidades");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/modificarTanda.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "fecha=" + fecha + "&valoracion=" + valoracion + "&precioUnitario=" + precioUnitario + "&cantUnidades=" 
                                + cantUnidades + "&cantConsumida=" + cantConsumida /*+ "&imagen=" + imagen */+ "&receta=" + receta
                                + "&id=" + id;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        alert("Tanda modificada");
                    };
                }
            }
        </script>
    </head>
    <body>
        <%
            Tanda tanda = (Tanda) session.getAttribute("tanda");
            
            if(tanda == null) {
                out.println("<h1>Crear tanda</h1>");
                out.println("<form name=\"crearTanda\" class=\"formulario\" onsubmit=\"event.preventDefault(); procesar();\">");
                out.println("    <label for=\"fecha\">Fecha de elaboración</label>");
                out.println("    <input id=\"fecha\" name=\"fecha\" type=\"date\" required>");
                out.println("    <br>");
                out.println("    <label for=\"valoracion\">Valoración</label>");
                out.println("    <select id=\"valoracion\" name=\"valoracion\" required>");
                out.println("        <option selected>Seleccione...</option>");
                out.println("        <option value=\"1\">1</option>");
                out.println("        <option value=\"2\">2</option>");
                out.println("        <option value=\"3\">3</option>");
                out.println("        <option value=\"4\">4</option>");
                out.println("        <option value=\"5\">5</option>");
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <label for=\"precioUnitario\">Precio unitario</label>");
                out.println("    <input id=\"precioUnitario\" name=\"precioUnitario\" type=\"number\" min=\"0\" required>");
                out.println("    <br>");
                out.println("    <label for=\"cantUnidades\">Cantidad de unidades</label>");
                out.println("    <input id=\"cantUnidades\" name=\"cantUnidades\" type=\"number\" min=\"0\" required>");
                out.println("    <br>");
                out.println("    <label for=\"cantConsumida\">Cantidad consumida</label>");
                out.println("    <input id=\"cantConsumida\" name=\"cantConsumida\" type=\"number\" min=\"0\" required>");
                out.println("    <br>");
                out.println("    ");
                out.println("    <!--imagen-->");
                out.println("    ");
                out.println("    <label for=\"receta\">Receta</label>");
                out.println("    <select id=\"receta\" name=\"receta\" required>");
                out.println("        <option>Seleccione...</option>");
                List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
                for(Receta receta :recetas) {
                    out.print("<option value='" + receta.getId() + "' >" + "[" + receta.getId() + "] " + receta + "</option>");
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <input type=\"submit\" id=\"boton\" value=\"Crear tanda\">");
                out.println("</form>");
            } else {
                out.println("<h1>Modificar tanda</h1>");
                out.println("<form name=\"modificarTanda\" class=\"formulario\" onsubmit=\"event.preventDefault(); modificar();\">");
                out.println("    <label for=\"fecha\">Fecha de elaboración</label>");
                out.println("    <input value='"+tanda.getFechaElaboracion()+"' id=\"fecha\" name=\"fecha\" type=\"date\" required>");
                out.println("    <br>");
                out.println("    <label for=\"valoracion\">Valoración</label>");
                out.println("    <select value=4 id=\"valoracion\" name=\"valoracion\" required>");
                if(tanda.getValoracion() == 1) {
                    out.println("        <option value=\"1\" selected>1</option>");
                } else {
                    out.println("        <option value=\"1\">1</option>");
                }
                if(tanda.getValoracion() == 2) {
                    out.println("        <option value=\"2\" selected>2</option>");
                } else {
                    out.println("        <option value=\"2\">2</option>");
                }
                if(tanda.getValoracion() == 3) {
                    out.println("        <option value=\"3\" selected>3</option>");
                } else {
                    out.println("        <option value=\"3\">3</option>");
                }
                if(tanda.getValoracion() == 4) {
                    out.println("        <option value=\"4\" selected>4</option>");
                } else {
                    out.println("        <option value=\"4\">4</option>");
                }
                if(tanda.getValoracion() == 5) {
                    out.println("        <option value=\"5\" selected>5</option>");
                } else {
                    out.println("        <option value=\"5\">5</option>");
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <label for=\"precioUnitario\">Precio unitario</label>");
                out.println("    <input value='"+tanda.getPrecioUnitario()+"' id=\"precioUnitario\" name=\"precioUnitario\" type=\"number\" min=\"0\" required>");
                out.println("    <br>");
                out.println("    <label for=\"cantUnidades\">Cantidad de unidades</label>");
                out.println("    <input value='"+tanda.getCantidadUnidades()+"' id=\"cantUnidades\" name=\"cantUnidades\" type=\"number\" min=\"0\" required>");
                out.println("    <br>");
                out.println("    <label for=\"cantConsumida\">Cantidad consumida</label>");
                out.println("    <input value='"+tanda.getCantidadConsumida()+"' id=\"cantConsumida\" name=\"cantConsumida\" type=\"number\" min=\"0\" required>");
                out.println("    <br>");
                out.println("    ");
                out.println("    <!--imagen-->");
                out.println("    ");
                out.println("    <label for=\"receta\">Receta</label>");
                out.println("    <select id=\"receta\" name=\"receta\" required>");
                List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
                for(Receta receta :recetas) {
                    if(tanda.getReceta().getId() != receta.getId()) {
                        out.print("<option value='" + receta.getId() + "' >" + "[" + receta.getId() + "] " + receta + "</option>");
                    } else {
                        out.print("<option value='" + receta.getId() + "' selected>" + "[" + receta.getId() + "] " + receta + "</option>");                        
                    }
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("<input id='id' type='hidden' value='"+tanda.getId()+"'>");
                out.println("    <input type=\"submit\" id=\"boton\" value=\"Modificar tanda\">");
                out.println("</form>");
            }
            
        %>
    </body>
</html>
