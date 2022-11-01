<%-- 
    Document   : crearTablaReceta
    Created on : Oct 26, 2022, 1:17:07 PM
    Author     : Manuel
--%>

<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Receta"%>
<%@page import="Entidades.Componente"%>
<%@page import="Entidades.Cantidad"%>

<table class="default">

  <tr>

    <td>Componente</td>

    <td>Cantidad</td>

  </tr>
<%
    String rec = request.getParameter("rec");
    Receta Receta = null;
    List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();
    for(int i=0; i<recetas.size(); i++){
        if(recetas.get(i).getId()== Long.parseLong(rec) ){
            Receta=recetas.get(i);
        }
    }
    List<Cantidad> cant = Receta.getCantidades();
    
    for(int i=1; i<cant.size(); i++){
        out.print("<tr>");
        out.print("<td>"+cant.get(i).getComponente().getNombre() +"</td>");
        out.print("<td>"+cant.get(i).getClass() +"</td>");
        out.print("</tr>");
    }
    
%>
</table>