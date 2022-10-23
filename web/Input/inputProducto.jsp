<%-- 
    Document   : inputProducto
    Created on : Oct 19, 2022, 11:14:33 AM
    Author     : Manuel
--%>
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
    String myfile = (String)request.getParameter("myfile");   
    String comentario = (String)request.getParameter("comentario");
    String valoracion = (String)request.getParameter("valoracion");  
    byte[] aux = new byte[1];
    
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
    
    Producto producto = new Producto(aux, marca, comentario, Integer.parseInt(Precio), Integer.parseInt(valoracion), Float.parseFloat(cantidad));
    producto.setComponente(componente);
    producto.setProveedor(proveedor);
    PersistenciaMateriales.getInstance().persist(producto);
    

%>
