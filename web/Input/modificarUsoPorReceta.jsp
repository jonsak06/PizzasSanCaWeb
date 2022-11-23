<%-- 
    Document   : modificarUsoPorReceta
    Created on : Nov 23, 2022, 3:12:33 PM
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
    String valor = (String)request.getParameter("valor");
    
   
    List<Cantidad> cant = PersistenciaMateriales.getInstance().listaCantidades(Long.parseLong(idReceta));
    for(int i=0; i<cant.size(); i++){
        if(Long.parseLong(idUso)==cant.get(i).getId()){
            cant.get(i).setPorReceta(Float.parseFloat(valor));
            PersistenciaMateriales.getInstance().merge(cant.get(i));
        }
    }
    
%>

