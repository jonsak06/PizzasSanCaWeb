<%-- 
    Document   : eliminarUsoPorReceta
    Created on : Nov 22, 2022, 11:43:03 AM
    Author     : Manuel
--%>
<%@page import="Entidades.Cantidad"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Componente"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idUso = (String)request.getParameter("idUso");
    String idReceta = (String)request.getParameter("idReceta");
    
   List<Cantidad> cant = PersistenciaMateriales.getInstance().listaCantidades(Long.parseLong(idReceta));
    for(int i=0; i<cant.size(); i++){
        if(Long.parseLong(idUso)==cant.get(i).getId()){
            PersistenciaMateriales.getInstance().delete(cant.get(i));
        }
    }
    
%>
