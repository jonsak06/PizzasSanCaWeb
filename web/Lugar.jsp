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
        <title>Lugar</title>
         <link rel="stylesheet" media="" href="css/estilosCelular.css">
        <script>
            function procesar(){
                const boton = document.getElementById("boton");
                const form = document.forms["crearLugar"];
                const nombre = form["nombre"].value.trim();
                const direccion = form["direccion"].value.trim();
                
                boton.disabled = true;
                if (nombre === null || nombre === "") {
                    boton.disabled = false;
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
                        boton.disabled = false;
                        form.reset();
                        alert("Lugar creado");
                    };
                   
                }

            } 
            
            function modificar(){
                const boton = document.getElementById("boton");
                const form = document.forms["modificarLugar"];
                const nombre = form["nombre"].value.trim();
                const direccion = form["direccion"].value.trim();
                const idLugar = form["id"].value;
                
                boton.disabled = true;
                if (nombre === null || nombre === "") {
                    boton.disabled = false;
                    alert("Nombre del lugar requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/modificarLugar.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&direccion=" + direccion + "&id=" + idLugar;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        form["nombre"].value = nombre;
                        form["direccion"].value = direccion;
                        alert("Lugar modificado");
                    };
                   
                }

            } 
        </script>
    </head>
    <body>
        <%
            Lugar lugar = (Lugar) session.getAttribute("lugar");
            
            if(lugar == null) {
                out.println("<h1>Crear lugar</h1>");
                out.println("<form class=\"formulario\" name=\"crearLugar\" onsubmit=\"event.preventDefault(); procesar();\">");
                out.println("    <label for=\"nombre\">Nombre</label>");
                out.println("    <input id=\"nombre\" name=\"nombre\" type=\"text\" required>");
                out.println("    <br>");
                out.println("    <label for=\"direccion\">Dirección</label>");
                out.println("    <input id=\"direccion\" name=\"direccion\" type=\"text\">");
                out.println("    <br>");
                out.println("    <input type=\"submit\" id=\"boton\" value=\"Crear lugar\">");
                out.println("</form>");
            } else {
                out.println("<h1>Modificar lugar</h1>");
                out.println("<form class=\"formulario\" name=\"modificarLugar\" onsubmit=\"event.preventDefault(); modificar();\">");
                out.println("    <label for=\"nombre\">Nombre</label>");
                out.println("    <input value="+lugar.getNombre()+" id=\"nombre\" name=\"nombre\" type=\"text\" required>");
                out.println("    <br>");
                out.println("    <label for=\"direccion\">Dirección</label>");
                out.println("    <input value="+lugar.getDireccion()+" id=\"direccion\" name=\"direccion\" type=\"text\">");
                out.println("    <br>");
                out.println("<input id='id' type='hidden' value='"+lugar.getId()+"'>");
                out.println("    <input type=\"submit\" id=\"boton\" value=\"Modificar lugar\">");
                out.println("</form>");
                
                session.removeAttribute("lugar");
            }
            
        %>
<!--        <h1>Crear lugar</h1>
        <form class="formulario" name="crearLugar" onsubmit="event.preventDefault(); procesar();">
            <label for="nombre">Nombre</label>
            <input id="nombre" name="nombre" type="text" required>
            <br>
            <label for="direccion">Dirección</label>
            <input id="direccion" name="direccion" type="text">
            <br>
            <input type="submit" id="boton" value="Crear lugar">
        </form>-->
        
    </body>
</html>
