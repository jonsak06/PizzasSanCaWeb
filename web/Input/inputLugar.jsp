<%-- 
    Document   : inputLugar
    Created on : 12/10/2022, 03:41:43 PM
    Author     : Usuario
--%>

<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Lugar"%>
<%
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");
    
    Lugar lugar = new Lugar(nombre, direccion);
    PersistenciaMateriales.getInstance().persist(lugar);

%>