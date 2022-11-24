<%-- 
    Document   : inputTanda
    Created on : 24/10/2022, 10:24:22 PM
    Author     : Usuario
--%>

<%@page import="Entidades.Consume"%>
<%@page import="Entidades.Cantidad"%>
<%@page import="Entidades.Tanda"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    Boolean haySuficiente = true;

    long idReceta = Long.parseLong(request.getParameter("receta"));
    Receta rec = null;
    List<Receta> proveedores = PersistenciaMateriales.getInstance().listaRecetas();
    for (int i = 0; i < proveedores.size(); i++) {
        if (idReceta == proveedores.get(i).getId()) {
            rec = proveedores.get(i);
        }
    }
    List<Cantidad> cantidades = PersistenciaMateriales.getInstance().listaCantidades(idReceta);
    for (int i = 0; i < cantidades.size(); i++) {
        float cantidad = 0;

        for (int u = 0; u < cantidades.get(i).getComponente().getProductos().size(); u++) {
            cantidad = cantidad + cantidades.get(i).getComponente().getProductos().get(u).getCantidad();
        }

        if (cantidad < cantidades.get(i).getPorReceta()) {
            haySuficiente = false;
        }
    }
    if (haySuficiente == true) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = format.parse(request.getParameter("fecha"));

        int valoracion = Integer.parseInt(request.getParameter("valoracion"));
        int precioUnitario = Integer.parseInt(request.getParameter("precioUnitario"));
        int cantUnidades = Integer.parseInt(request.getParameter("cantUnidades"));
        int cantConsumida = Integer.parseInt(request.getParameter("cantConsumida"));
        String imagen = request.getParameter("imagen");

        List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();

        Receta receta = null;
        for (Receta r : recetas) {
            if (r.getId() == idReceta) {
                receta = r;
                break;
            }
        }

        Tanda tanda = new Tanda(fecha, valoracion, precioUnitario, cantUnidades, cantConsumida, imagen, receta);
        PersistenciaMateriales.getInstance().persist(tanda);

        for (int i = 0; i < cantidades.size(); i++) {
            float cantidad = cantidades.get(i).getPorReceta();

            for (int u = 0; u < cantidades.get(i).getComponente().getProductos().size(); u++) {

                if (cantidades.get(i).getComponente().getProductos().get(u).getCantidad() >= cantidades.get(i).getPorReceta()) {
                    float aux = cantidades.get(i).getComponente().getProductos().get(u).getCantidad();
                    aux = aux - cantidades.get(i).getPorReceta();
                    cantidades.get(i).getComponente().getProductos().get(u).setCantidad(aux);
                    Consume consume = new Consume();
                    consume.setCantidad((int) cantidad);
                    consume.setTanda(tanda);
                    consume.setProducto(cantidades.get(i).getComponente().getProductos().get(u));
                    PersistenciaMateriales.getInstance().merge(cantidades.get(i).getComponente().getProductos().get(u));
                    PersistenciaMateriales.getInstance().persist(consume);
                } else {

                    float aux = cantidad - cantidades.get(i).getComponente().getProductos().get(u).getCantidad();
                    Consume consume = new Consume();
                    consume.setCantidad((int) cantidades.get(i).getComponente().getProductos().get(u).getCantidad());
                    consume.setTanda(tanda);
                    cantidades.get(i).getComponente().getProductos().get(u).setCantidad(0);
                    consume.setProducto(cantidades.get(i).getComponente().getProductos().get(u));
                    PersistenciaMateriales.getInstance().merge(cantidades.get(i).getComponente().getProductos().get(u));
                    PersistenciaMateriales.getInstance().persist(consume);
                }
            }
        }

        out.println("creado");

    } else {
        out.println("noCreado");
    }
%>
