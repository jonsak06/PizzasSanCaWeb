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
      <h1>Crear Receta</h1>
      
        <form class="formulario" name="crearReceta" onsubmit="event.preventDefault(); procesar();">
            <p><label for="cname">Nombre de la Receta</label></p>
         <p><input type="text" id="cname" name="cname"></p>
            <input type="submit" value="Crear Receta" required>
        </form>
        
        
        
        <div id="seccionAniadir"></div>
        
        
    </body>
</html>