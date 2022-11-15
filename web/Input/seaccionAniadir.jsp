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
         <link rel="stylesheet" media="" href="css/estilosCelular.css">
        <script>
            function aniadir(){
                
           
                let rec = document.forms["aniadirProducto"]["rec"].value;
                let comp = document.forms["aniadirProducto"]["comp"].value;
                let cant = document.forms["aniadirProducto"]["cant"].value;
               
                
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputAnidirComponenteAReceta.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "rec=" + rec + "&comp=" + comp+ "&cant=" + cant;
                    http.send(params);
                    http.onload = function() 
                    {
                        document.forms["aniadirProducto"].reset();
                        alert("Producto añadido");
                       
                    };
                
            
        
            }
               
         const selectElement = document.forms["aniadirProducto"]["rec"];

selectElement.addEventListener('change', (event) => {
 
    let rec = document.forms["aniadirProducto"]["rec"].value;
         $.post('crearTabla', {
	long: rec
	}, function(responseText) {
                         
           document.getElementById('resp2').innerHTML = responseText;
                                      
        });


});


            
    </script>
    </head>
    <body>
        <h2>Añadir componentes a recetas</h2>
        <form class="formulario" name="aniadirProducto" onsubmit="event.preventDefault(); aniadir();">
            
             <p><label for="rec" >Receta</label></p>
            <select class="rec" name="rec" >
            <%

                List<Receta> Recetas = PersistenciaMateriales.getInstance().listaRecetas();
                for(int i=0; i<Recetas.size(); i++){
                out.print("<option value="+ Recetas.get(i).getId() +">"+ Recetas.get(i).getNombre() +"</option>");
                }
            %>
             </select>  
            
            <p><label for="comp" >Componente</label></p>
            <select name="comp">
            <% 
                List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                for(int i=0; i<componentes.size(); i++){
                out.print("<option value="+ componentes.get(i).getId() +">"+ componentes.get(i).getNombre() +"</option>");
                }
            %>
             </select>    
        
            
            
            <p><label for="cant">Cantidad</label></p>
            <p><input type="number" id="cant" name="cant" required></p>
            
          
            <input type="submit" value="aniadir Producto">
        </form>
             
             <div id="resp2"></div>
    </body>
    <script>
   
            
    </script>
</html>
