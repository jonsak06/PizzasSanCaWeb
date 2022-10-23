<%-- 
    Document   : crearReceta
    Created on : Oct 12, 2022, 12:49:01 PM
    Author     : Manuel
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="Entidades.Proveedor"%>
<%@page import="Entidades.Componente"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <script>
            function procesar(){
              
                let nombre = document.forms["crearReceta"]["cname"].value;
               
                if (nombre === null || nombre === "") {
                    alert("Nombre del Receta requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputCrearReceta.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre;
                    http.send(params);
                    http.onload = function() {
                        alert("Receta creada");
                    };
                }
            } 
    </script>
    </head>
    
    <body>
      
        <form name="crearReceta" onsubmit="event.preventDefault(); procesar();">
            <p><label for="cname">Nombre de la Receta</label></p>
         <p><input type="text" id="cname" name="cname"></p>
            <input type="submit" value="Crear Receta">
        </form>
    </body>
</html>