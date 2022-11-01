<%-- 
    Document   : inputAnidirComponenteAReceta
    Created on : Oct 24, 2022, 5:43:25 PM
    Author     : Manuel
--%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Componente"%>
<%@page import="Entidades.Cantidad"%>

<%
    String rec = request.getParameter("rec");
    String comp = request.getParameter("comp");
    String cant = request.getParameter("cant");
   
    Componente componente = null;
    List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
    for(int i=0; i<componentes.size(); i++){
        if(componentes.get(i).getId()== Long.parseLong(comp) ){
            componente=componentes.get(i);
        }
    }
    Receta Receta = null;
    List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
    for(int i=0; i<recetas.size(); i++){
        if(recetas.get(i).getId()== Long.parseLong(rec) ){
            Receta=recetas.get(i);
        }
    }
    
    Cantidad cantidad = new Cantidad(Float.parseFloat(cant));
    cantidad.setComponente(componente);
    cantidad.setReceta(Receta);
    PersistenciaMateriales.getInstance().persist(cantidad);

%>