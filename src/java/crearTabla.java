/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Entidades.Cantidad;
import Entidades.Receta;
import Persistencia.PersistenciaMateriales;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Manuel
 */
@WebServlet(urlPatterns = {"/crearTabla"})
public class crearTabla extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
out.println("<table>");
            out.println("<tr>");
            out.println("<th>Componente</th>");
            out.println("<th>Cantidad</th>");
            out.println("<th></th>");
            out.println("<th></th>");
            out.println(" </tr>   ");
 
              String rec = request.getParameter("long");
            Receta Receta = null;
          
            List<Receta> recetas = PersistenciaMateriales.getInstance().listaRecetas();//Llamo a la base de datos
            
            for(int i=0; i<recetas.size(); i++){
                if(recetas.get(i).getId()== Long.parseLong(rec) ){
                    Receta=recetas.get(i);
                }
            }
            List<Cantidad> cant = Receta.getCantidades();

            for(int i=0; i<cant.size(); i++){
                out.print("<tr>");
                out.print("<td>"+cant.get(i).getComponente().getNombre() +"</td>");
                out.print("<td><input style=' width: 80%; background: #222222; color: white;  font-size: 1.6em;' type='number' id='"+cant.get(i).getId()+"' value='"+cant.get(i).getPorReceta() +"'</td>");
                out.print("<td><a id='\"tanda " + cant.get(i).getId() + "\"' onclick='editarUso(\""+cant.get(i).getId()+"\", \""+ Receta.getId() +"\");'>Editar</a></td></td>");
              out.print("<td><a id='\"tanda " + cant.get(i).getId() + "\"' onclick='eliminarUso(\""+cant.get(i).getId()+"\", \""+ Receta.getId() +"\");'>Eliminar</a></td></td>");
               out.print("</tr>");
            }
            out.println("</table>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
