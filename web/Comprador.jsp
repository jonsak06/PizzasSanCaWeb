<%-- 
    Document   : Comprador
    Created on : 19/10/2022, 06:20:06 AM
    Author     : Usuario
--%>

<%@page import="Entidades.Comprador"%>
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
            
            function modificar(){
                const boton = document.getElementById("boton");
                const form = document.forms["modificarComprador"];
                const nombre = form["nombre"].value.trim();
                const telefono = form["telefono"].value.trim();
                const idComprador = form["id"].value;
                
                boton.disabled = true;
                if (nombre === null || nombre === "") {
                    boton.disabled = false;
                    alert("Nombre del comprador requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/modificarComprador.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&telefono=" + telefono + "&id=" + idComprador;
                    http.send(params); 

                    http.onload = function() {
                        boton.disabled = false;
                        alert("Comprador modificado");
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
            Comprador comprador = (Comprador) session.getAttribute("comprador");
            
            if(comprador == null) {
                out.println("<h1>Crear comprador</h1>");
                out.println("<form  class=\"formulario\" name=\"crearComprador\" onsubmit=\"event.preventDefault(); procesar();\">");
                out.println("    <label class=\"form-label\" for=\"nombre\">Nombre</label>");
                out.println("    <input class=\"form-control\" type=\"text\" name=\"nombre\" id=\"nombre\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"telefono\">Telefono</label>");
                out.println("    <input class=\"form-control\" type=\"text\" name=\"telefono\" id=\"telefono\">");
                out.println("    <br>");
                out.println("    <input class=\"btn btn-primary\" type=\"submit\" id=\"boton\" value=\"Crear comprador\">");
                out.println("</form>");
            } else {
                out.println("<h1>Modificar comprador</h1>");
                out.println("<form  class=\"formulario\" name=\"modificarComprador\" onsubmit=\"event.preventDefault(); modificar();\">");
                out.println("    <label class=\"form-label\" for=\"nombre\">Nombre</label>");
                out.println("    <input class=\"form-control\" value='"+comprador.getNombre()+"' type=\"text\" name=\"nombre\" id=\"nombre\" required>");
                out.println("    <br>");
                out.println("    <label class=\"form-label\" for=\"telefono\">Telefono</label>");
                out.println("    <input class=\"form-control\" value='"+comprador.getTelefono()+"' type=\"text\" name=\"telefono\" id=\"telefono\">");
                out.println("    <br>");
                out.println("<input id='id' type='hidden' value='"+comprador.getId()+"'>");
                out.println("    <input class=\"btn btn-primary\" type=\"submit\" id=\"boton\" value=\"Modificar comprador\">");
                out.println("</form>");
                
                session.removeAttribute("comprador");
            }
            
        %>
    </body>
</html>
