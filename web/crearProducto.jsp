<%-- 
    Document   : crearProducto
    Created on : Oct 12, 2022, 11:04:23 AM
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
        
                let cantidad = document.forms["crearProducto"]["cantidad"].value;
              
                let comp = document.forms["crearProducto"]["comp"].value;
          
                let prov = document.forms["crearProducto"]["prov"].value;
           
                let marca = document.forms["crearProducto"]["marca"].value;
             
                let Precio = document.forms["crearProducto"]["Precio"].value;
           
                let comentario = document.forms["crearProducto"]["comentario"].value;
                
                let myfile = document.forms["crearProducto"]["myfile"].value;
                
                let valoracion = document.forms["crearProducto"]["valoracion"].value;
          
                if (marca === null || marca === "") {
                    alert("marca del Producto requerida");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputProducto.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "cantidad=" + cantidad + "&comp=" + comp+ "&valoracion=" + valoracion+ "&comentario=" + comentario+ "&prov=" + prov+ "&marca=" + marca+ "&Precio=" + Precio+ "&myfile=" + myfile;
                    http.send(params);
                    http.onload = function() {
                        alert("Producto creado");
                    };
                }
            } 
    </script>
    </head>
    <body>
        <form name="crearProducto" onsubmit="event.preventDefault(); procesar();">
            
            <p><label for="comp">Componente</label></p>
            <select name="comp">
            <% 
                List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                for(int i=0; i<componentes.size(); i++){
                out.print("<option value="+ componentes.get(i).getId() +">"+ componentes.get(i).getNombre() +"</option>");
                }
            %>
             </select>    
        
            <p><label for="prov">Proveedor</label></p>
            <select name="prov">
            <%

                List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
                for(int i=0; i<proveedores.size(); i++){
                out.print("<option value="+ proveedores.get(i).getId() +">"+ proveedores.get(i).getNombre() +"</option>");
                }
            %>
             </select>   
            
            <p><label for="marca">Marca</label></p>
            <p><input type="text" id="marca" name="marca"></p>
            
            <p><label for="comentario">Comentario</label></p>
            <p><input type="text" id="comentario" name="comentario"></p>
            
            <p><label for="Precio">Precio</label></p>
            <p><input type="number" id="Precio" name="Precio"></p>
            
            <p><label for="cantidad">Cantidad</label></p>
            <p><input type="number" id="cantidad" name="cantidad"></p>
            
            <p><label for="valoracion">Valoracion</label>
            <select name="valoracion">
                <option value="1" selected>1</option>
                <option value="2" >2</option>
                <option value="3">3</option>
                <option value="4" >4</option>
                <option value="5">5</option>
            </select></p>
            
            <p> <label for="myfile">Select a file:</label>
            <input type="file" id="myfile" name="myfile"></p>
            
            <input type="submit" value="Crear Producto">
        </form>
    </body>
</html>
