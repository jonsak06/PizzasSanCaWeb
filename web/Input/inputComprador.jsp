<%-- 
    Document   : inputComprador
    Created on : 19/10/2022, 06:19:50 AM
    Author     : Usuario
--%>

<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Comprador"%>
<%
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("telefono");
    
    Comprador comprador = new Comprador(nombre, direccion);
    PersistenciaMateriales.getInstance().persist(comprador);

%>
