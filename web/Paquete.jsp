<%-- 
    Document   : Paquete
    Created on : 18/10/2022, 06:42:54 PM
    Author     : Usuario
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entidades.Paquete"%>
<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Lugar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Paquete</title>
        <script>
            function procesar(){
                const boton = document.getElementById("boton");
                const form = document.forms["crearPaquete"];
                const fecha = form["fecha"].value;
                const llevadas = form["llevadas"].value.trim();
                const vendidas = form["vendidas"].value.trim();
                const cmbLugar = form["lugar"];
                const cmbTanda = form["tanda"];
                const lugar = cmbLugar.options[cmbLugar.selectedIndex].value;
                const tanda = cmbTanda.options[cmbTanda.selectedIndex].value;
                
                boton.disabled = true;
                if (fecha === null || fecha === "") {
                    boton.disabled = false;
                    alert("Fecha requerida");
                    return false;
                }
                else if(lugar === "Seleccione..."){
                    boton.disabled = false;
                    alert("Debe seleccionar un lugar");
                    return false;
                }
                else if(tanda === "Seleccione..."){
                    boton.disabled = false;
                    alert("Debe seleccionar una tanda");
                    return false;
                }
                else if(parseInt(llevadas) < parseInt(vendidas)) {
                    boton.disabled = false;
                    alert("Las unidades vendidas no pueden superar a las llevadas");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputPaquete.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "fecha=" + fecha + "&llevadas=" + llevadas + "&vendidas=" + vendidas + "&lugar=" + lugar + "&tanda=" + tanda;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        form.reset();
                        alert("Paquete creado");
                    };
                }
            }
            
            function modificar(){
                const boton = document.getElementById("boton");
                const form = document.forms["modificarPaquete"];
                const id = form["id"].value;
                const fecha = form["fecha"].value;
                const llevadas = form["llevadas"].value.trim();
                const vendidas = form["vendidas"].value.trim();
                const cmbLugar = form["lugar"];
                const cmbTanda = form["tanda"];
                const lugar = cmbLugar.options[cmbLugar.selectedIndex].value;
                const tanda = cmbTanda.options[cmbTanda.selectedIndex].value;
                
                boton.disabled = true;
                if (fecha === null || fecha === "") {
                    boton.disabled = false;
                    alert("Fecha requerida");
                    return false;
                }
                else if(llevadas < vendidas) {
                    boton.disabled = false;
                    alert("Las unidades vendidas no pueden superar a las llevadas");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/modificarPaquete.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "fecha=" + fecha + "&llevadas=" + llevadas + "&vendidas=" + vendidas + "&lugar=" + lugar + "&tanda=" + tanda + "&id=" + id;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        alert("Paquete modificado");
                    };
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="Input/barraNavegacion.jsp" />
        <style>
            body {
                text-align: center;
            }
            form {
                padding-left: 15%;
                padding-right: 15%;
            }
        </style>
        <%
            Paquete paquete = (Paquete) session.getAttribute("paquete");
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            
            if(paquete == null) {
                out.println("<h1>Crear paquete</h1>");
                out.println("<form name=\"crearPaquete\" class=\"formulario\" onsubmit=\"event.preventDefault(); procesar();\">");
                out.println("    <label class=\"form-label\" for=\"fecha\">Fecha</label>");
                out.println("    <input class=\"form-control\" id=\"fecha\" name=\"fecha\" type=\"date\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"llevadas\">Unidades llevadas</label>");
                out.println("    <input class=\"form-control\" id=\"llevadas\" name=\"llevadas\" type=\"number\" min=\"1\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"vendidas\">Unidades vendidas</label>");
                out.println("    <input class=\"form-control\" id=\"vendidas\" name=\"vendidas\" type=\"number\" min=\"1\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"lugar\">Lugar</label>");
                out.println("    <select class=\"form-select\" id=\"lugar\" name=\"lugar\" required>");
                out.println("        <option selected>Seleccione...</option>");
                List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
                for(Lugar lugar :lugares) {
                    out.print("<option value='" + lugar.getId() + "' >"+ "[" + lugar.getId() + "] " + lugar + "</option>");
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"tanda\">Tanda</label>");
                out.println("    <select class=\"form-select\" id=\"tanda\" name=\"tanda\" required>");
                out.println("        <option selected>Seleccione...</option>");
                List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
                for(Tanda tanda :tandas) {
                    out.print("<option  value='" + tanda + "'>[" + tanda + "]   " + formato.format(tanda.getFechaElaboracion()) + "</option>");
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <input class=\"btn btn-primary\" type=\"submit\" id=\"boton\" value=\"Crear paquete\">");
                out.println("</form>");
            } else {
                SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                
                out.println("<h1>Modificar paquete</h1>");
                out.println("<form name=\"modificarPaquete\" class=\"formulario\" onsubmit=\"event.preventDefault(); modificar();\">");
                out.println("    <label class=\"form-label\" for=\"fecha\">Fecha</label>");
                out.println("    <input class=\"form-control\" value='"+ft.format(paquete.getFecha())+"' id=\"fecha\" name=\"fecha\" type=\"date\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"llevadas\">Unidades llevadas</label>");
                out.println("    <input class=\"form-control\" value='"+paquete.getUnidadesLlevadas()+"' id=\"llevadas\" name=\"llevadas\" type=\"number\" min=\"1\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"vendidas\">Unidades vendidas</label>");
                out.println("    <input class=\"form-control\" value='"+paquete.getUnidadesVendidas()+"' id=\"vendidas\" name=\"vendidas\" type=\"number\" min=\"1\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"lugar\">Lugar</label>");
                out.println("    <select class=\"form-select\" id=\"lugar\" name=\"lugar\" required>");
                List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
                for(Lugar lugar :lugares) {
                    if(paquete.getLugar().getId() != lugar.getId()) {
                        out.print("<option value='" + lugar.getId() + "' >"+ "[" + lugar.getId() + "] " + lugar + "</option>");
                    } else {
                        out.print("<option value='" + lugar.getId() + "' selected>"+ "[" + lugar.getId() + "] " + lugar + "</option>");
                    }
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"tanda\">Tanda</label>");
                out.println("    <select class=\"form-select\" id=\"tanda\" name=\"tanda\" required>");
                List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
                for(Tanda tanda :tandas) {
                    if(paquete.getTanda().getId() != tanda.getId()) {
                        out.print("<option  value='" + tanda + "'>[" + tanda + "]   " + formato.format(tanda.getFechaElaboracion()) + "</option>");
                    } else {
                        out.print("<option  value='" + tanda + "' selected>[" + tanda + "]   " + formato.format(tanda.getFechaElaboracion()) + "</option>");
                    }
                    
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("<input id='id' type='hidden' value='"+paquete.getId()+"'>");
                out.println("    <input class=\"btn btn-primary\" type=\"submit\" id=\"boton\" value=\"Modificar paquete\">");
                out.println("</form>");
                
                session.removeAttribute("paquete");
            }
            
        %>
        
        
    </body>
</html>
