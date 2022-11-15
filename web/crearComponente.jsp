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
        <link rel="stylesheet" media="" href="css/estilosCelular.css">
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
                        document.forms["crearComponente"].reset();
                        alert("Componente Modificado");
                    };
                }
            } 
    </script>
    </head>
    
    <body>
        
      <%
          
          
          
          String id = "3";
          if(id == null){
          out.println("<h1>Crear componente</h1>");
          out.println("<form class='formulario' name='crearComponente' onsubmit='event.preventDefault(); procesar();'>");
          out.println("<p><label for='cname'>Nombre del Componente</label></p>");
          out.println("<p><input type='text' id='cname' name='cname' required></p>");
          out.println("<p><label for='umed'>Unidad de Medida</label></p>");
          out.println("<select name='umed'>");
          out.println("<option selected>Seleccione...</option>");
          out.println("<option value='Kg'>Kg</option>");
          out.println("<option value='mL' >mL</option>");
          out.println("<option value='g'>g</option>");
          out.println("<option value='L' >L</option>");
          out.println("<option value='Undividual'>Undividual</option>");
          out.println("<option value='cm³'>cm³</option>");
          out.println("<option value='dm³'>dm³</option>");
          out.println("</select>");
          out.println("<p><label for='cantalert'>Cantidad de Alerta</label></p>");
          out.println("<p><input type='number' id='cantalert' name='cantalert' required></p>");
          out.println("<input type='submit' value='Crear Componente' >");
          out.println("</form>");
          }else{
              
              Componente comp = null;
              List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                for(int i=0; i<componentes.size(); i++){
                    if(componentes.get(i).getId()== Long.parseLong(id) ){
                        comp=componentes.get(i);
                    }
                }
              out.println("<h1>Modificar componente</h1>");
          out.println("<form class='formulario' name='crearComponente' onsubmit='event.preventDefault(); modificar();'>");
          out.println("<p><label for='cname' >Nombre del Componente</label></p>");
          out.println("<p><input type='text' id='cname' name='cname' value='"+comp.getNombre()+"' required></p>");
          out.println("<p><label for='umed'>Unidad de Medida</label></p>");
          out.println("<select name='umed'>");
          
          if(comp.getUnidadDeMedida()=="Kg"){
          out.println("<option value='Kg' selected>Kg</option>");
          }else{out.println("<option value='Kg'>Kg</option>");}
          
          if(comp.getUnidadDeMedida()=="mL"){
          out.println("<option value='mL' selected>mL</option>");
          }else{out.println("<option value='mL' >mL</option>");}
          
          if(comp.getUnidadDeMedida()=="g"){
          out.println("<option value='g' selected>g</option>");
          }else{out.println("<option value='g'>g</option>");}
                
          if(comp.getUnidadDeMedida()=="L"){
          out.println("<option value='L'selected >L</option>");
          }else{out.println("<option value='L' >L</option>");}
          
          if(comp.getUnidadDeMedida()=="Undividual"){
          out.println("<option value='Undividual' selected>Undividual</option>");
          }else{out.println("<option value='Undividual'>Undividual</option>");}
          
          if(comp.getUnidadDeMedida()=="cmÂ³"){
          out.println("<option value='cm³' selected>cm³</option>");
          }else{out.println("<option value='cm³'>cm³</option>");}
          
          
          if(comp.getUnidadDeMedida()=="dmÂ³"){
          out.println("<option value='dm³' selected>dm³</option>");
          }else{out.println("<option value='dm³'>dm³</option>");}
          
          out.println("</select>");
          
          out.println("<input id='id' name='id' type='hidden' value='"+comp.getId()+"'>");
          out.println("<p><label for='cantalert' >Cantidad de Alerta</label></p>");
          out.println("<p><input type='number' id='cantalert' name='cantalert' value='"+comp.getCantidadDeAlerta()+"' required></p>");
          out.println("<input type='submit' value='Modificar Componente' >");
          out.println("</form>");
          }
           

                    %>
    </body>
</html>
