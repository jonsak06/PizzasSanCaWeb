<%-- 
    Document   : Paquete
    Created on : 18/10/2022, 06:42:54 PM
    Author     : Usuario
--%>


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
          <link rel="stylesheet" media="" href="css/estilosCelular.css">
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
                else if(llevadas < vendidas) {
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
        </script>
    </head>
    <body>
        <h1>Crear paquete</h1>
        <form name="crearPaquete" class="formulario" onsubmit="event.preventDefault(); procesar();">
            <label for="fecha">Fecha</label>
            <input id="fecha" name="fecha" type="date" required>
            <br>
            <label for="llevadas">Unidades llevadas</label>
            <input id="llevadas" name="llevadas" type="number" min="1" required>
            <br>
            <label for="vendidas">Unidades vendidas</label>
            <input id="vendidas" name="vendidas" type="number" min="1" required>
            <br>
            <label for="lugar">Lugar</label>
            <select id="lugar" name="lugar" required>
                <option selected>Seleccione...</option>
            <%
                List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
                for(Lugar lugar :lugares) {
                    out.print("<option value='" + lugar.getId() + "' >"+ "[" + lugar.getId() + "] " + lugar + "</option>");
                }
            %>
            </select>
            <br>
            <label for="tanda">Tanda</label>
            <select id="tanda" name="tanda" required>
                <option selected>Seleccione...</option>
            <%
                List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
                for(Tanda tanda :tandas) {
                    out.print("<option  value='" + tanda + "'>[" + tanda + "]   " + tanda.getFechaElaboracion() + "</option>");
                }
            %>
            </select>
            <br>
            <input type="submit" id="boton" value="Crear paquete">
        </form>
    </body>
</html>
