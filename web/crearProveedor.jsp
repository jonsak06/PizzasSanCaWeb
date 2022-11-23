<%-- 
    Document   : crearProveedor
    Created on : Oct 12, 2022, 10:39:43 AM
    Author     : Manuel
--%>

<%@page import="Entidades.Proveedor"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            
            
            function modificar(){
        
                let nombre = document.forms["crearProveedor"]["nameprov"].value;
                
                let dirprov = document.forms["crearProveedor"]["dirprov"].value;
                    
                let telprov = document.forms["crearProveedor"]["telprov"].value;
                
                 let id = document.forms["crearProveedor"]["id"].value;
                if (nombre === null || nombre === "") {
                    alert("Nombre del Proveedor requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/ModificarProveedor.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&direccion=" + dirprov+ "&telefono=" + telprov+ "&id=" + id;
                    http.send(params);
                    http.onload = function() {
                        alert("Proveedor Modificado");
                    };
                }
            } 
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
            Proveedor pro = (Proveedor) session.getAttribute("proveedor");
            if(pro == null){
                out.println("<h1>Crear proveedor</h1>");
                out.println("<form class=\"formulario\" name=\"crearProveedor\" onsubmit=\"event.preventDefault(); procesar();\">");
                out.println("<p><label class=\"form-label\" for=\"nameprov\">Nombre del Proveedor</label></p>");
                out.println("<p><input class=\"form-control\" type=\"text\" id=\"nameprov\" name=\"nameprov\" required></p>");
                out.println("<p><label class=\"form-label\" for=\"dirprov\">Direccion del Proveedor</label></p>");
                out.println("<p><input class=\"form-control\" type=\"text\" id=\"dirprov\" name=\"dirprov\" required></p>");
                out.println("<p><label class=\"form-label\" for=\"telprov\">Telefono del Proveedor</label></p>");
                out.println("<p><input class=\"form-control\" type=\"text\" id=\"telprov\" name=\"telprov\" required></p>");
                out.println("<input class=\"btn btn-primary\" type=\"submit\" value=\"Crear Proveedor\">");
                out.println("</form>");
            }
            else{
               
                out.println("<h1>Modificar proveedor</h1>");
                out.println("<form class=\"formulario\" name=\"crearProveedor\" onsubmit=\"event.preventDefault(); modificar();\">");
                out.println("<p><label class=\"form-label\" for=\"nameprov\">Nombre del Proveedor</label></p>");
                out.println("<p><input class=\"form-control\" type=\"text\" id=\"nameprov\" value=\""+pro.getNombre()+"\" name=\"nameprov\" required></p>");
                out.println("<p><label class=\"form-label\" for=\"dirprov\">Direccion del Proveedor</label></p>");
                out.println("<p><input class=\"form-control\" type=\"text\" id=\"dirprov\" value=\""+pro.getDireccion()+"\" name=\"dirprov\" required></p>");
                out.println("<p><label class=\"form-label\" for=\"telprov\">Telefono del Proveedor</label></p>");
                out.println("<p><input class=\"form-control\" type=\"text\" id=\"telprov\" value=\""+pro.getTelefono()+"\" name=\"telprov\" required></p>");
                out.println("<input id='id' name='id' type='hidden' value='"+pro.getId()+"'>");
                
                out.println("<input class=\"btn btn-primary\" type=\"submit\" value=\"Modificar Proveedor\">");
                out.println("</form>");
                
                session.removeAttribute("proveedor");
            }
        %>  
    </body>
</html>
