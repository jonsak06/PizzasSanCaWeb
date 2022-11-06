<%-- 
    Document   : eliminarEntidad
    Created on : 05/11/2022, 04:18:23 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Proveedor"%>
<%@page import="Entidades.Producto"%>
<%@page import="Entidades.Componente"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Tanda"%>
<%@page import="Entidades.Pedido"%>
<%@page import="Entidades.Paquete"%>
<%@page import="Entidades.Comprador"%>
<%@page import="Entidades.Lugar"%>
<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%
    String ent = request.getParameter("eliminar");

    String[] split = ent.split("-");
    String tipo = split[0];
    long id = Long.parseLong(split[1]);

    if (tipo.equals("lugar")) {
        List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
        Lugar lugar = null;
        for (Lugar l : lugares) {
            if (l.getId() == id) {
                lugar = l;
                break;
            }
        }
        lugar.setActivo(false);
        PersistenciaMateriales.getInstance().merge(lugar);
    } 
    else if(tipo.equals("comprador")) {
        List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
        Comprador comp = null;
        for (Comprador c : compradores) {
            if (c.getId() == id) {
                comp = c;
                break;
            }
        }
        comp.setActivo(false);
        PersistenciaMateriales.getInstance().merge(comp);
    }
    else if(tipo.equals("paquete")) {
        List<Paquete> paquetes = PersistenciaMateriales.getInstance().listaPaquetes();
        Paquete paq = null;
        for (Paquete p : paquetes) {
            if (p.getId() == id) {
                paq = p;
                break;
            }
        }
        paq.setActivo(false);
        PersistenciaMateriales.getInstance().merge(paq);
    }
    else if(tipo.equals("pedido")) {
        List<Pedido> pedidos = PersistenciaMateriales.getInstance().listaPedidos();
        Pedido ped = null;
        for (Pedido p : pedidos) {
            if (p.getId() == id) {
                ped = p;
                break;
            }
        }
        ped.setActivo(false);
        PersistenciaMateriales.getInstance().merge(ped);
    }
    else if(tipo.equals("tanda")) {
        List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
        Tanda tanda = null;
        for (Tanda t : tandas) {
            if (t.getId() == id) {
                tanda = t;
                break;
            }
        }
        tanda.setActivo(false);
        PersistenciaMateriales.getInstance().merge(tanda);
    }
    else if(tipo.equals("receta")) {
        List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
        Receta receta = null;
        for (Receta r : recetas) {
            if (r.getId() == id) {
                receta = r;
                break;
            }
        }
        receta.setActivo(false);
        PersistenciaMateriales.getInstance().merge(receta);
    }
    else if(tipo.equals("componente")) {
        List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
        Componente comp = null;
        for (Componente c : componentes) {
            if (c.getId() == id) {
                comp = c;
                break;
            }
        }
        comp.setActivo(false);
        PersistenciaMateriales.getInstance().merge(comp);
    }
    else if(tipo.equals("producto")) {
        List<Producto> productos = PersistenciaMateriales.getInstance().listaProductos();
        Producto prod = null;
        for (Producto p : productos) {
            if (p.getId() == id) {
                prod = p;
                break;
            }
        }
        prod.setActivo(false);
        PersistenciaMateriales.getInstance().merge(prod);
    }
    else if(tipo.equals("proveedor")) {
        List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
        Proveedor prov = null;
        for (Proveedor p : proveedores) {
            if (p.getId() == id) {
                prov = p;
                break;
            }
        }
        prov.setActivo(false);
        PersistenciaMateriales.getInstance().merge(prov);
    }
%>
