<%-- 
    Document   : modificacionEntidades
    Created on : 17/11/2022, 08:37:28 PM
    Author     : Usuario
--%>
<%@page import="Entidades.Componente"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Producto"%>
<%@page import="Entidades.Proveedor"%>
<%@page import="Entidades.Paquete"%>
<%@page import="Entidades.Pedido"%>
<%@page import="Entidades.Tanda"%>
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
        
    } else if(tipo.equals("tanda")) {
        List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
    
        Tanda tanda = null;
        for(Tanda t : tandas) {
            if(t.getId() == id) {
                tanda = t;
                break;
            }
        }
        session.setAttribute("tanda", tanda);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/Tanda.jsp");
    } else if(tipo.equals("pedido")) {
        List<Pedido> pedidos = PersistenciaMateriales.getInstance().listaPedidos();
    
        Pedido pedido = null;
        for(Pedido p : pedidos) {
            if(p.getId() == id) {
                pedido = p;
                break;
            }
        }
        session.setAttribute("pedido", pedido);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/Pedido.jsp");
    } else if(tipo.equals("paquete")) {
        List<Paquete> paquetes = PersistenciaMateriales.getInstance().listaPaquetes();
    
        Paquete paquete = null;
        for(Paquete p : paquetes) {
            if(p.getId() == id) {
                paquete = p;
                break;
            }
        }
        session.setAttribute("paquete", paquete);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/Paquete.jsp");
    } else if(tipo.equals("proveedor")) {
        List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
    
        Proveedor proveedor = null;
        for(Proveedor p : proveedores) {
            if(p.getId() == id) {
                proveedor = p;
                break;
            }
        }
        session.setAttribute("proveedor", proveedor);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/crearProveedor.jsp");
    } else if(tipo.equals("producto")) {
        List<Producto> productos = PersistenciaMateriales.getInstance().listaProductos();
    
        Producto producto = null;
        for(Producto p : productos) {
            if(p.getId() == id) {
                producto = p;
                break;
            }
        }
        session.setAttribute("producto", producto);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/crearProducto.jsp");
    } else if(tipo.equals("receta")) {
        List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
    
        Receta receta = null;
        for(Receta r : recetas) {
            if(r.getId() == id) {
                receta = r;
                break;
            }
        }
        session.setAttribute("receta", receta);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/crearReceta.jsp");
    } else if(tipo.equals("componente")) {
        List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
    
        Componente componente = null;
        for(Componente c : componentes) {
            if(c.getId() == id) {
                componente = c;
                break;
            }
        }
        session.setAttribute("componente", componente);
        response.sendRedirect("http://localhost:8080/PizzasSanCaWeb/crearComponente.jsp");
    }
    
    
%>