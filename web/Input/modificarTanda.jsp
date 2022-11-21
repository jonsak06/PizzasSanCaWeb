<%-- 
    Document   : modificarTanda
    Created on : 20/11/2022, 06:42:44 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Receta"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    long idTanda = Long.parseLong(request.getParameter("id"));
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
    
    List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
    Tanda tanda = null;
    for(Tanda c : tandas) {
        if(c.getId() == idTanda) {
            tanda = c;
            break;
        }
    }
    
    tanda.setFechaElaboracion(fecha);
    tanda.setValoracion(valoracion);
    tanda.setPrecioUnitario(precioUnitario);
    tanda.setCantidadUnidades(cantUnidades);
    tanda.setCantidadConsumida(cantConsumida);
    tanda.setReceta(receta);
    
    PersistenciaMateriales.getInstance().merge(tanda);
    
%>
