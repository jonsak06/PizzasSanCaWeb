<%-- 
    Document   : inputTanda
    Created on : 24/10/2022, 10:24:22 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date fecha = format.parse(request.getParameter("fecha"));
    
    int valoracion = Integer.parseInt(request.getParameter("valoracion"));
    int precioUnitario = Integer.parseInt(request.getParameter("precioUnitario"));
    int cantUnidades = Integer.parseInt(request.getParameter("cantUnidades"));
    int cantConsumida = Integer.parseInt(request.getParameter("cantConsumida"));
//    imagen
    
    List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
    
    long idReceta = Long.parseLong(request.getParameter("receta"));
    
    Receta receta = null;
    for(Receta r : recetas) {
        if(r.getId() == idReceta) {
            receta = r;
            break;
        }
    }
    
    Tanda tanda = new Tanda(fecha, valoracion, precioUnitario, cantUnidades, cantConsumida, null, receta);
    PersistenciaMateriales.getInstance().persist(tanda);

%>
