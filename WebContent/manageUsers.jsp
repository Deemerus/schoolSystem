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
		
		<sql:query var="classes" dataSource="${ds}" sql='select * from classes where name!="unassigned" order by name' />
		<form class="filterClass" action="/schoolSystem/Controller" method="post">
		Filter class:
			<input type="hidden" name="action" value="filterClass"> 
				<select name="className">
					<option value="unassigned">Unassigned</option>
					<c:forEach var="className" items="${classes.rows}">
						<c:choose>
							<c:when test="${className.name == filteredClass}">
								<option value="${className.name}" selected="selected">${className.name}</option>
							</c:when>
							<c:otherwise>
								<option value="${className.name}">${className.name}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select> <input type="submit" value="Filter">
		</form>
		<table class="manageUsers">
			<tr>
				<th style="min-width:100px"> </th>
				<th style="min-width:225px">Name</th>
				<th style="min-width:150px">Change class</th>
				<th>Remove</th>
			</tr>
			<c:if test="${empty filteredClass}">
				<sql:query var="teachers" dataSource="${ds}" sql='select * from users where authorization=1 order by secondName'/>
			</c:if>
			<c:if test="${not empty filteredClass}">
				<sql:query var="teachers" dataSource="${ds}" sql='select * from users where authorization=1 and classname="${filteredClass}" order by secondName'/>
			</c:if>
			
			<c:forEach var="teacher" items="${teachers.rows}">
				<tr>
					<td style="editGrades">Teacher</td>
					<td><c:out value='${teacher.firstName} ${teacher.secondName}'/></td>
					<td><form action="/schoolSystem/Controller" method="post">
							<input type="hidden" name="filteredClass" value="${filteredClass}">
							<input type="hidden" name="action" value="changeClass"> 
							<input type="hidden" name="username" value="${teacher.username}">
							<select name="className">
								<option value="unassigned">unassigned</option>
								<c:forEach var="className" items="${classes.rows}">
									<c:choose>
										<c:when test="${className.name == teacher.classname}">
											<option value="${className.name}" selected="selected">${className.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${className.name}">${className.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>	
							</select> 
							<input type="image" src="buttons/tick.png" style="width:20px;height:20px;">
						</form></td>
					<td>
						<form action="/schoolSystem/Controller" method="post">
							<input type="hidden" name="action" value="doRemoveUser">
							<input type="hidden" name="removeUser" value="${teacher.username}"> 
							<input type="hidden" name="className" value="${filteredClass}"> 
							<input type="image" src="buttons/cross.png" style="width:20px;height:20px;">
						</form>
					</td>
				</tr>
			</c:forEach>
			
			<c:if test="${empty filteredClass}">
				<sql:query var="students" dataSource="${ds}" sql='select * from users where authorization=0 order by secondName, firstName' />
			</c:if>
			<c:if test="${not empty filteredClass}">
				<sql:query var="students" dataSource="${ds}"
				sql='select * from users where authorization=0 and classname= "${filteredClass}" order by secondName, firstName' />
			</c:if>
			
			<c:forEach var="student" items="${students.rows}">
				<tr>
					<td class="editGrades">Student</td>
					<td><c:out value='${student.firstName} ${student.secondName }' /></td>
					<td><form action="/schoolSystem/Controller" method="post">
							<input type="hidden" name="filteredClass" value="${filteredClass}">
							<input type="hidden" name="action" value="changeClass"> 
							<input type="hidden" name="username" value="${student.username}">
							<select name="className">
								<option value="unassigned">unassigned</option>
								<c:forEach var="className" items="${classes.rows}">
									<c:choose>
										<c:when test="${className.name == student.classname}">
											<option value="${className.name}" selected="selected">${className.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${className.name}">${className.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>	
							</select> 
							<input type="image" src="buttons/tick.png" style="width:20px;height:20px;">
						</form></td>
					<td>
						<form action="/schoolSystem/Controller" method="post">
							<input type="hidden" name="action" value="doRemoveUser">
							<input type="hidden" name="removeUser" value="${student.username}"> 
							<input type="hidden" name="className" value="${filteredClass}"> 
							<input type="image" src="buttons/cross.png" style="width:20px;height:20px;">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:otherwise>
</c:choose>
<c:import url="menu2.jsp" />

