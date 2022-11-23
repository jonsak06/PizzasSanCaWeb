<%-- 
    Document   : crearTabla
    Created on : Nov 22, 2022, 11:19:00 PM
    Author     : Manuel
--%>

<%@page import="Entidades.Cantidad"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.Receta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% 
    out.println("<table class='table table-dark table-striped'>");
            out.println("<tr>");
            out.println("<th>Componente</th>");
            out.println("<th>Cantidad</th>");
            out.println("<th></th>");
            out.println("<th></th>");
            out.println(" </tr>   ");
 
              String rec = request.getParameter("long");
          
            List<Cantidad> cant = PersistenciaMateriales.getInstance().listaCantidades(Long.parseLong(rec));

            for(int i=0; i<cant.size(); i++){
                out.print("<tr>");
                out.print("<td>"+cant.get(i).getComponente().getNombre() +"</td>");
                out.print("<td><input type='number' id='"+cant.get(i).getId()+"' value='"+cant.get(i).getPorReceta() +"'</td>");
                out.print("<td><a id='\"tanda " + cant.get(i).getId() + "\"' onclick='editarUso(\""+cant.get(i).getId()+"\", \""+ rec +"\");'>Editar</a></td></td>");
              out.print("<td><a id='\"tanda " + cant.get(i).getId() + "\"' onclick='eliminarUso(\""+cant.get(i).getId()+"\", \""+ rec +"\");'>Eliminar</a></td></td>");
               out.print("</tr>");
            }
            out.println("</table>");
    %>
</html>


