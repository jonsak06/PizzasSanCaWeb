<%-- 
    Document   : crearComponente
    Created on : Oct 12, 2022, 10:21:43 AM
    Author     : Manuel
--%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Componente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Componente</title>
          <script>
            function procesar(){
              
                let nombre = document.forms["crearComponente"]["cname"].value;
               
                let cantalert = document.forms["crearComponente"]["cantalert"].value;
                
                let unidadDeMedida = document.forms["crearComponente"]["umed"].value;
                if (nombre === null || nombre === "") {
                    alert("Nombre del Componente requerido");
                    return false;
                } else if(unidadDeMedida === "Seleccione...") {
                    alert("Debe seleccionar una unidad de medida");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputComponente.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&unidadDeMedida=" + unidadDeMedida+ "&cantalert=" + cantalert;
                    http.send(params);
                    http.onload = function() {
                        document.forms["crearComponente"].reset();
                        alert("Componente creado");
                    };
                }
            }
            
            function modificar(){
              
                let nombre = document.forms["crearComponente"]["cname"].value;
               let id = document.forms["crearComponente"]["id"].value;
                let cantalert = document.forms["crearComponente"]["cantalert"].value;
                
                let unidadDeMedida = document.forms["crearComponente"]["umed"].value;
                if (nombre === null || nombre === "") {
                    alert("Nombre del Componente requerido");
                    return false;
                } else if(unidadDeMedida === "Seleccione...") {
                    alert("Debe seleccionar una unidad de medida");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/ModificarComponente.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "nombre=" + nombre + "&unidadDeMedida=" + unidadDeMedida+ "&cantalert=" + cantalert + "&id=" + id;
                    http.send(params);
                    http.onload = function() {
                        alert("Componente Modificado");
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
          
          
          Componente comp = (Componente) session.getAttribute("componente");
         
          if(comp == null){
          out.println("<h1 class='crear'>Crear componente</h1>");
          out.println("<form class='formulario' name='crearComponente' onsubmit='event.preventDefault(); procesar();'>");
          out.println("<p><label class=\"form-label\" for='cname'>Nombre del Componente</label></p>");
          out.println("<p><input class=\"form-control\" type='text' id='cname' name='cname' required></p>");
          out.println("<p><label class=\"form-label\" for='umed'>Unidad de Medida</label></p>");
          out.println("<p><select class=\"form-select\" name='umed'>");
          out.println("<option selected>Seleccione...</option>");
          out.println("<option value='Kg'>Kg</option>");
          out.println("<option value='mL' >mL</option>");
          out.println("<option value='g'>g</option>");
          out.println("<option value='L' >L</option>");
          out.println("<option value='Individual'>Individual</option>");
          out.println("<option value='cm³'>cm³</option>");
          out.println("<option value='dm³'>dm³</option>");
          out.println("</select></p>");
          out.println("<p><label class=\"form-label\" for='cantalert'>Cantidad de Alerta</label></p>");
          out.println("<p><input class=\"form-control\" type='number' id='cantalert' name='cantalert' required></p>");
          out.println("<input class=\"btn btn-primary\" type='submit' value='Crear Componente' >");
          out.println("</form>");
          }else{
              
             
              out.println("<h1>Modificar componente</h1>");
          out.println("<form class='formulario' name='crearComponente' onsubmit='event.preventDefault(); modificar();'>");
          out.println("<p><label class=\"form-label\" for='cname' >Nombre del Componente</label></p>");
          out.println("<p><input class=\"form-control\" type='text' id='cname' name='cname' value='"+comp.getNombre()+"' required></p>");
          out.println("<p><label class=\"form-label\" for='umed'>Unidad de Medida</label></p>");
          out.println("<p><select class=\"form-select\" name='umed'>");
          
          if(comp.getUnidadDeMedida().equals("Kg")){
          out.println("<option value='Kg' selected>Kg</option>");
          }else{out.println("<option value='Kg'>Kg</option>");}
          
          if(comp.getUnidadDeMedida().equals("mL")){
          out.println("<option value='mL' selected>mL</option>");
          }else{out.println("<option value='mL' >mL</option>");}
          
          if(comp.getUnidadDeMedida().equals("g")){
          out.println("<option value='g' selected>g</option>");
          }else{out.println("<option value='g'>g</option>");}
                
          if(comp.getUnidadDeMedida().equals("L")){
          out.println("<option value='L'selected >L</option>");
          }else{out.println("<option value='L' >L</option>");}
          
          if(comp.getUnidadDeMedida().equals("Individual")){
          out.println("<option value='Individual' selected>Individual</option>");
          }else{out.println("<option value='Individual'>Individual</option>");}
          
          if(comp.getUnidadDeMedida().equals("cmÂ³")){
          out.println("<option value='cm³' selected>cm³</option>");
          }else{out.println("<option value='cm³'>cm³</option>");}
          
          
          if(comp.getUnidadDeMedida().equals("dmÂ³")){
          out.println("<option value='dm³' selected>dm³</option>");
          }else{out.println("<option value='dm³'>dm³</option>");}
          
          out.println("</select></p>");
          
          out.println("<input id='id' name='id' type='hidden' value='"+comp.getId()+"'>");
          out.println("<p><label class=\"form-label\" for='cantalert' >Cantidad de Alerta</label></p>");
          out.println("<p><input class=\"form-control\" type='number' id='cantalert' name='cantalert' value='"+comp.getCantidadDeAlerta()+"' required></p>");
          out.println("<input class=\"btn btn-primary\" type='submit' value='Modificar Componente' >");
          out.println("</form>");
          
          session.removeAttribute("componente");
          }

        %>
    </body>
</html>
