<%-- 
    Document   : index
    Created on : Nov 21, 2022, 2:09:55 PM
    Author     : Manuel
--%>
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
    </head>
    <body>
        <%
            
            out.println("<div class='formulario'><h2>Componentes que quedan poco</h2>");
            List<Componente> componentes = PersistenciaMateriales.getInstance().listaComponentes();
            for(int i=0; i<componentes.size(); i++){
                float cantidad = 0;
                for(int u=0; i<componentes.get(i).getProductos().size(); i++){
                    cantidad = cantidad + componentes.get(i).getProductos().get(u).getCantidad();
                }
                if(cantidad==componentes.get(i).getCantidadDeAlerta())
                {
                    out.println("<p>Hay "+cantidad+" de "+componentes.get(i).getNombre()+" y la cantidad recomendada es "+componentes.get(i).getCantidadDeAlerta()+"</p>");
                }
            }
            out.println("</div>");

        %>
    </body>
</html>
