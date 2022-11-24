<%-- 
    Document   : index
    Created on : Nov 21, 2022, 2:09:55 PM
    Author     : Manuel
--%>
<%@page import="Entidades.Pedido"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.SortedMap"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entidades.Paquete"%>
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
        <title>PizzasSanCa</title>
    </head>
    <jsp:include page="Input/barraNavegacion.jsp" />
    <style>
        body {
            text-align: center;
        }
        hr {
            width: 80%;
            text-align: center;
            margin: 20px auto;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <body>
        <%
            
            out.println("<div><h2>Componentes que quedan poco</h2>");
            out.println("<hr>");
            List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
            for(int i=0; i<componentes.size(); i++){
                
                float cantidad = 0;
                
                for(int u=0; u<componentes.get(i).getProductos().size(); u++){
                    cantidad = cantidad + componentes.get(i).getProductos().get(u).getCantidad();
                }
                
                if(cantidad < componentes.get(i).getCantidadDeAlerta())
                {
                    String unMedida = "";
                    if(componentes.get(i).getUnidadDeMedida().equals("cmÂ³")) {
                        unMedida = "cm³";
                    } else if(componentes.get(i).getUnidadDeMedida().equals("dmÂ³")) {
                        unMedida = "dm³";
                    } else {
                        unMedida = componentes.get(i).getUnidadDeMedida();
                    }
                    out.println("<p>- Hay "+cantidad+unMedida+" de "+componentes.get(i).getNombre()+" y la cantidad recomendada es "+componentes.get(i).getCantidadDeAlerta()+unMedida+"</p>");
                    out.println("<hr>");
                }
            }
            out.println("<br/>");
            
            List<Lugar> lugares = PersistenciaMateriales.getInstance().listaLugares();
           out.println("<h2>Los lugares que mas compraron</h2>");
            SortedMap<Integer,Lugar> lugaresConMasCompras = new TreeMap<Integer,Lugar>(Collections.reverseOrder());
            for(Lugar l :lugares) {
                int totalUnidadesVendidas = 0;
                for(Paquete p :l.getPaquetes()) {
                    totalUnidadesVendidas = totalUnidadesVendidas + p.getUnidadesVendidas();
                }
                lugaresConMasCompras.put(totalUnidadesVendidas, l);
            }
            int counter = 0;
            for (Map.Entry<Integer, Lugar> entry : lugaresConMasCompras.entrySet()) {
                if(counter == 3) {
                    break;
                }
                counter++;
                out.println("<hr>");
                out.println("<p>"+counter+"- "+entry.getValue()+" con "+entry.getKey()+" unidades compradas</p>");
            }
            out.println("<hr>");
            
            if(lugares.isEmpty()) {
                out.println("<p>No hay lugares en el sistema</p>");
            }
            
            out.println("<br>");
            List<Comprador> compradores = PersistenciaMateriales.getInstance().listaCompradores();
           out.println("<h2>Los compradores que mas compraron</h2>");
           
           SortedMap<Integer,Comprador> mejoresCompradores = new TreeMap<Integer,Comprador>(Collections.reverseOrder());
           for(Comprador c :compradores) {
               int totalUnidades = 0;
               for(Pedido p :c.getPedidos()) {
                    
                    totalUnidades = totalUnidades + p.getUnidades();
               }
               mejoresCompradores.put(totalUnidades, c);
           }
           counter = 0;
           for (Map.Entry<Integer, Comprador> entry : mejoresCompradores.entrySet()) {
                if(counter == 3) {
                    break;
                }
                counter++;
                out.println("<hr>");
                out.println("<p>"+counter+"- "+entry.getValue()+" con "+entry.getKey()+" unidades compradas</p>");
            }
           out.println("<hr>");
           
           if(compradores.isEmpty()) {
                out.println("<p>No hay compradores en el sistema</p>");
            }
           out.println("</div>");
           

            


        %>
    </body>
</html>
