<%-- 
    Document   : inputCrearReceta
    Created on : Oct 21, 2022, 8:04:25 PM
    Author     : Manuel
--%>

<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%
    String nombre = request.getParameter("nombre");
    
    Receta receta = new Receta(nombre);
    PersistenciaMateriales.getInstance().persist(receta);

%>
