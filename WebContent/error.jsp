<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="menu.jsp"/>
<td class="content">
<p>Error occured. Please try again later.</p>
<c:if test="${not empty msg}">
		<c:out value="${msg}" />
</c:if>
<c:import url="menu2.jsp"/>