<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="menu.jsp"/>
<td class="content">
<jsp:useBean id="user" class="beans.User" scope="session" />
<p>Hi<br/>
This is small project of website that could be used by teachers to grade their students and by students to view their grades. There are 3 types of users:<br/>
Administrators can add, remove users, change their classes, add or remove subjects and classes. <br/>
Teachers can grade students from their classes and leave announcements.<br/>
Students can view their grades and announcements left by their teachers<br/>
You can log in to test users by using following usernames: admin, teacher, smithj.<br/>
Password to every test account is the same: password (you can use it even after changing the password).<br/>
For obvious reasons these accounts cannot be deleted by admin.</p>
<p>During creation of this project my main interest was to learn back-end part of developing web applications. I tried to make it look decently, but appearance wasn't my main focus.
<p>All background textures were taken from <a href="https://www.toptal.com/designers/subtlepatterns/">Toptal Designers website</a>.<br/>
Logo created using <a href="https://logomakr.com/">Logo maker</a>.<br/>
Buttons are taken from <a href="http://www.freepik.com/">Freepik</a> or made using <a href="https://dabuttonfactory.com/">dabuttonfactory</a>.<br/>
Website created by Szymon Balcer. Source code available <a href="https://github.com/Deemerus/JavaEE/tree/master/schoolSystem">here</a>.

</p>
<c:import url="menu2.jsp"/>