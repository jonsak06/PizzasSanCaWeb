<%-- 
    Document   : modificarPaquete
    Created on : 20/11/2022, 11:13:48 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Entidades.Lugar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entidades.Paquete"%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%
    long idPaquete = Long.parseLong(request.getParameter("id"));
    
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date fecha = format.parse(request.getParameter("fecha"));
    
    int llevadas = Integer.parseInt(request.getParameter("llevadas"));
    int vendidas = Integer.parseInt(request.getParameter("vendidas"));
    
    List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
    List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
    
    long idLugar = Long.parseLong(request.getParameter("lugar"));
    long idTanda = Long.parseLong(request.getParameter("tanda"));
    
    Lugar lugar = null;
    for(Lugar l : lugares) {
        if(l.getId() == idLugar) {
            lugar = l;
            break;
        }
    }
    
    Tanda tanda = null;
    for(Tanda t : tandas) {
        if(t.getId()== idTanda) {
            tanda = t;
            break;
        }
    }
    
    List<Paquete> paquetes = PersistenciaMateriales.getInstance().listaPaquetes();
    Paquete paquete = null;
    for(Paquete p : paquetes) {
        if(p.getId() == idPaquete) {
            paquete = p;
            break;
        }
    }
    
    paquete.setFecha(fecha);
    paquete.setUnidadesLlevadas(llevadas);
    paquete.setUnidadesVendidas(vendidas);
    paquete.setLugar(lugar);
    paquete.setTanda(tanda);
    
    PersistenciaMateriales.getInstance().merge(paquete);
%>
