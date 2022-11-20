<%-- 
    Document   : modificarComprador
    Created on : 20/11/2022, 05:57:17 PM
    Author     : Usuario
--%>

<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Comprador"%>
<%
    long idComprador = Long.parseLong(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String telefono = request.getParameter("telefono");
    
    List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
    Comprador comprador = null;
    for(Comprador c : compradores) {
        if(c.getId() == idComprador) {
            comprador = c;
            break;
        }
    }
    
    comprador.setNombre(nombre);
    comprador.setTelefono(telefono);
    
    PersistenciaMateriales.getInstance().merge(comprador);
%>
