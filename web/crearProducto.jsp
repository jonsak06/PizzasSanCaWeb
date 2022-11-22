<%-- 
    Document   : crearProducto
    Created on : Oct 12, 2022, 11:04:23 AM
    Author     : Manuel
--%>
<%@page import="Entidades.Producto"%>
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
                
                let imagen = document.forms["crearProducto"]["imagen"].value;
                
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
                    let params = "cantidad=" + cantidad + "&comp=" + comp+ "&valoracion=" + valoracion+ "&comentario=" + comentario+ "&prov=" + prov+ "&marca=" + marca+ "&Precio=" + Precio+ "&imagen=" + imagen;
                    http.send(params);
                    http.onload = function() {
                        document.forms["crearProducto"].reset();
                        alert("Producto creado");
                    };
                }
            } 
            
            
            function editar(){
        
                let cantidad = document.forms["crearProducto"]["cantidad"].value;
              
                let comp = document.forms["crearProducto"]["comp"].value;
          
                let prov = document.forms["crearProducto"]["prov"].value;
           
                let marca = document.forms["crearProducto"]["marca"].value;
             
                let Precio = document.forms["crearProducto"]["Precio"].value;
           
                let comentario = document.forms["crearProducto"]["comentario"].value;
                
                let imagen = document.forms["crearProducto"]["imagen"].value;
                
                let valoracion = document.forms["crearProducto"]["valoracion"].value;
                
                let id = document.forms["crearProducto"]["id"].value;
          
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
                    http.open("POST", "http://localhost:8080/PizzasSanCaWeb/Input/ModificarProducto.jsp", true);
                    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    let params = "cantidad=" + cantidad + "&comp=" + comp+ "&valoracion=" + valoracion+ "&comentario=" + comentario+ "&prov=" + prov+ "&marca=" + marca+ "&Precio=" + Precio+ "&imagen=" + imagen + "&id=" + id;
                    http.send(params);
                    http.onload = function() {
                        alert("Producto modificado");
                    };
                }
            } 
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <jsp:include page="Input/barraNavegacion.jsp" />
        <%
            
            
             Producto pro = (Producto) session.getAttribute("producto");
            if(pro==null){
                out.print("<h1>Crear producto</h1>");
                out.print("<form class='formulario' name='crearProducto' onsubmit='event.preventDefault(); procesar();'>");
                out.print("<p><label for='comp'>Componente</label></p>");
                out.print("<select name='comp'>");
                out.print("<option selected>Seleccione...</option>");
                List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                    for(int i=0; i<componentes.size(); i++){
                    out.print("<option value="+ componentes.get(i).getId() +">"+ componentes.get(i).getNombre() +"</option>");
                    }
                out.print("</select>");
                out.print("<p><label for='prov'>Proveedor</label></p>");
                out.print("<select name='prov'>");
                out.print("<option selected>Seleccione...</option>");
                 List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
                    for(int i=0; i<proveedores.size(); i++){
                    out.print("<option value="+ proveedores.get(i).getId() +">"+ proveedores.get(i).getNombre() +"</option>");
                    }
                out.print("</select> ");
                out.print("<p><label for='marca'>Marca</label></p>");
                out.print("<p><input type='text' id='marca' name='marca' required></p>");
                out.print("<p><label for='comentario'>Comentario</label></p>");
                out.print("<p><input type='text' id='comentario' name='comentario' required></p>");
                out.print("<p><label for='Precio'>Precio</label></p>");
                out.print("<p><input type='number' id='Precio' name='Precio' required></p>");
                out.print("<p><label for='cantidad'>Cantidad</label></p>");
                out.print("<p><input type='number' id='cantidad' name='cantidad' required></p>");
                out.print("<p><label for='valoracion'>Valoracion</label></p>");
                out.print("<select name='valoracion'>");
                out.print("<option selected>Seleccione...</option>");
                out.print("<option value='1'>1</option>");
                out.print("<option value='2' >2</option>");
                out.print("<option value='3'>3</option>");
                out.print("<option value='4' >4</option>");
                out.print("<option value='5'>5</option>");
                out.print(" </select>");
                out.println("    <br>");
                out.println("<label for=\"imagen\">URL de imagen</label>");
                out.println("<input type=\"text\" name=\"imagen\" id=\"imagen\">");
                out.println("    <br>");
                out.print("<input type='submit' value='Crear Producto'>"); 
                out.print("</form>");
            }else{
                out.print("<h1>Modificar producto</h1>");
              
                out.print("<form class='formulario' name='crearProducto' onsubmit='event.preventDefault(); editar();'>");
                out.print("<p><label for='comp'>Componente</label></p>");
                out.print("<select name='comp'>");
                
                List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                    for(int i=0; i<componentes.size(); i++){
                        if(pro.getComponente().getId()==componentes.get(i).getId()){
                    out.print("<option value="+ componentes.get(i).getId() +" selected>"+ componentes.get(i).getNombre() +"</option>");
                        }else{
                             out.print("<option value="+ componentes.get(i).getId() +">"+ componentes.get(i).getNombre() +"</option>");
                        }
                    }
                out.print("</select>");
                
                
                
                out.print("<p><label for='prov'>Proveedor</label></p>");
                out.print("<select name='prov'>");
                out.print("<option selected>Seleccione...</option>");
                 List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
                    for(int i=0; i<proveedores.size(); i++){
                        if(pro.getProveedor().getId()==proveedores.get(i).getId()){
                            out.print("<option value="+ proveedores.get(i).getId() +" selected>"+ proveedores.get(i).getNombre() +"</option>");
                        }else{
                            out.print("<option value="+ proveedores.get(i).getId() +">"+ proveedores.get(i).getNombre() +"</option>");
                        }
                    }
                out.print("</select> ");
                out.print("<p><label for='marca'>Marca</label></p>");
                out.print("<p><input type='text' id='marca'  value='"+pro.getMarca()+"' name='marca' required></p>");
                out.print("<p><label for='comentario'>Comentario</label></p>");
                out.print("<p><input type='text' id='comentario'value='"+pro.getComentarios()+"' name='comentario' required></p>");
                out.print("<p><label for='Precio'>Precio</label></p>");
                out.print("<p><input type='number' id='Precio' value='"+pro.getPrecio()+"' name='Precio' required></p>");
                out.print("<p><label for='cantidad'>Cantidad</label></p>");
                out.print("<p><input type='number' id='cantidad' value='"+pro.getCantidad()+"' name='cantidad' required></p>");
                out.print("<p><label for='valoracion'>Valoracion</label></p>");
                out.print("<select name='valoracion'>");
                for(int i=1; i<6 ; i++){
                    if(i==pro.getValoracion())
                    {
                        out.print("<option value='"+i+"' selected>"+i+"</option>");
                    }else{
                         out.print("<option value='"+i+"'>"+i+"</option>");
                    }
                }
                out.print(" </select>");
                out.println("    <br>");
                out.println("<label for=\"imagen\">URL de imagen</label>");
                if(pro.getImagen2() != null) {
                    out.println("<input value='"+pro.getImagen2()+"' type=\"text\" name=\"imagen\" id=\"imagen\">");
                } else {
                    out.println("<input type=\"text\" name=\"imagen\" id=\"imagen\">");
                }
                out.println("    <br>");
                out.println("<input id='id' type='hidden' value='"+pro.getId()+"'>");
                out.print("<input type='submit' value='Modificar Producto'>"); 
                
                out.print("</form>");
                
                session.removeAttribute("producto");
            }
            
            
            
            
        
 %>
    </body>
</html>
