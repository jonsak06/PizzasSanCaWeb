<%-- 
    Document   : realizarBusqueda
    Created on : 10/11/2022, 08:51:08 PM
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Entidades.Lugar"%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    if(request.getParameter("fecha") != null && !request.getParameter("fecha").equals("")){
        Date fecha = format.parse(request.getParameter("fecha"));
    }
    
    
    String busqueda = request.getParameter("busqueda").toLowerCase();
    String entidad = request.getParameter("entidad");
    
    if(entidad.equals("lugar") && busqueda != null) {
        List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
        List<Lugar> resultado = new ArrayList();
        for(Lugar l :lugares) {
            if(l.getNombre().toLowerCase().contains(busqueda) || l.getDireccion().toLowerCase().contains(busqueda)) {
                resultado.add(l);
            }
        }
        System.out.println("seteado");
        session.setAttribute("listaLugares", resultado);
    }

%>
<%--<jsp:forward page="../Busqueda.jsp"/>--%>
