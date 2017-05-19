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
				<td width="100px">Subject name</td>
				<td>Delete</td>
			</tr>
			<sql:query var="subjects" dataSource="${ds}"
				sql="select * from subjects order by name" />
			<c:forEach var="subjectName" items="${subjects.rows}">
				<tr>
					<td><c:out value="${subjectName.name}"/></td>
					<td><form action="/schoolSystem/Controller" method="post">
					<input type="hidden" name="action" value="deleteSubject">
					<input type="hidden" name="subjectName" value="${subjectName.name}">
					<input type="image" src="buttons/cross.png" style="width:20px;height:20px;">
					</form></td>
				</tr>
			</c:forEach>
		</table>
	</td>
	<td class = "content">
		<c:if test="${not empty msg}">
			<p><c:out value="${msg}" /></p>
		</c:if>
		<div class="loginBorder">
		Add subject:
		<form action="/schoolSystem/Controller" method="post">
			<input type="hidden" name="action" value="addSubject"> <input
				type="text" name="subjectName" value=""><br /> <input
				type="submit" value="Add subject">
		</form>
		</div>
	</td>
	</c:otherwise>
</c:choose>
<c:import url="menu2.jsp" />
