<%-- 
    Document   : proyectosact
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@ include file="secure.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*,java.awt.*,java.io.*, java.text.*, java.net.*;" %>
<%@ page import="javax.naming.*, javax.rmi.PortableRemoteObject"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");
        String ccemp = session.getAttribute("cod_emp").toString();
        String nomus = session.getAttribute("nom_emp").toString(); 
        String apus1 = session.getAttribute("of").toString();
        String apus2 = session.getAttribute("inst").toString();
        String mailus = session.getAttribute("e_mail").toString();
        
        String mensaje="";
        
        mensaje = request.getParameter("m");
        
        if(mensaje!=null){
        if(mensaje.equals("0")){%>
            <script>alert("Fallo en la Operaci�n.");</script>
        <%
        }
        else{ %>
            <script>alert("Operaci�n Exitosa");</script>
        <%
        }
        }
        
        BDServicios bd = new BDServicios();
        
        Vector snies     = new Vector();
        Vector planes    = new Vector();
        Vector proyectos = new Vector();
        Vector aux       = new Vector();
        
        snies     = bd.SNIES_CCosto();
        planes    = bd.Planes();
        proyectos = bd.ConsultarProyectosEstado();
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SEGUIMIENTO A LA PLANEACI�N - ESCUELA COLOMBIANA DE INGENIER�A JULIO GARAVITO</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Language" content="ES" />
    <meta name="language" content="spanish" />
    <meta name="author" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
    <meta name="copyright" content="Copyright (c) 2017" />
    <meta name="description" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
    <meta name="abstract" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">     
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Arsenal" rel="stylesheet">
    <link rel="stylesheet" href="css/seguimiento.css"> 
</head>
<body>

    <header>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <center><img src="img/img-header-2.jpg" class="img-responsive"></center>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 franjaColor">
                    <center><h4>.:: Plataforma de seguimiento a la planeaci�n ::.</h4><div align="right"><input class="btn-danger" type="button" align="right" value="Cerrar Sesi�n" onclick="location.href = '/planeacion/LogOut';"></center></div>
                </div>
            </div>
                <center><img src="img/img-proyectos2.jpg" alt="portada" class="img-responsive"></center>
        </div>
    </header>

    <nav>
        <div class="container">
        <ul class="nav nav-pills nav-justified">
          <li role="presentation"><a href="/planeacion/homeadm"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
          <li role="presentation" class="active"><a href="/planeacion/proyectosactadm"><span class="glyphicon glyphicon-duplicate"></span>Consulta de Proyectos Activos</a></li>
          <li role="presentation"><a href="/planeacion/seguimientoadm"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/allproyectos"><span class="glyphicon glyphicon-lamp"></span> Todos los Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/historialadm"><span class="glyphicon glyphicon-list-alt"></span> Parametros del Sistema</a></li>
          <li role="presentation"><a href="/planeacion/reportesadm"><span class="glyphicon glyphicon-file"></span> Reportes Administrador</a></li>
        </ul>
        </div>
    </nav>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            <div class="row">
                <%if(proyectos.size() > 0){%>
                <div class="col-md-12 filaCompleta">
                    
                    
                    <script language="javascript">
                        function doSearch() {
                            var tableReg = document.getElementById('regTable');
                            var searchText = document.getElementById('searchTerm').value.toLowerCase();
                            for (var i = 1; i < tableReg.rows.length; i++) {
                                var cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
                                var found = false;
                                for (var j = 0; j < cellsOfRow.length && !found; j++) {
                                    var compareWith = cellsOfRow[j].innerHTML.toLowerCase();
                                    if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1)) {
                                        found = true;
                                    }
                                }
                                if (found) {
                                    tableReg.rows[i].style.display = '';
                                } else {
                                    tableReg.rows[i].style.display = 'none';
                                }
                            }
                        }
                    </script>

                    <div class="filaCompleta">Filtrar por: <input id="searchTerm" type="text" onkeyup="doSearch()" class="input-sm  text-center col-md-12"/></div>
                    
                    <h3>A continuaci�n se presentan los proyectos de los usuarios. <strong>por Estado</strong></h3>Total consultados: <%=proyectos.size()%><br><br>
                    <p>
                    Para ordenar, clic sobre el titulo de la columna. <img src="img/order.png" alt="Smiley face" height="30" width="30">.
                        
                    <table class="table table-hover tablesorter" id="regTable">
                    <thead>
                      <tr>
                        <th>Id. Proyecto</th>
                        <th>Nombre</th>
                        <th>Plan</th>
                        <th>Unidad Ejecutora</th>
                        <th>Estado</th>
                        <th>Fecha Creaci�n</th>
                        <th>Tipo</th>
                        <th>Detalle</th>
                        <th>Editar</th>
                      </tr>
                    </thead>
                    <tbody>
                    
                      <% for ( int m = 0 ; m < proyectos.size() ; m++ ){
                        aux = (Vector)proyectos.elementAt(m);
                      %>
                      <tr>
                        <td><%=aux.elementAt(0)%></td>
                        <td><u><%=aux.elementAt(1)%></u></td>
                        <td><%=aux.elementAt(2)%></td>
                        <td><%=aux.elementAt(5)%></td>
                        <td><font color="Blue"><strong><%=aux.elementAt(3)%></strong></font></td>
                        <td><%=aux.elementAt(4)%></td>
                        <td><%=aux.elementAt(6)%></td>
                        
                        
                          <%if(aux.elementAt(3).equals("En Planeaci�n") || aux.elementAt(3).equals("Solicitud de Cambios")){%>
                        <td><a href="detalleproyadm?idp=<%=aux.elementAt(0)%>&est=1"><img src="img/detalle.png" width="20" height="22" border="0"></a></td>
                         <%}else{%>
                         <td><a href="detalleproyadm?idp=<%=aux.elementAt(0)%>&est=2"><img src="img/detalle.png" width="20" height="22" border="0"></a></td>
                         <%}%>
                        
                        
                        
                        
                        
                        <td><a href="editpr?idp=<%=aux.elementAt(0)%>"><img src="img/pen.png" width="20" height="22" border="0"></a></td>
                      </tr>
                      <%}%>
                    </tbody>
                    </table>
                    </p>
                </div>
                <%}%>
            </div>
            
    </section>



<!--FOOTER-->
<footer class="footerContainer">
    <div class="container">        
        <div class="row">
            <article class="col-sm-7 col-md-5">
                <p>                    
                    <strong>ESCUELA COLOMBIANA DE INGENIER�A JULIO GARAVITO</strong><br/>
                    AK.45 No.205-59 (Autopista Norte)<br/>
                    <i>Contact center</i>: +57(1) 668 3600<br/>
                    L�nea Nacional Gratuita: 018000112668<br/>
                    Informaci�n detallada en: www.escuelaing.edu.co<br/><br/>
                    <small>Personer�a Jur�dica 086 de enero 19 de 1973. Acreditaci�n Institucional de Alta Calidad Res. 002710 del 18 de marzo de 2019. (Vigencia 6 a�os).<br>
                    Vigilada Mineducaci�n.</small><br><br>
                    Bogot�, D.C. - Colombia<br/>
                
            </article>
            <article class="col-sm-5 col-md-7">
                <p>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1987.9617427360993!2d-74.04338482936627!3d4.783148717834411!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f85e374627fe5%3A0x540783a0b074c84d!2sEscuela+Colombiana+de+Ingenier%C3%ADa!5e0!3m2!1ses!2ses!4v1424190444206" width="100%" height="280" frameborder="0" style="border:0"></iframe>
                </p>
            </article>
        </div> 
    </div>       
</footer>




    






























    <!--SCRIPT BOOTSTRAP-->
    <script src="js/jquery.js"></script>
    <script src="https://code.jquery.com/jquery-latest.jS"></script>
    <script src="js/bootstrap.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/sorter/jquery-latest.js"></script>
    <script language="javascript" type="text/javascript" src="js/sorter/jquery.tablesorter.js" ></script>

	
	<script type="text/javascript">
	$(function() {
		$("table")
			.tablesorter({debug: true})
			//.tablesorterPager({container: $("#pager")});
	});
	</script>

</body>
</html>
