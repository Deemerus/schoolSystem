<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="ds" dataSource="jdbc/sql11172637" />
<c:import url="menu.jsp" />
<jsp:useBean id="user" class="beans.User" scope="session" />
<c:choose>
	<c:when test="${user.authorization!=1}">
	<td class="content">
		<p>Need teacher authorization to acces this page.</p>
	</c:when>
	<c:when test="${user.className == 'unassigned'}">
		<p>You currently aren't assigned to any classes.</p>
	</c:when>
	<c:otherwise>
	<td class="leftmenu">
		<sql:query var="subjects" dataSource="${ds}"
			sql='select * from subjects order by name' />
		<table class="choosesubject">
			<c:forEach var="subject" items="${subjects.rows }">
				<tr><td class="leftmenu" width="100px"><a href="/schoolSystem/Controller?action=editGrades&subject=${subject.name}">${subject.name}</a></td></tr>
				<c:if test="${empty chosenSubject}">
					<c:set var="chosenSubject" value="${subject.name}" />
				</c:if>
			</c:forEach>
		</table>
	</td>
	<td class="content">
		
		<sql:query var="students" dataSource="${ds}"
			sql='select * from users where authorization=0 and classname="${user.className}" order by secondName, firstName' />
		<form action="/schoolSystem/Controller" method="post">
			<input type="hidden" name="action" value="changeGrades"> <input
				type="hidden" name="class" value="${user.className}"> <input
				type="hidden" name="subject" value="${chosenSubject}">
			<table class="editGrades">
				<tr>
					<th style="min-width:180"></th>
					<th colspan="10">${chosenSubject}</th>
				</tr>
				<c:forEach var="student" items="${students.rows }"
					varStatus="studentStatus">
					<tr>
						<td>${student.firstName} ${student.secondName}</td>
						<c:set var="i" value="1" scope="page" />
						<c:forEach var="j" begin="0" end="9" step="1">
							<td><select name="${student.username}${j}">
									<c:choose>
										<c:when
											test="${0 == ((student[chosenSubject] % (10*i))- (student[chosenSubject] % i))/i}">
											<option value="0"></option>
										</c:when>
										<c:otherwise>
											<option value="0"></option>
										</c:otherwise>
									</c:choose>
									<c:forEach var="k" begin="1" end="6" step="1">
										<c:choose>
											<c:when
												test="${k == ((student[chosenSubject] % (10*i))- (student[chosenSubject] % i))/i}">
												<option value="${k}" selected>${k}</option>
											</c:when>
											<c:otherwise>
												<option value="${k}">${k}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
							</select></td>
							<c:set var="i" value="${i*10}" scope="page" />
						</c:forEach>
					</tr>
				</c:forEach>
			</table>
			<input class="button" type="submit" value="Edit">
		</form>
	</c:otherwise>
</c:choose>
<c:import url="menu2.jsp" />