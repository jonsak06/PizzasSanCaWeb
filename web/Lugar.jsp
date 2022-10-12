<%-- 
    Document   : Lugar
    Created on : 10/10/2022, 07:19:20 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Lugar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function procesar(){
                let nombre = document.forms["crearLugar"]["nombre"].value;
                let direccion = document.forms["crearLugar"]["direccion"].value;
                if (nombre === null || nombre === "") {
                    alert("Nombre del lugar requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputLugar.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&direccion=" + direccion;
                    http.send(params);
                    http.onload = function() {
                        alert("Lugar creado");
                    };
                }
            } 
        </script>
    </head>
    <body>
        <h1>Crear lugar</h1>
        <form name="crearLugar" onsubmit="event.preventDefault(); procesar();">
            <label for="nombre">Nombre</label>
            <input id="nombre" name="nombre" type="text">
            <label for="direccion">Dirección</label>
            <input id="direccion" name="direccion" type="text">
            <input type="submit" value="Crear lugar">
        </form>
        
    </body>
</html>
