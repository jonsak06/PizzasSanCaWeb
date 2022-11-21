<%-- 
    Document   : ModificarProveedor
    Created on : Nov 20, 2022, 10:43:56 AM
    Author     : Manuel
--%>

<%@page import="java.util.List"%>
<%@page import="Persistencia.PersistenciaMateriales"%>
<%@page import="Entidades.Proveedor"%>
<%
    String nombre = (String)request.getParameter("nombre");
    String direccion = (String)request.getParameter("direccion");
    String telefono = (String)request.getParameter("telefono");
    String id = (String)request.getParameter("id");
    Proveedor pro = null;
    List<Proveedor> proveedores = PersistenciaMateriales.getInstance().listaProveedores();
    for(int i=0; i<proveedores.size(); i++){
        if(Long.parseLong(id)==proveedores.get(i).getId()){
            pro=proveedores.get(i);
        }
    }
    pro.setDireccion(direccion);
    pro.setNombre(nombre);
    pro.setTelefono(telefono);
    PersistenciaMateriales.getInstance().merge(pro);

%>