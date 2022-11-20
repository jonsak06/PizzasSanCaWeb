<%-- 
    Document   : modificacionEntidades
    Created on : 17/11/2022, 08:37:28 PM
    Author     : Usuario
--%>
<%@page import="Entidades.Comprador"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Lugar"%>
<%
    String ent = request.getParameter("entidad");
    
    String[] split = ent.split("-");
    String tipo = split[0];
    long id = Long.parseLong(split[1]);
    
    if(tipo.equals("lugar")) {
        List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
    
        Lugar lugar = null;
        for(Lugar l : lugares) {
            if(l.getId() == id) {
                lugar = l;
                break;
            }
        }
        session.setAttribute("lugar", lugar);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/Lugar.jsp");
    } else if(tipo.equals("comprador")) {
        List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
    
        Comprador comprador = null;
        for(Comprador c : compradores) {
            if(c.getId() == id) {
                comprador = c;
                break;
            }
        }
        session.setAttribute("comprador", comprador);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/Comprador.jsp");
    }
    
    
%>