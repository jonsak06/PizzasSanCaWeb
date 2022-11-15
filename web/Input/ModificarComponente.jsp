<%-- 
    Document   : ModificarComponente
    Created on : Nov 15, 2022, 11:02:24 AM
    Author     : Manuel
--%>

<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Componente"%>
<%
    String nombre = (String)request.getParameter("nombre");
    String unidadDeMedida = (String)request.getParameter("unidadDeMedida");
    String cantalert = (String)request.getParameter("cantalert");
    String id = (String)request.getParameter("id");
    
    Componente comp = null;
              List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
                for(int i=0; i<componentes.size(); i++){
                    if(componentes.get(i).getId()== Long.parseLong(id) ){
                        comp=componentes.get(i);
                    }
                }
    
    comp.setCantidadDeAlerta(Integer.parseInt(cantalert));
    comp.setNombre(nombre);
    comp.setUnidadDeMedida(unidadDeMedida);
    
    PersistenciaMateriales.getInstance().merge(comp);
%>
