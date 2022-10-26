<%-- 
    Document   : Tanda
    Created on : 24/10/2022, 10:24:04 PM
    Author     : Usuario
--%>

<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tanda</title>
        <script>
            function procesar(){
                const boton = document.getElementById("boton");
                const form = document.forms["crearTanda"];
                const fecha = form["fecha"].value;
                const valoracion = form["valoracion"].value.trim();
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
        </script>
    </head>
    <body>
        <h1>Crear tanda</h1>
        <form name="crearTanda" onsubmit="event.preventDefault(); procesar();">
            <label for="fecha">Fecha de elaboración</label>
            <input id="fecha" name="fecha" type="date" required>
            <br>
            <label for="valoracion">Valoración</label>
            <input id="valoracion" name="valoracion" type="number" min="0" max="10" required>
            <br>
            <label for="precioUnitario">Precio unitario</label>
            <input id="precioUnitario" name="precioUnitario" type="number" min="0" required>
            <br>
            <label for="cantUnidades">Cantidad de unidades</label>
            <input id="cantUnidades" name="cantUnidades" type="number" min="0" required>
            <br>
            <label for="cantConsumida">Cantidad consumida</label>
            <input id="cantConsumida" name="cantConsumida" type="number" min="0" required>
            <br>
            
            <!--imagen-->
            
            <label for="receta">Receta</label>
            <select id="receta" name="receta" required>
                <option>Seleccione...</option>
            <%
                List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
                for(Receta receta :recetas) {
                    out.print("<option value='" + receta.getId() + "' >" + receta + "</option>");
                }
            %>
            </select>
            <br>
            <input type="submit" id="boton" value="Crear tanda">
        </form>
    </body>
</html>