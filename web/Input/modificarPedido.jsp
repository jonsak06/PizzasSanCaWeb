<%-- 
    Document   : modificarPedido
    Created on : 20/11/2022, 10:18:11 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Tanda"%>
<%@page import="Entidades.Comprador"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entidades.Pedido"%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%
    long idPedido = Long.parseLong(request.getParameter("id"));
    
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date fecha = format.parse(request.getParameter("fecha"));
    
    int unidades = Integer.parseInt(request.getParameter("unidades"));
    int descuento = Integer.parseInt(request.getParameter("descuento"));
    
    List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
    List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
    
    long idComprador = Long.parseLong(request.getParameter("comprador"));
    long idTanda = Long.parseLong(request.getParameter("tanda"));
    
    Comprador comprador = null;
    for(Comprador c : compradores) {
        if(c.getId() == idComprador) {
            comprador = c;
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
    
    List<Pedido> pedidos = PersistenciaMateriales.getInstance().listaPedidos();
    Pedido pedido = null;
    for(Pedido p : pedidos) {
        if(p.getId() == idPedido) {
            pedido = p;
            break;
        }
    }
    
    pedido.setFecha(fecha);
    pedido.setUnidades(unidades);
    pedido.setDescuento(descuento);
    pedido.setComprador(comprador);
    pedido.setTanda(tanda);
    
    PersistenciaMateriales.getInstance().merge(pedido);
%>

