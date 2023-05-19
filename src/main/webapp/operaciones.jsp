<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="FIFA.*"%>
<%@ page import="java.io.*,java.util.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html">

<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<title>Proyecto Web FIFA23</title>
</head>

<body class="is-preload">
	<div id="page-wrapper">

		<%
		//variables glovales
				String tipo = request.getParameter("tipo");
				BDController conexionBD = new BDController();
				String estado="", contenido="";
				
				//Jugador
				if (tipo.equalsIgnoreCase("altajugador")) {
					int cod_jugador = (conexionBD.maxcodJugador() + 1);
					String nombre = request.getParameter("nombre");
					String pierna = request.getParameter("pierna");
					int cod_equipo = Integer.parseInt(request.getParameter("cod_equipo"));
					String pais = request.getParameter("pais");
					int altura = Integer.parseInt(request.getParameter("altura"));
					
					if(conexionBD.existeEquipo(cod_equipo)){
						conexionBD.altaJugador(cod_jugador, nombre, cod_equipo, pierna, altura, pais);
						estado="success";
						contenido="Jugador+añadido+correctamente";
					}else{
						estado="fail";
						contenido="El+codigo+de+equipo+introducido+no+pertenece+a+ningun+equipo";
					}

				} else if (tipo.equalsIgnoreCase("bajajugador")) {
					int cod_jugador = Integer.parseInt(request.getParameter("cod_jugador"));

					if(conexionBD.existeJugador(cod_jugador)){
						conexionBD.bajaJugador(cod_jugador);
						estado="success";
						contenido="Jugador+eliminado+correctamente";
					}else{
						estado="fail";
						contenido="El+codigo+del+jugador+introducido+no+existe";
					}
				
					
				}else if (tipo.equalsIgnoreCase("editarjugador")) {
				    int cod_jugador = Integer.parseInt(request.getParameter("cod_jugador"));
				    String nombre = request.getParameter("nombre");
				    String pierna = request.getParameter("pierna");
				    int cod_equipo = Integer.parseInt(request.getParameter("cod_equipo"));
				    String pais = request.getParameter("pais");
				    int altura = Integer.parseInt(request.getParameter("altura"));
				    
				    if (conexionBD.existeJugador(cod_jugador)) {
				        conexionBD.editarJugador(cod_jugador, nombre, cod_equipo, pierna, altura, pais);
				        estado = "success";
				        contenido = "Jugador+actualizado+correctamente";
				    } else {
				        estado = "fail";
				        contenido = "El+codigo+de+jugador+introducido+no+pertenece+a+ningun+jugador+existente";
				    }
				
				//Equipo    
				} else if (tipo.equalsIgnoreCase("altaequipo")) {
					int cod_equipo = (conexionBD.maxcodEquipo() + 1);
					String nombre = request.getParameter("nombre");
					int cod_liga = Integer.parseInt(request.getParameter("cod_liga"));
					
					if(conexionBD.existeLiga(cod_liga)){
						conexionBD.altaEquipo(cod_equipo, nombre, cod_liga);
						estado="success";
						contenido="Equipo+añadido+correctamente";
					}else{
						estado="fail";
						contenido="El+codigo+de+liga+introducido+no+pertenece+a+ninguna+liga";
					}

				} else if (tipo.equalsIgnoreCase("bajaequipo")) {
					int cod_equipo = Integer.parseInt(request.getParameter("cod_equipo"));

					if(conexionBD.existeEquipo(cod_equipo)){
						conexionBD.bajaEquipo(cod_equipo);
						estado="success";
						contenido="Equipo+eliminado+correctamente";
					}else{
						estado="fail";
						contenido="El+codigo+del+equipo+introducido+no+existe";
					}
				}else if (tipo.equalsIgnoreCase("editarequipo")) {
				    int cod_equipo = Integer.parseInt(request.getParameter("cod_equipo"));
				    String nombre = request.getParameter("nombre");
				    int cod_liga = Integer.parseInt(request.getParameter("cod_liga"));
				    
				    if (conexionBD.existeEquipo(cod_equipo)) {
				        conexionBD.editarEquipo(cod_equipo, nombre, cod_liga);
				        estado = "success";
				        contenido = "Equipo+actualizado+correctamente";
				    } else {
				        estado = "fail";
				        contenido = "El+codigo+de+equipo+introducido+no+pertenece+a+ningun+equipo+existente";
				    }

					
				//Liga
				} else if (tipo.equalsIgnoreCase("altaliga")) {
					int cod_liga = (conexionBD.maxcodLiga() + 1);
					String nombre = request.getParameter("nombre");
					String pais = request.getParameter("pais");
					conexionBD.editarLiga(cod_liga, nombre, pais);
					
					estado="success";
					contenido="Liga+añadida+correctamente";

				} else if (tipo.equalsIgnoreCase("bajaliga")) {
					int cod_liga = Integer.parseInt(request.getParameter("cod_liga"));
					
					if(conexionBD.existeLiga(cod_liga)){
						conexionBD.bajaLiga(cod_liga);
						estado="success";
						contenido="Liga+eliminada+correctamente";
					}else{
						estado="fail";
						contenido="El+codigo+de+la+liga+introducida+no+existe";
					}
				}else if (tipo.equalsIgnoreCase("editarliga")) {
				    int cod_liga = Integer.parseInt(request.getParameter("cod_liga"));
				    String nombre = request.getParameter("nombre");
				    String pais = request.getParameter("pais");

				    if (conexionBD.existeLiga(cod_liga)) {
				        conexionBD.editarLiga(cod_liga, nombre, pais);
				        estado = "success";
				        contenido = "Liga+actualizada+correctamente";
				    } else {
				        estado = "fail";
				        contenido = "El+codigo+de+liga+introducido+no+pertenece+a+ninguna+liga+existente";
				    }
				}
		%>
		<!-- Header -->
		<div id="header">

			<!-- Logo -->
			<h1>
				<a href="index.jsp" id="logo">FIFA23</a>
			</h1>

			<!-- Nav -->
			<nav id="nav">
			<ul>
				<li class="current"><a href="index.jsp">Inicio</a></li>
				<li><a href="#">Listados</a>
					<ul>
						<li><a href="ligas.jsp">FIFA 23 Ligas</a></li>
						<li><a href="equipos.jsp">FIFA 23 Equipos</a></li>
						<li><a href="jugadores.jsp">FIFA 23 Jugadores</a></li>
					</ul></li>
				<li><a href="#">Operaciones</a>
					<ul>
						<li><a href="#">Jugadores</a>
							<ul>
								<li><a href="operaciones.jsp?tipo=altajugador">Alta
										Jugador</a></li>
								<li><a href="#">Baja Jugador</a></li>
								<li><a href="#">Modificar Jugador</a></li>
							</ul></li>
						<li><a href="#">Equipos</a>
							<ul>
								<li><a href="#">Alta Equipo</a></li>
								<li><a href="#">Baja Equipo</a></li>
								<li><a href="#">Modificar Equipo</a></li>
							</ul></li>
						<li><a href="#">Ligas</a>
							<ul>
								<li><a href="#">Alta Liga</a></li>
								<li><a href="#">Baja Liga</a></li>
								<li><a href="#">Modificar Liga</a></li>
							</ul></li>
						<li><a href="#">Cartas</a>
							<ul>
								<li><a href="#">Alta Carta</a></li>
								<li><a href="#">Baja Carta</a></li>
								<li><a href="#">Modificar Carta</a></li>
							</ul></li>
					</ul></li>
				<li><a href="#">Simulador</a>
					<ul>
						<li><a href="#">Construye tu Equipo</a></li>
					</ul></li>
			</ul>
			</nav>
		</div>
		<!-- Main -->
		<section class="wrapper style1" style="height:500px;">
		<div class="container">
			<div id="content" style="text-align: center">

				<!-- Content -->

				<h1>
					<%
					out.print(contenido);
					%>
				</h1>
			</div>
		</div>
		</section>

		<!-- Footer -->
		<div id="footer">
			<div class="container">
				<div class="row">
					<section class="col-3 col-6-narrower col-12-mobilep">
					<h3>Listados</h3>
					<ul class="links">
						<li><a href="jugadores.asp">Listado de Jugadores</a></li>
						<li><a href="equipos.asp">Listado de Equipos</a></li>
						<li><a href="ligas.asp">Listado de Ligas</a></li>

					</ul>
					</section>
					<section class="col-3 col-6-narrower col-12-mobilep">
					<h3>Más Opciones</h3>
					<ul class="links">
						<li><a href="altaJugador.jsp">Alta Jugador</a></li>
						<li><a href="altaEquipo.jsp">Alta Equipo</a></li>
						<li><a href="altaLiga.jsp">Alta Liga</a></li>
						<li><a href="altaCarta.jsp">Alta Carta</a></li>
						<li><a href="modifiJugador.jsp">Modificar Jugador</a></li>
						<li><a href="modifiEquipo.jsp">Modificar Equipo</a></li>
						<li><a href="modifiLiga.jsp">Modificar Liga</a></li>
						<li><a href="modifiCarta.jsp">Modificar Carta</a></li>
					</ul>
					</section>
					<section class="col-6 col-12-narrower">
					<h3>Solicita Información</h3>
					<form>
						<div class="row gtr-50">
							<div class="col-6 col-12-mobilep">
								<input type="text" name="name" id="name" placeholder="Name" />
							</div>
							<div class="col-6 col-12-mobilep">
								<input type="email" name="email" id="email" placeholder="Email" />
							</div>
							<div class="col-12">
								<textarea name="message" id="message" placeholder="Message"
									rows="5"></textarea>
							</div>
							<div class="col-12">
								<ul class="actions">
									<li><input type="submit" class="button alt"
										value="Enviar Email" /></li>
								</ul>
							</div>
						</div>
					</form>
					</section>
				</div>
			</div>

			<!-- Icons -->
			<ul class="icons">
				<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
				<li><a href="#" class="icon fa-facebook"><span
						class="label">Facebook</span></a></li>
				<li><a href="#" class="icon fa-github"><span class="label">GitHub</span></a></li>
				<li><a href="#" class="icon fa-linkedin"><span
						class="label">LinkedIn</span></a></li>
				<li><a href="#" class="icon fa-google-plus"><span
						class="label">Google+</span></a></li>
			</ul>

			<!-- Copyright -->
			<div class="copyright">
				<ul class="menu">
					<li>&copy; FIFA 23. Todos los derechos reservados</li>
					<li>Design: <a href="https://www.centronelson.org">Centro
							Nelson</a></li>
				</ul>
			</div>

		</div>

	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.dropotron.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/index.js"></script>
	<script src="assets/js/dropdown.js"></script>

</body>

</html>