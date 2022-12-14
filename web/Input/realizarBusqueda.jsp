<%-- 
    Document   : realizarBusqueda
    Created on : 10/11/2022, 08:51:08 PM
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
    
    if(entidad.equals("lugar")) {
        List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
        List<Lugar> resultado = new ArrayList();
        if(busqueda.equals("")) {
            resultado = lugares;
        } else {
           for(Lugar l :lugares) {
                if(l.getNombre().toLowerCase().contains(busqueda) || l.getDireccion().toLowerCase().contains(busqueda)) {
                    resultado.add(l);
                }
            } 
        }
        
        session.setAttribute("listaLugares", resultado);
    } else if(entidad.equals("comprador")){
        List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
        List<Comprador> resultado = new ArrayList();
        if(busqueda.equals("")) {
            resultado = compradores;
        } else {
            for(Comprador c :compradores) {
                if(c.getNombre().toLowerCase().contains(busqueda) || c.getTelefono().contains(busqueda)) {
                    resultado.add(c);
                }
            }
        }
        
        session.setAttribute("listaCompradores", resultado);
    } else if(entidad.equals("tanda")) {
        List<Tanda> tandas = PersistenciaMateriales.getInstance().listaTandas();
        List<Tanda> resultado = new ArrayList();
        
        if(fecha == null && busqueda.equals("")){
            resultado = tandas;
        } else {
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
        } 
        
        
        session.setAttribute("listaTandas", resultado);
    } else if(entidad.equals("pedido")) {
        List<Pedido> pedidos = PersistenciaMateriales.getInstance().listaPedidos();
        List<Pedido> resultado = new ArrayList();
        
        if(fecha == null && busqueda.equals("")){
            resultado = pedidos;
        } else {
            for(Pedido p :pedidos) {
            
                if(fecha != null) {
                    if(p.getFecha().compareTo(fecha) == 0 && busqueda.equals("")) {
                        resultado.add(p);
                    } else if((p.getFecha().compareTo(fecha) == 0 && !busqueda.equals(""))) {
                        if(String.valueOf(p.getDescuento()).contains(busqueda) || String.valueOf(p.getUnidades()).contains(busqueda)) 
                        {
                            resultado.add(p);
                        }
                    }
                } else {
                    if(!busqueda.equals("")) {
                        if(String.valueOf(p.getDescuento()).contains(busqueda) || String.valueOf(p.getUnidades()).contains(busqueda)) 
                        {
                            resultado.add(p);
                        }
                    } 
                }
            }
        }
        session.setAttribute("listaPedidos", resultado);
    } else if(entidad.equals("paquete")) {
        List<Paquete> paquetes = PersistenciaMateriales.getInstance().listaPaquetes();
        List<Paquete> resultado = new ArrayList();
        
        if(fecha == null && busqueda.equals("")){
            resultado = paquetes;
        } else {
            for(Paquete p :paquetes) {
            
                if(fecha != null) {
                    if(p.getFecha().compareTo(fecha) == 0 && busqueda.equals("")) {
                        resultado.add(p);
                    } else if((p.getFecha().compareTo(fecha) == 0 && !busqueda.equals(""))) {
                        if(String.valueOf(p.getUnidadesVendidas()).contains(busqueda) || String.valueOf(p.getUnidadesLlevadas()).contains(busqueda)) 
                        {
                            resultado.add(p);
                        }
                    }
                } else {
                    if(!busqueda.equals("")) {
                        if(String.valueOf(p.getUnidadesVendidas()).contains(busqueda) || String.valueOf(p.getUnidadesLlevadas()).contains(busqueda)) 
                        {
                            resultado.add(p);
                        }
                    } 
                }
            }
        }
        session.setAttribute("listaPaquetes", resultado);
    } else if(entidad.equals("proveedor")) {
        List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
        List<Proveedor> resultado = new ArrayList();
        
        if(busqueda.equals("")) {
            resultado = proveedores;
        } else {
            for(Proveedor p :proveedores) {
                if(p.getNombre().toLowerCase().contains(busqueda) || p.getTelefono().contains(busqueda) || p.getDireccion().toLowerCase().contains(busqueda)) {
                    resultado.add(p);
                }
            }
        }
        session.setAttribute("listaProveedores", resultado);
    } else if(entidad.equals("producto")) {
        List<Producto> productos = PersistenciaMateriales.getInstance().listaProductos();
        List<Producto> resultado = new ArrayList();
        
        if(busqueda.equals("")) {
            resultado = productos;
        } else {
            for(Producto p :productos) {
                if(p.getMarca().toLowerCase().contains(busqueda) || p.getComentarios().toLowerCase().contains(busqueda) || String.valueOf(p.getPrecio()).contains(busqueda)
                        || String.valueOf(p.getValoracion()).contains(busqueda)) {
                    resultado.add(p);
                }
            }
        }
        session.setAttribute("listaProductos", resultado);
    } else if(entidad.equals("receta")) {
        List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
        List<Receta> resultado = new ArrayList();
        
        if(busqueda.equals("")) {
            resultado = recetas;
        } else {
            for(Receta p :recetas) {
                if(p.getNombre().toLowerCase().contains(busqueda)) {
                    resultado.add(p);
                }
            }
        }
        session.setAttribute("listaRecetas", resultado);
    } else if(entidad.equals("componente")) {
        List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
        List<Componente> resultado = new ArrayList();
        
        if(busqueda.equals("")) {
            resultado = componentes;
        } else {
            for(Componente c :componentes) {
                if(c.getNombre().toLowerCase().contains(busqueda) || c.getUnidadDeMedida().toLowerCase().contains(busqueda) 
                        || String.valueOf(c.getCantidadDeAlerta()).contains(busqueda)) {
                    resultado.add(c);
                }
            }
        }
        session.setAttribute("listaComponentes", resultado);
    }

%>
