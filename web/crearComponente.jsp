<%-- 
    Document   : crearComponente
    Created on : Oct 12, 2022, 10:21:43 AM
    Author     : Manuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <script>
            function procesar(){
              
                let nombre = document.forms["crearComponente"]["cname"].value;
               
                let cantalert = document.forms["crearComponente"]["cantalert"].value;
                
                let unidadDeMedida = document.forms["crearComponente"]["umed"].value;
                if (nombre === null || nombre === "") {
                    alert("Nombre del Componente requerido");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputComponente.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&unidadDeMedida=" + unidadDeMedida+ "&cantalert=" + cantalert;
                    http.send(params);
                    http.onload = function() {
                        alert("Componente creado");
                    };
                }
            } 
    </script>
    </head>
    
    <body>
      
        <form name="crearComponente" onsubmit="event.preventDefault(); procesar();">
            <p><label for="cname">Nombre del Componente</label></p>
            <p><input type="text" id="cname" name="cname"></p>
            <p><label for="umed">Unidad de Medida</label></p>
            <select name="umed">
                <option value="Kg" selected>Kg</option>
                <option value="mL" >mL</option>
                <option value="g">g</option>
                <option value="L" >L</option>
                <option value="Undividual">Undividual</option>
                <option value="cm³">cm³</option>
                <option value="dm³">dm³</option>
            </select>
            <p><label for="cantalert">Cantidad de Alerta</label></p>
            <p><input type="number" id="cantalert" name="cantalert"></p>
            
            <input type="submit" value="Crear Componente">
        </form>
    </body>
</html>