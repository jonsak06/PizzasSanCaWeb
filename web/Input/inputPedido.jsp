<%@page import="Entidades.Pedido"%>
<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Comprador"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
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
    
    Pedido pedido = new Pedido(descuento, fecha, unidades, comprador, tanda);
    PersistenciaMateriales.getInstance().persist(pedido);

%>
