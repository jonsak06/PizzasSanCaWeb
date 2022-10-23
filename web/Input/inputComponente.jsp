<%-- 
    Document   : inputComponente
    Created on : Oct 17, 2022, 11:11:45 AM
    Author     : Manuel
--%>


<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Componente"%>
<%
    String nombre = (String)request.getParameter("nombre");
    String unidadDeMedida = (String)request.getParameter("unidadDeMedida");
    String cantalert = (String)request.getParameter("cantalert");
    
    Componente componente = new Componente(nombre, unidadDeMedida, Integer.parseInt(cantalert));
    PersistenciaMateriales.getInstance().persist(componente);

%>
