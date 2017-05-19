<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<sql:setDataSource var="ds" dataSource="jdbc/sql11172637" />
<c:import url="menu.jsp" />
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${user.authorization!=0}">
		This page is available only for students.
	</c:when>
	<c:otherwise>
		<sql:query var="students" dataSource="${ds}"
			sql='select * from users where username="${user.username}"' />
		<c:forEach var="student" items="${students.rows}">
		<table class="manageUsers">
				<sql:query var="subjects" dataSource="${ds}"
					sql='select * from subjects' />
				<c:forEach var="subject" items="${subjects.rows}">
					<tr><td class="grades">${subject.name}</td>
					<c:set var="j" value="1"/>
					<c:forEach var="i" begin="0" end="9" step="1">
						<td class="grades">
							<fmt:formatNumber value="${((student[subject.name]%(j*10))-(student[subject.name]%j))/j}" maxFractionDigits="0"/>
							<c:set var="j" value="${j*10}"/>
						</td>
					</c:forEach>
					</tr>
				</c:forEach>
		</table>
		</c:forEach>
	</c:otherwise>
</c:choose>
<c:import url="menu2.jsp" />