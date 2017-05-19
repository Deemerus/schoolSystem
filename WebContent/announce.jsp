<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="ds" dataSource="jdbc/sql11172637" />
<c:import url="menu.jsp" />
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${user.authorization!=1}">
		<p>Need teacher authorization to acces this page.</p>
	</c:when>
	<c:when test="${user.className == 'unassigned'}">
		<p>You currently aren't assigned to any classes.</p>
	</c:when>
	<c:otherwise>
		<div class="news">
			<p>Make an announcement:</p>
			<form action="/schoolSystem/Controller" method="post">
				<input type="hidden" name="action" value="announce">
				<input type="hidden" name="className" value="${user.className}">
				<textarea type="text" name="announcement" cols="60" rows="5"></textarea><br/>
				<input type="submit" value="Send">
			</form>
			<p>${msg }</p>
		</div>
	</c:otherwise>
</c:choose>