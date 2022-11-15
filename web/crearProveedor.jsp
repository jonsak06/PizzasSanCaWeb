<%-- 
    Document   : crearProveedor
    Created on : Oct 12, 2022, 10:39:43 AM
    Author     : Manuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link rel="stylesheet" media="" href="css/estilosCelular.css">
        <script>
            function procesar(){
              
                let nombre = document.forms["crearProveedor"]["nameprov"].value;
                
                let dirprov = document.forms["crearProveedor"]["dirprov"].value;
                    
                let telprov = document.forms["crearProveedor"]["telprov"].value;
                if (nombre === null || nombre === "") {
                    alert("Nombre del Proveedor requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputProveedor.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&direccion=" + dirprov+ "&telefono=" + telprov;
                    http.send(params);
                    http.onload = function() {
                        document.forms["crearProveedor"].reset();
                        alert("Proveedor Creado");
                    };
                }
            } 
    </script>
    </head>
    <body>
        <h1>Crear proveedor</h1>
        <form class="formulario" name="crearProveedor" onsubmit="event.preventDefault(); procesar();">
            <p><label for="nameprov">Nombre del Proveedor</label></p>
            <p><input type="text" id="nameprov" name="nameprov" required></p>
            <p><label for="dirprov">Direccion del Proveedor</label></p>
            <p><input type="text" id="dirprov" name="dirprov" required></p>
            <p><label for="telprov">Telefono del Proveedor</label></p>
            <p><input type="text" id="telprov" name="telprov" required></p>
            
            <input type="submit" value="Crear Proveedor">
        </form>
    </body>
</html>
