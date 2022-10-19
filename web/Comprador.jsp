<%-- 
    Document   : Comprador
    Created on : 19/10/2022, 06:20:06 AM
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comprador</title>
        <script>
            function procesar(){
                const boton = document.getElementById("boton");
                const form = document.forms["crearComprador"];
                const nombre = form["nombre"].value.trim();
                const telefono = form["telefono"].value.trim();
                
                boton.disabled = true;
                if (nombre === null || nombre === "") {
                    boton.disabled = false;
                    alert("Nombre del comprador requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputComprador.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&telefono=" + telefono;
                    http.send(params);

                    http.onload = function() {
                        boton.disabled = false;
                        form.reset();
                        alert("Comprador creado");
                    };
                }
            } 
        </script>
    </head>
    <body>
        <h1>Comprador</h1>
        <form name="crearComprador" onsubmit="event.preventDefault(); procesar();">
            <label for="nombre">Nombre</label>
            <input type="text" name="nombre" id="nombre" required>
            <br>
            <label for="telefono">Telefono</label>
            <input type="text" name="telefono" id="telefono">
            <br>
            <input type="submit" id="boton" value="Crear comprador">
        </form>
    </body>
</html>
