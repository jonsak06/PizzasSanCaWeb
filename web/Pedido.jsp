<%-- 
    Document   : Pedido
    Created on : 24/10/2022, 04:22:57 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Comprador"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        </script>
    </head>
    <body>
        <h1>Crear pedido</h1>
        <form name="crearPedido" onsubmit="event.preventDefault(); procesar();">
            <label for="fecha">Fecha</label>
            <input id="fecha" name="fecha" type="date" required>
            <br>
            <label for="unidades">Unidades</label>
            <input id="unidades" name="unidades" type="number" min="1" required>
            <br>
            <label for="descuento">Descuento</label>
            <input id="descuento" name="descuento" type="number" min="0" max="100" required>
            <br>
            <label for="comprador">Comprador</label>
            <select id="comprador" name="comprador" required>
                <option>Seleccione...</option>
            <%
                List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
                for(Comprador comprador :compradores) {
                    out.print("<option value='" + comprador.getId() + "' >" + comprador + "</option>");
                }
            %>
            </select>
            <br>
            <label for="tanda">Tanda</label>
            <select id="tanda" name="tanda" required>
                <option>Seleccione...</option>
            <%
                List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
                for(Tanda tanda :tandas) {
                    out.print("<option  value='" + tanda + "'>[" + tanda + "]   " + tanda.getFechaElaboracion() + "</option>");
                }
            %>
            </select>
            <br>
            <input type="submit" id="boton" value="Crear pedido">
        </form>
    </body>
</html>
