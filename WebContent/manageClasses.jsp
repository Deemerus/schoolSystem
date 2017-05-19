<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="ds" dataSource="jdbc/sql11172637" />
<c:import url="menu.jsp" />
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${user.authorization!=2}">
		<td class="content">
		<p>Need administator authorization to acces this page.</p>
	</c:when>
	<c:otherwise>
	<td class="leftmenu">
		<table class="leftmenu">
			<tr>
				<td width="100px">Class name</td>
				<td>Delete</td>
			</tr>
			<sql:query var="classes" dataSource="${ds}"
				sql="select * from classes where name!=\"unassigned\" order by name" />
			<c:forEach var="className" items="${classes.rows}">
				<tr>
					<td><c:out value="${className.name}"/></td>
					<td><form action="/schoolSystem/Controller" method="post">
					<input type="hidden" name="action" value="deleteClass">
					<input type="hidden" name="className" value="${className.name}">
					<input type="image" src="buttons/cross.png" style="width:20px;height:20px;">
					</form></td>
				</tr>
			</c:forEach>
		</table>
	</td>
	<td class="content">
		<c:if test="${not empty msg}">
			<p><c:out value="${msg}" /></p>
		</c:if>
		<div class="loginBorder">
		Add class:
		<form action="/schoolSystem/Controller" method="post">
			<input type="hidden" name="action" value="addClass"> 
			<input type="text" name="className" value="" maxlength="2" size="6"><br />
			<input type="submit" value="Add class">
		</form>
		</div>
	</td>	
	</c:otherwise>
</c:choose>
<c:import url="menu2.jsp" />



