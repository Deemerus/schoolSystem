<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header>
	<link rel="stylesheet" type="text/css" href="styleMenu.css">
</header>
<head>
<title>School System</title>
</head>
<body>
	<jsp:useBean id="user" class="beans.User" scope="session" />
	<table class="menu">
		<tr>
			<th colspan="2" class="menu">
				<p class="menu">
					<img src="pics/logo.png" alt="Logo" align="left" class="logo">
					<c:choose>
						<c:when test="${empty user.username}">
							<a href="/schoolSystem/Controller?action=sign">Sign in</a>
						</c:when>
						<c:otherwise>
							Logged in as <c:out value="${user.username}" />
							<a href="/schoolSystem/Controller?action=changepassword">Change
								password</a>
							|
							<a href="/schoolSystem/Controller?action=signOut">Sign out</a>
						</c:otherwise>
					</c:choose>
				</p>
			</th>
		</tr>
		<c:if test="${not empty user.username}">
			<tr>
				<td class="midmenu" colspan="2">
				<div class="midmenu">
				<a href="/schoolSystem/Controller?action=welcome"><img
						src="buttons/button_main.png" class="midmenu" /></a> <c:choose>
						<c:when test="${user.authorization==2}">
							<a href="/schoolSystem/Controller?action=addUser"><img
								src="buttons/button_add-user.png" class="midmenu" /></a>
							<a href="/schoolSystem/Controller?action=manageUsers"><img
								src="buttons/button_manage-users.png" class="midmenu" /></a>
							<a href="/schoolSystem/Controller?action=manageClasses"><img
								src="buttons/button_manage-classes.png" class="midmenu" /></a>
							<a href="/schoolSystem/Controller?action=manageSubjects"><img
								src="buttons/button_manage-subjects.png" class="midmenu" /></a>
						</c:when>
						<c:when test="${user.authorization==1 }">
							<a href="/schoolSystem/Controller?action=editGrades"><img
								src="buttons/button_edit-grades.png" class="midmenu" /></a>
							<a href="/schoolSystem/Controller?action=announce"><img src="buttons/button_add-news.png"/></a>
							<a href="/schoolSystem/Controller?action=announcements"><img src="buttons/button_news.png"/></a>
						</c:when>
						<c:when test="${user.authorization==0 }">
							<a href="/schoolSystem/Controller?action=grades"><img
								src="buttons/button_view-grades.png" class="midmenu" /></a>
							<a href="/schoolSystem/Controller?action=announcements"><img src="buttons/button_news.png"/></a>
						</c:when>
					</c:choose></div></td>
			</tr>
		</c:if>
		<tr>
