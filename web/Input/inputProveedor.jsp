<%-- 
    Document   : inputProveedor
    Created on : Oct 17, 2022, 5:24:54 PM
    Author     : Manuel
--%>


<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Proveedor"%>
<%
    String nombre = (String)request.getParameter("nombre");
    String direccion = (String)request.getParameter("direccion");
    String telefono = (String)request.getParameter("telefono");
    
    Proveedor proveedor = new Proveedor(telefono, direccion , nombre);
    PersistenciaMateriales.getInstance().persist(proveedor);

%>
