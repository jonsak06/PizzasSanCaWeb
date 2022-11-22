<%-- 
    Document   : index
    Created on : Nov 21, 2022, 2:09:55 PM
    Author     : Manuel
--%>
<%@page import="Entidades.Comprador"%>
<%@page import="Entidades.Lugar"%>
<%@page import="Entidades.Producto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="Entidades.Proveedor"%>
<%@page import="Entidades.Componente"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" media="" href="css/estilosCelular.css">
    </head>
    <jsp:include page="Input/barraNavegacion.jsp" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <body>
        <%
            
            out.println("<div class='index'><h2>Componentes que quedan poco</h2>");
            List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
            for(int i=0; i<componentes.size(); i++){
                
                float cantidad = 0;
                
                for(int u=0; u<componentes.get(i).getProductos().size(); u++){
                    cantidad = cantidad + componentes.get(i).getProductos().get(u).getCantidad();
                }
                
                if(cantidad < componentes.get(i).getCantidadDeAlerta())
                {
                    out.println("<p>- Hay "+cantidad+" de "+componentes.get(i).getNombre()+" y la cantidad recomendada es "+componentes.get(i).getCantidadDeAlerta()+"</p>");
                    out.println("<hr class='division'/>");
                }
            }
            out.println("<br/>");
            
            List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
           out.println("<h2>Los lugares que mas compraron</h2>");
            
            Lugar aux= null;
            for (int i = 0; i < lugares.size(); i++) {
                out.println("<p>1</p>");
                for (int j = 0; j < lugares.size() - i - 1; j++) {                                                              
                    int CantidadTotalDeLugares1 = 0;
                    for(int u=0; u<lugares.get(j).getPaquetes().size(); u++)
                    {
                        CantidadTotalDeLugares1 = CantidadTotalDeLugares1+ lugares.get(i).getPaquetes().get(u).getUnidadesVendidas();
                    }
                    int CantidadTotalDeLugares2 = 0;
                    for(int u=0; u<lugares.get( j+1 ).getPaquetes().size(); u++)
                    {
                        CantidadTotalDeLugares2 = CantidadTotalDeLugares2+ lugares.get(i).getPaquetes().get(u).getUnidadesVendidas();
                    }
                    if (CantidadTotalDeLugares2 < CantidadTotalDeLugares1) {
                        aux = lugares.get( j+1 );
                        lugares.set(j+1, lugares.get( j ));
                        lugares.set(j, aux);
                    }
                }
            }
            
            Boolean paso1vesporCantotal = false;
            for (int i = 0; i < lugares.size() && i<3; i++) {
                int CantidadTotalDeLugares1 = 0;
                for(int u=0; u<lugares.get(i).getPaquetes().size(); u++)
                {
                    CantidadTotalDeLugares1 = CantidadTotalDeLugares1+ lugares.get(i).getPaquetes().get(u).getUnidadesVendidas();
                }
                out.println("<p>- "+ (i+1) +" "+lugares.get(i).getNombre()+" con: "+CantidadTotalDeLugares1+"</p>");
                paso1vesporCantotal = true;
            }
            if(paso1vesporCantotal == false){
                out.println("<p>No hay Lugares</p>");
            }
            
            
            out.println("<br/>");
            List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
           out.println("<h2>Los compradores que mas compraron</h2>");
            
            Comprador compradorAux= null;
            for (int i = 0; i < compradores.size(); i++) {
                out.println("<p>1</p>");
                for (int j = 0; j < compradores.size() - i - 1; j++) {                                                              
                    int unidades1 = 0;
                    for(int u=0; u<compradores.get(j).getPedidos().size(); u++)
                    {
                        unidades1 = unidades1+ compradores.get(i).getPedidos().get(u).getUnidades();
                    }
                    int unidades2 = 0;
                    for(int u=0; u<compradores.get( j+1 ).getPedidos().size(); u++)
                    {
                        unidades2 = unidades2+ compradores.get(i).getPedidos().get(u).getUnidades();
                    }
                    if (unidades2 < unidades1) {
                        compradorAux = compradores.get( j+1 );
                        compradores.set(j+1, compradores.get( j ));
                        compradores.set(j, compradorAux);
                    }
                }
            }
            
            Boolean paso1vesporUnidadesTotal = false;
            for (int i = 0; i < lugares.size() && i<3; i++) {
                int unidades = 0;
                for(int u=0; u<compradores.get(i).getPedidos().size(); u++)
                {
                    unidades = unidades+ compradores.get(i).getPedidos().get(u).getUnidades();
                }
                out.println("<p>- "+ (i+1) +" "+compradores.get(i).getNombre()+" con: "+unidades+"</p>");
                paso1vesporUnidadesTotal = true;
            }
            if(paso1vesporCantotal == false){
                out.println("<p>No hay Compradores</p>");
            }
            
            
            out.println("</div>");
            


        %>
    </body>
</html>
