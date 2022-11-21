<%-- 
    Document   : Pedido
    Created on : 24/10/2022, 04:22:57 PM
    Author     : Usuario
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entidades.Pedido"%>
<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Comprador"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" media="" href="css/estilosCelular.css">
        <title>Pedido</title>
        <script>
            function procesar(){
                const boton = document.getElementById("boton");
                const form = document.forms["crearPedido"];
                const fecha = form["fecha"].value;
                const unidades = form["unidades"].value.trim();
                const descuento = form["descuento"].value.trim();
                const cmbComprador = form["comprador"];
                const cmbTanda = form["tanda"];
                const comprador = cmbComprador.options[cmbComprador.selectedIndex].value;
                const tanda = cmbTanda.options[cmbTanda.selectedIndex].value;
                
                boton.disabled = true;
                if (fecha === null || fecha === "") {
                    boton.disabled = false;
                    alert("Fecha requerida");
                    return false;
                }
                else if(comprador === "Seleccione..."){
                    boton.disabled = false;
                    alert("Debe seleccionar un lugar");
                    return false;
                }
                else if(tanda === "Seleccione..."){
                    boton.disabled = false;
                    alert("Debe seleccionar una tanda");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputPedido.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "fecha=" + fecha + "&unidades=" + unidades + "&descuento=" + descuento + "&comprador=" + comprador + "&tanda=" + tanda;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        form.reset();
                        alert("Pedido creado");
                    };
                }
            }
            
            function modificar(){
                const boton = document.getElementById("boton");
                const form = document.forms["modificarPedido"];
                const id = form["id"].value;
                const fecha = form["fecha"].value;
                const unidades = form["unidades"].value.trim();
                const descuento = form["descuento"].value.trim();
                const cmbComprador = form["comprador"];
                const cmbTanda = form["tanda"];
                const comprador = cmbComprador.options[cmbComprador.selectedIndex].value;
                const tanda = cmbTanda.options[cmbTanda.selectedIndex].value;
                
                boton.disabled = true;
                if (fecha === null || fecha === "") {
                    boton.disabled = false;
                    alert("Fecha requerida");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/modificarPedido.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "fecha=" + fecha + "&unidades=" + unidades + "&descuento=" + descuento + "&comprador=" + comprador + "&tanda=" + tanda + "&id=" + id;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        alert("Pedido modificado");
                    };
                }
            }
        </script>
    </head>
    <body>
        
        <%
            Pedido pedido = (Pedido) session.getAttribute("pedido");
            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
            
            if(pedido == null) {
                out.println("<h1>Crear pedido</h1>");
                out.println("<form name=\"crearPedido\" class=\"formulario\" onsubmit=\"event.preventDefault(); procesar();\">");
                out.println("    <label for=\"fecha\">Fecha</label>");
                out.println("    <input id=\"fecha\" name=\"fecha\" type=\"date\" required>");
                out.println("    <br>");
                out.println("    <label for=\"unidades\">Unidades</label>");
                out.println("    <input id=\"unidades\" name=\"unidades\" type=\"number\" min=\"1\" required>");
                out.println("    <br>");
                out.println("    <label for=\"descuento\">Descuento (%)</label>");
                out.println("    <input id=\"descuento\" name=\"descuento\" type=\"number\" min=\"0\" max=\"100\" required>");
                out.println("    <br>");
                out.println("    <label for=\"comprador\">Comprador</label>");
                out.println("    <select id=\"comprador\" name=\"comprador\" required>");
                out.println("        <option selected>Seleccione...</option>");
                List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
                for(Comprador comprador :compradores) {
                    out.print("<option value='" + comprador.getId() + "' >" + "[" + comprador.getId() + "] " + comprador + "</option>");
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <label for=\"tanda\">Tanda</label>");
                out.println("    <select id=\"tanda\" name=\"tanda\" required>");
                out.println("        <option selected>Seleccione...</option>");
                List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
                for(Tanda tanda :tandas) {
                    out.print("<option  value='" + tanda + "'>[" + tanda + "]   " + formato.format(tanda.getFechaElaboracion()) + "</option>");
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <input type=\"submit\" id=\"boton\" value=\"Crear pedido\">");
                out.println("</form>");
            } else {
                SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                
                out.println("<h1>Modificar pedido</h1>");
                out.println("<form name=\"modificarPedido\" class=\"formulario\" onsubmit=\"event.preventDefault(); modificar();\">");
                out.println("    <label for=\"fecha\">Fecha</label>");
                out.println("    <input value='"+ft.format(pedido.getFecha())+"' id=\"fecha\" name=\"fecha\" type=\"date\" required>");
                out.println("    <br>");
                out.println("    <label for=\"unidades\">Unidades</label>");
                out.println("    <input value='"+pedido.getUnidades()+"' id=\"unidades\" name=\"unidades\" type=\"number\" min=\"1\" required>");
                out.println("    <br>");
                out.println("    <label for=\"descuento\">Descuento (%)</label>");
                out.println("    <input value='"+pedido.getDescuento()+"' id=\"descuento\" name=\"descuento\" type=\"number\" min=\"0\" max=\"100\" required>");
                out.println("    <br>");
                out.println("    <label for=\"comprador\">Comprador</label>");
                out.println("    <select id=\"comprador\" name=\"comprador\" required>");
                List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
                for(Comprador comprador :compradores) {
                    if(pedido.getComprador().getId() != comprador.getId()) {
                        out.print("<option value='" + comprador.getId() + "' >" + "[" + comprador.getId() + "] " + comprador + "</option>");
                    } else {
                        out.print("<option value='" + comprador.getId() + "' selected>" + "[" + comprador.getId() + "] " + comprador + "</option>");
                    }
                    
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("    <label for=\"tanda\">Tanda</label>");
                out.println("    <select id=\"tanda\" name=\"tanda\" required>");
                List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
                for(Tanda tanda :tandas) {
                    if(pedido.getTanda().getId() != tanda.getId()) {
                        out.print("<option  value='" + tanda + "'>[" + tanda + "]   " + formato.format(tanda.getFechaElaboracion()) + "</option>");
                    } else {
                        out.print("<option  value='" + tanda + "' selected>[" + tanda + "]   " + formato.format(tanda.getFechaElaboracion()) + "</option>");
                    }
                }
                out.println("    </select>");
                out.println("    <br>");
                out.println("<input id='id' type='hidden' value='"+pedido.getId()+"'>");
                out.println("    <input type=\"submit\" id=\"boton\" value=\"Modificar pedido\">");
                out.println("</form>");
                
                session.removeAttribute("pedido");
            }
            
        %>
        
        
        
    </body>
</html>
