<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="menu.jsp" />
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${not empty user.username}">
		<c:out value="Already logged in." />
	</c:when>
	<c:otherwise>
		<div class="loginBorder">
			Enter login and password:</br>
			<form action="/schoolSystem/Controller" method="post">
				<input type="hidden" name="action" value="doSignIn"> Login:</br>
				<input type="text" name="username" value=""></br> Password:</br> <input
					type="password" name="password" value=""></br> <input type="submit"
					value="Sign In">
			</form>
			<c:if test="${not empty msg}">
				<c:out value="${msg}" />
			</c:if>
		</div>
	</c:otherwise>
</c:choose>
<c:import url="menu2.jsp" />