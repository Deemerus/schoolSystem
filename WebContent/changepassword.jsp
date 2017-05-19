<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="menu.jsp" />
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:if test="${empty user.username}">
		Session timed out. Please login again.
	</c:if>
<div class="loginBorder">
	<c:if test="${not empty user.username}">
		<c:if test="${not empty msg }">
			${msg}
		</c:if>
		<form action="/schoolSystem/Controller" method="post">
			<input type="hidden" name="action" value="doChangePassword">
			Old password:<br/><input type="password" name="oldPassword" value=""><br />
			New password:<br/><input type="password" name="newPassword1" value="">
			<br /> Repeat new password:<br/><input type="password" name="newPassword2"
				value=""><br /> <input type="submit"
				value="Change password"><br />
		</form>
	</c:if>
	<c:if test="${not empty msg}">
		<c:out value="${msg}" />
	</c:if>
</div>
<c:import url="menu2.jsp" />