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
    
    Receta receta = null;
     List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
     for(int i=0; i<recetas.size(); i++){
         if(Long.parseLong(idReceta)==recetas.get(i).getId()){
             receta=recetas.get(i);
         }
     }
     
    for(int i=0; i<receta.getCantidades().size(); i++){
        if(Long.parseLong(idUso)==receta.getCantidades().get(i).getId()){
            PersistenciaMateriales.getInstance().delete(receta.getCantidades().get(i));
        }
    }
    
%>
