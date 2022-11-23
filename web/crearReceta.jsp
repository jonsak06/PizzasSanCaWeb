<%-- 
    Document   : crearReceta
    Created on : Oct 12, 2022, 12:49:01 PM
    Author     : Manuel
--%>

<%@page import="Entidades.Receta"%>
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
        <link rel="stylesheet" media="" href="css/estilosCelular.css">
        <script
  src="https://code.jquery.com/jquery-3.6.1.js"
  integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI="
  crossorigin="anonymous"></script>
          <script>
    
      
    
    function procesar(){
              
                let nombre = document.forms["crearReceta"]["cname"].value;
               
                if (nombre === null || nombre === "") {
                    alert("Nombre del Receta requerido");
                    return false;
                }
                else 
                {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputCrearReceta.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre;
                    http.send(params);
                    http.onload = function() 
                    {
                        document.forms["crearReceta"].reset();
                        alert("Receta creada");
                        $(document).ready(function(){
                            $('#seccionAniadir').load('http://localhost:8080/PizzasSanCaWeb/Input/seaccionAniadir.jsp');
                       });
                    };
                }
            }
            
            
            function modificar(){
              
                let nombre = document.forms["crearReceta"]["cname"].value;
               
                if (nombre === null || nombre === "") {
                    alert("Nombre del Receta requerido");
                    return false;
                }
                else 
                {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/ModificarReceta.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre+ "id=" + id;
                    http.send(params);
                    http.onload = function() 
                    {
                        
                        alert("modificada creada");
                    };
                }
            }
        
    </script>
    <script type="text/javascript">
            
            
            $(document).ready(function(){
                $('#seccionAniadir').load('http://localhost:8080/PizzasSanCaWeb/Input/seaccionAniadir.jsp');
            });
            
          
            
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    
    <body>
        <jsp:include page="Input/barraNavegacion.jsp" />
     
      
        <%
            Receta rec = (Receta) session.getAttribute("receta");
            if(rec == null){
                out.println("<h1>Crear Receta</h1>");
            out.println("<form class=\"formulario\" name=\"crearReceta\" onsubmit=\"event.preventDefault(); modificar();\">");
            out.println("            <p><label for=\"cname\">Nombre de la Receta</label></p>");
            out.println("         <p><input type=\"text\" id=\"cname\" name=\"cname\"></p>");
            out.println("            <input type=\"submit\" value=\"Crear Receta\" required>");
            out.println("        </form>");
            out.println("        ");
            out.println("        ");
            out.println("        ");
            out.println("        <div id=\"seccionAniadir\"></div>");
            }else{
                out.println("<h1>Modificar Receta</h1>");
                out.println("<form class=\"formulario\" name=\"crearReceta\" onsubmit=\"event.preventDefault(); procesar();\">");
            out.println("            <p><label for=\"cname\">Nombre de la Receta</label></p>");
            out.println("         <p><input type=\"text\" id=\"cname\" value=\""+rec.getNombre()+"\" name=\"cname\"></p>");
            out.println("<input id='id' name='id' type='hidden' value='"+rec.getId()+"'>");
            out.println("            <input type=\"submit\" value=\"Crear Receta\" required>");
            
            out.println("        </form>");
            }
            
            
%>
        
        
    </body>
</html>