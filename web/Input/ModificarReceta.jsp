<%-- 
    Document   : ModificarReceta
    Created on : Nov 22, 2022, 9:09:17 PM
    Author     : Manuel
--%>

<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Receta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String nombre = (String)request.getParameter("nombre");
    String direccion = (String)request.getParameter("direccion");
    String telefono = (String)request.getParameter("telefono");
    String id = (String)request.getParameter("id");
    Receta rec = null;
    List<Receta> proveedores = PersistenciaMateriales.getInstance().listaRecetas();
    for(int i=0; i<proveedores.size(); i++){
        if(Long.parseLong(id)==proveedores.get(i).getId()){
            rec=proveedores.get(i);
        }
    }
    rec.setNombre(nombre);
    PersistenciaMateriales.getInstance().merge(rec);

%>