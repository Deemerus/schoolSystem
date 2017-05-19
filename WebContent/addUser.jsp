<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="ds" dataSource="jdbc/sql11172637" />
<c:import url="menu.jsp" />
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${user.authorization!=2}">
		<p>Need administator authorization to acces this page.</p>
	</c:when>
	<c:otherwise>
		<c:if test="${not empty msg}">
			<p><b>
				<c:out value="${msg}" />
			</b></p>
			<br />
		</c:if>
		<div class="loginBorder">
			Add user:
			<form action="/schoolSystem/Controller" method="post">
				<input type="hidden" name="action" value="createUser"> 
				First Name <input type="text" name="firstName" value=""><br />
				Second Name <input type="text" name="secondName" value=""><br />
				<sql:query var="classes" dataSource="${ds}" sql='select * from classes where name!="unassigned" order by name' />
				Class <select name="className">
					<c:forEach var="className" items="${classes.rows}">
						<option value="${className.name}">${className.name}</option>
					</c:forEach>
				</select> 
				<select name="authorization">
					<option value="0">Student</option>
					<option value="1">Teacher</option>
				</select><br/> 
				<input type="submit" value="Add user"><br />
			</form>
		</div>
	</c:otherwise>
</c:choose>