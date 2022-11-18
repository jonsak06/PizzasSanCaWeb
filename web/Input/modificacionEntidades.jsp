<%-- 
    Document   : modificacionEntidades
    Created on : 17/11/2022, 08:37:28 PM
    Author     : Usuario
--%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Lugar"%>
<%
    long id = Long.parseLong(request.getParameter("id"));
    
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
%>
<!--<c:redirect url="http://localhost:8080/PizzasSanCaWeb/Lugar.jsp"/>-->