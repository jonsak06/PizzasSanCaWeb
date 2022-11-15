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
        <link rel="stylesheet" media="" href="css/estilosCelular.css">
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
                } else if(comp === "Seleccione...") {
                    alert("Debe seleccionar un componente");
                    return false;
                } else if(prov === "Seleccione...") {
                    alert("Debe seleccionar un proveedor");
                    return false;
                } else if(valoracion === "Seleccione...") {
                    alert("Debe seleccionar una valoración");
                    return false;
                }
                else {
                    let http = new XMLHttpRequest();
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/inputProducto.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "cantidad=" + cantidad + "&comp=" + comp+ "&valoracion=" + valoracion+ "&comentario=" + comentario+ "&prov=" + prov+ "&marca=" + marca+ "&Precio=" + Precio+ "&myfile=" + myfile;
                    http.send(params);
                    http.onload = function() {
                        document.forms["crearProducto"].reset();
                        alert("Producto creado");
                    };
                }
            } 
    </script>
    </head>
    <body>
        <h1>Crear producto</h1>
        
        <form class="formulario" name="crearProducto" onsubmit="event.preventDefault(); procesar();">
            
            <p><label for="comp">Componente</label></p>
            <select name="comp">
                <option selected>Seleccione...</option>
            <% 
                List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                for(int i=0; i<componentes.size(); i++){
                out.print("<option value="+ componentes.get(i).getId() +">"+ componentes.get(i).getNombre() +"</option>");
                }
            %>
             </select>    
        
            <p><label for="prov">Proveedor</label></p>
            <select name="prov">
                <option selected>Seleccione...</option>
            <%

                List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
                for(int i=0; i<proveedores.size(); i++){
                out.print("<option value="+ proveedores.get(i).getId() +">"+ proveedores.get(i).getNombre() +"</option>");
                }
            %>
             </select>   
            
            <p><label for="marca">Marca</label></p>
            <p><input type="text" id="marca" name="marca" required></p>
            
            <p><label for="comentario">Comentario</label></p>
            <p><input type="text" id="comentario" name="comentario" required></p>
            
            <p><label for="Precio">Precio</label></p>
            <p><input type="number" id="Precio" name="Precio" required></p>
            
            <p><label for="cantidad">Cantidad</label></p>
            <p><input type="number" id="cantidad" name="cantidad" required></p>
            
            <p><label for="valoracion">Valoracion</label></p>
            <select name="valoracion">
                <option selected>Seleccione...</option>
                <option value="1">1</option>
                <option value="2" >2</option>
                <option value="3">3</option>
                <option value="4" >4</option>
                <option value="5">5</option>
            </select>
            
            <p> <label for="myfile">Select a file:</label>
            <input type="file" id="myfile" name="myfile"></p>
            
            <input type="submit" value="Crear Producto">
        </form>
              
    </body>
</html>
