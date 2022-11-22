<%-- 
    Document   : ModificarProducto
    Created on : Nov 20, 2022, 9:09:14 AM
    Author     : Manuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Componente"%>
<%@page import="Entidades.Producto"%>
<%@page import="Entidades.Proveedor"%>
<%
    String cantidad = (String)request.getParameter("cantidad");
    String comp = (String)request.getParameter("comp");
    String prov = (String)request.getParameter("prov");
    String marca = (String)request.getParameter("marca");
    String Precio = (String)request.getParameter("Precio");
    String imagen = (String)request.getParameter("imagen");   
    String comentario = (String)request.getParameter("comentario");
    String valoracion = (String)request.getParameter("valoracion");  
    String id = (String)request.getParameter("id"); 
//    byte[] aux = new byte[1];
    
    Producto pro = null; 
     List<Producto> productos = PersistenciaMateriales.getInstance().listaProductos();
     for(int i=0; i<productos.size(); i++){
        if(productos.get(i).getId()==Long.parseLong(id))
        {
            pro=productos.get(i);
        }
    }
    
    
    Componente componente = null;
    List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
    for(int i=0; i<componentes.size(); i++){
        if(componentes.get(i).getId()== Long.parseLong(comp) ){
            componente=componentes.get(i);
        }
    }
    Proveedor proveedor = null;
    List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
    for(int i=0; i<proveedores.size(); i++){
        if(proveedores.get(i).getId()== Long.parseLong(prov) ){
            proveedor=proveedores.get(i);
        }
    }
    
     pro.setImagen2(imagen);
     pro.setMarca(marca);
     pro.setPrecio(Integer.parseInt(Precio));
     pro.setCantidad(Float.parseFloat(cantidad));
     pro.setComentarios(comentario);
     pro.setComponente(componente);
     pro.setProveedor(proveedor);
     pro.setValoracion(Integer.parseInt(valoracion));
   PersistenciaMateriales.getInstance().merge(pro);
    

%>
