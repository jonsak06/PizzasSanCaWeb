<%-- 
    Document   : modificarLugar
    Created on : 17/11/2022, 04:47:42 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Lugar"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%
    long idLugar = Long.parseLong(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");
    
    List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
    Lugar lugar = null;
    for(Lugar l : lugares) {
        if(l.getId() == idLugar) {
            lugar = l;
            break;
        }
    }
    
    lugar.setNombre(nombre);
    lugar.setDireccion(direccion);
    
    PersistenciaMateriales.getInstance().merge(lugar);
%>
