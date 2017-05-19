<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="ds" dataSource="jdbc/sql11172637" />
<c:import url="menu.jsp" />
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${user.authorization!=1 && user.authorization!=0}">
		<p>Need teacher authorization to acces this page.</p>
	</c:when>
	<c:when test="${user.className == 'unassigned'}">
		<p>You currently aren't assigned to any classes.</p>
	</c:when>
	<c:otherwise>
		<sql:query var="news" dataSource="${ds}" sql='select * from news where class=\"${user.className}\" order by date DESC' />
		<c:forEach var="announcement" items="${news.rows }">
			<div class="news">
			<p>${announcement.date }</p>
			<p>${announcement.message }</p>
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>