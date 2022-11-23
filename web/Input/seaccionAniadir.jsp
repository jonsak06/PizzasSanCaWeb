<%-- 
    Document   : seaccionAniadir
    Created on : Oct 24, 2022, 11:12:20 AM
    Author     : Manuel
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Componente"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function aniadir(){
                
           
                let rec = document.forms["aniadirProducto"]["rec"].value;
                let comp = document.forms["aniadirProducto"]["comp"].value;
                let cant = document.forms["aniadirProducto"]["cant"].value;
               
                if(rec === "Seleccione...") {
                    alert("Debe de seleccionar una receta");
                    return false;
                } else if(comp === "Seleccione...") {
                    alert("Debe de seleccionar un componente");
                    return false;
                } else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputAnidirComponenteAReceta.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "rec=" + rec + "&comp=" + comp+ "&cant=" + cant;
                    http.send(params);
                    http.onload = function() 
                    {
                        document.forms["aniadirProducto"].reset();
                        alert("Componente añadido");
                       
                    };
                }
            }
               
         const selectElement = document.forms["aniadirProducto"]["rec"];

selectElement.addEventListener('change', (event) => {
 
    let rec = document.forms["aniadirProducto"]["rec"].value;
         
         $(document).ready(function(){
                $('#resp2').load('http://localhost:8080/PizzasSanCaWeb/Input/crearTabla.jsp?long='+rec);
            });

    

});

function editarUso(idUso, idReceta){
         let http = new XMLHttpRequest();
        let valor = document.getElementById(idUso).value;
        http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/modificarUsoPorReceta.jsp", true);
        
        http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        
        let params = "idUso=" + idUso + "&idReceta=" + idReceta+ "&valor=" + valor;
        
        http.send(params);
          let rec = document.forms["aniadirProducto"]["rec"].value;
         
         $(document).ready(function(){
                $('#resp2').load('http://localhost:8080/PizzasSanCaWeb/Input/crearTabla.jsp?long='+rec);
            });
        alert("Componente editado de la receta");   
    }
    
    
function eliminarUso(idUso, idReceta){
      
       
        let http = new XMLHttpRequest();
        
        http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/eliminarUsoPorReceta.jsp", true);
        
        http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        
        let params = "idUso=" + idUso + "&idReceta=" + idReceta;
        
        http.send(params);
          let rec = document.forms["aniadirProducto"]["rec"].value;
         
         $(document).ready(function(){
                $('#resp2').load('http://localhost:8080/PizzasSanCaWeb/Input/crearTabla.jsp?long='+rec);
            });
        alert("Componente eliminado de la receta");        
    }
            
    </script>
    </head>
    <body>
        <br>
        <h2>Añadir componente a receta</h2>
        <form class="formulario" name="aniadirProducto" onsubmit="event.preventDefault(); aniadir();">
            
             <p><label class="form-label" for="rec" >Receta</label></p>
            <p><select class="rec form-select" name="rec" >
                <option selected>Seleccione...</option>
            <%

                List<Receta> Recetas = PersistenciaMateriales.getInstance().listaRecetas();
                for(int i=0; i<Recetas.size(); i++){
                out.print("<option value="+ Recetas.get(i).getId() +">"+ Recetas.get(i).getNombre() +"</option>");
                }
            %>
             </select></p>  
            
            <p><label class="form-label" for="comp" >Componente</label></p>
            <p><select class="form-select" name="comp">
                <option selected>Seleccione...</option>
            <% 
                List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                for(int i=0; i<componentes.size(); i++){
                out.print("<option value="+ componentes.get(i).getId() +">"+ componentes.get(i).getNombre() +"</option>");
                }
            %>
                </select></p> 
        
            
            
             <p><label class="form-label" for="cant">Cantidad</label></p>
            <p><input class="form-control" type="number" id="cant" name="cant" required></p>
            
          
            <input class="btn btn-primary" type="submit" value="Añadir componente">
        </form>
             
             <div id="resp2"></div>
    </body>
    <script>
   
            
    </script>
</html>

