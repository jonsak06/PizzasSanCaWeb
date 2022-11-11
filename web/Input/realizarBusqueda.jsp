<%-- 
    Document   : realizarBusqueda
    Created on : 10/11/2022, 08:51:08 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Entidades.Comprador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entidades.Lugar"%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date fecha = null;
    if(!request.getParameter("fecha").equals("")){
        fecha = format.parse(request.getParameter("fecha"));
    }
    
    
    String busqueda = request.getParameter("busqueda").toLowerCase();
    String entidad = request.getParameter("entidad");
    
    if(entidad.equals("lugar") && !busqueda.equals("")) {
        List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
        List<Lugar> resultado = new ArrayList();
        for(Lugar l :lugares) {
            if(l.getNombre().toLowerCase().contains(busqueda) || l.getDireccion().toLowerCase().contains(busqueda)) {
                resultado.add(l);
            }
        }
        session.setAttribute("listaLugares", resultado);
    } else if(entidad.equals("comprador") && !busqueda.equals("")){
        List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
        List<Comprador> resultado = new ArrayList();
        for(Comprador c :compradores) {
            if(c.getNombre().toLowerCase().contains(busqueda) || c.getTelefono().contains(busqueda)) {
                resultado.add(c);
            }
        }
        session.setAttribute("listaCompradores", resultado);
    } else if(entidad.equals("tanda")) {
        List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
        List<Tanda> resultado = new ArrayList();
        for(Tanda t :tandas) {
            if(fecha != null) {
                if(t.getFechaElaboracion().compareTo(fecha) == 0 && busqueda.equals("")) {
                    resultado.add(t);
                } else if((t.getFechaElaboracion().compareTo(fecha) == 0 && !busqueda.equals(""))) {
                    if(String.valueOf(t.getCantidadConsumida()).contains(busqueda) || String.valueOf(t.getCantidadUnidades()).contains(busqueda)
                        || String.valueOf(t.getPrecioUnitario()).contains(busqueda) || String.valueOf(t.getValoracion()).contains(busqueda)) 
                    {
                        resultado.add(t);
                    }
                }
            } else {
                if(!busqueda.equals("")) {
                    if(String.valueOf(t.getCantidadConsumida()).contains(busqueda) || String.valueOf(t.getCantidadUnidades()).contains(busqueda)
                        || String.valueOf(t.getPrecioUnitario()).contains(busqueda) || String.valueOf(t.getValoracion()).contains(busqueda)) 
                    {
                        resultado.add(t);
                    }
                }
            }
            
            
        }
        session.setAttribute("listaTandas", resultado);
    }

%>
