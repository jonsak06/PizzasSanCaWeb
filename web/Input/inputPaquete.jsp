<%-- 
    Document   : inputPaquete
    Created on : 18/10/2022, 06:45:14 PM
    Author     : Usuario
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entidades.Tanda"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Paquete"%>
<%@page import="java.util.Date"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Lugar"%>
<%
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date fecha = format.parse(request.getParameter("fecha"));
    
    int llevadas = Integer.parseInt(request.getParameter("llevadas"));
    int vendidas = Integer.parseInt(request.getParameter("vendidas"));
    
    List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
    List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
    
    String nombreLugar = (String) request.getParameter("lugar");
    long idTanda = Integer.parseInt(request.getParameter("tanda"));
    
    Lugar lugar = null;
    for(Lugar l : lugares) {
        if(l.getNombre().equals(nombreLugar)) {
            lugar = l;
            break;
        }
    }
    //Lugar lugar = lugares.stream().filter(l -> nombreLugar.equals(l.getNombre())).findFirst().orElse(null);
    
    Tanda tanda = null;
    for(Tanda t : tandas) {
        if(t.getId()== idTanda) {
            tanda = t;
            break;
        }
    }
    //Tanda tanda = tandas.stream().filter(t -> idTanda.equals(t.getId())).findFirst().orElse(null);

    
    Paquete paquete = new Paquete(fecha, llevadas, vendidas, lugar, tanda);
    PersistenciaMateriales.getInstance().persist(paquete);

%>
