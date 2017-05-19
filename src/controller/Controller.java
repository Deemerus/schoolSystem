package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import beans.User;
import database.*;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;

	public Controller() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		try {
			InitialContext initContext = new InitialContext();
			Context env = (Context) initContext.lookup("java:comp/env");
			ds = (DataSource) env.lookup("jdbc/sql11172637");
		} catch (NamingException e) {
			throw new ServletException();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		if (action == null) {
			request.getRequestDispatcher("/welcome.jsp").forward(request, response);
		} else if (action.equals("sign")) {
			request.getRequestDispatcher("/sign.jsp").forward(request, response);
		} else if (action.equals("welcome")) {
			request.getRequestDispatcher("/welcome.jsp").forward(request, response);
		} else if (action.equals("changepassword")) {
			request.getRequestDispatcher("/changepassword.jsp").forward(request, response);
		} else if (action.equals("signOut")) {
			session.setAttribute("user", null);
			request.getRequestDispatcher("/welcome.jsp").forward(request, response);
		} else if (action.equals("manageUsers")) {
			request.getRequestDispatcher("/manageUsers.jsp").forward(request, response);
		} else if (action.equals("manageClasses")) {
			request.getRequestDispatcher("/manageClasses.jsp").forward(request, response);
		} else if (action.equals("manageSubjects")) {
			request.getRequestDispatcher("/manageSubjects.jsp").forward(request, response);
		} else if (action.equals("editGrades")) {
			request.setAttribute("chosenSubject", request.getParameter("subject"));
			request.getRequestDispatcher("/editGrades.jsp").forward(request, response);
		} else if (action.equals("grades")) {
			request.getRequestDispatcher("/grades.jsp").forward(request, response);
		} else if (action.equals("announce")) {
			request.getRequestDispatcher("/announce.jsp").forward(request, response);
		} else if (action.equals("announcements")) {
			request.getRequestDispatcher("/announcements.jsp").forward(request, response);
		} else if (action.equals("addUser")) {
			request.getRequestDispatcher("/addUser.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		Connection conn = null;

		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}

		if (action.equals("doSignIn")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			try {
				Authentication auth = new Authentication(conn);
				if (auth.authenticate(username, password)) {
					User user = auth.getUser(username);
					session.setAttribute("user", user);
					request.getRequestDispatcher("/welcome.jsp").forward(request, response);
				} else {
					request.setAttribute("msg", "Wrong username or password.");
					request.getRequestDispatcher("/sign.jsp").forward(request, response);
				}
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("doChangePassword")) {
			User user = (User) session.getAttribute("user");
			String username = user.getUsername();
			try {
				ChangePassword changepass = new ChangePassword(conn);
				String msg = changepass.change(username, request.getParameter("newPassword1"),
						request.getParameter("newPassword2"), request.getParameter("oldPassword"));
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/changepassword.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("createUser")) {
			String firstName = request.getParameter("firstName");
			String secondName = request.getParameter("secondName");
			String className = request.getParameter("className");
			int authorization = Integer.parseInt(request.getParameter("authorization"));
			ManageUsers add = new ManageUsers(conn);
			try {
				String msg = add.add(firstName, secondName, className, authorization);
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/addUser.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("addClass")) {
			String className = request.getParameter("className");
			ManageClasses addClass = new ManageClasses(conn);
			try {
				String msg = addClass.add(className);
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/manageClasses.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("deleteClass")) {
			ManageClasses deleteClass = new ManageClasses(conn);
			try {
				deleteClass.remove(request.getParameter("className"));
				request.setAttribute("msg",
						"Class succesfully removed. All students that were in this class are now unassigned to any.");
				request.getRequestDispatcher("/manageClasses.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("addSubject")) {
			ManageSubjects addSubject = new ManageSubjects(conn);
			String msg;
			try {
				msg = addSubject.add(request.getParameter("subjectName"));
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/manageSubjects.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("deleteSubject")) {
			ManageSubjects deleteSubject = new ManageSubjects(conn);
			try {
				deleteSubject.remove(request.getParameter("subjectName"));
				request.setAttribute("msg", "Subject and all grades succesfully removed.");
				request.getRequestDispatcher("/manageSubjects.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}

		} else if (action.equals("doRemoveUser")) {
			ManageUsers removeUser = new ManageUsers(conn);
			try {
				removeUser.remove(request.getParameter("removeUser"));
				String msg = removeUser.remove(request.getParameter("removeUser"));
				request.setAttribute("msg", msg);
				request.setAttribute("filteredClass", request.getParameter("className"));
				request.getRequestDispatcher("/manageUsers.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}

		} else if (action.equals("changeClass")) {
			ManageUsers changeClass = new ManageUsers(conn);
			String className = request.getParameter("className");
			try {
				changeClass.changeClass(request.getParameter("username"), className);
				request.setAttribute("msg", "Class succesfully changed.");
				request.setAttribute("filteredClass", request.getParameter("filteredClass"));
				request.getRequestDispatcher("/manageUsers.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);

			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}

		} else if (action.equals("filterClass")) {
			try {
				conn.close();
			} catch (SQLException e) {
			}
			request.setAttribute("filteredClass", request.getParameter("className"));
			request.getRequestDispatcher("/manageUsers.jsp").forward(request, response);
		} else if (action.equals("changeGrades")) {
			ManageUsers getStudents = new ManageUsers(conn);
			String subject = (String) request.getParameter("subject");
			try {
				ArrayList<String> students = getStudents.getStudentsFromClass((String) request.getParameter("class"));
				for (String student : students) {
					int grade = 0;
					int j = 1;
					for (int i = 0; i < 10; i++) {
						grade += j * Integer.parseInt(request.getParameter(student + Integer.toString(i)));
						j = j * 10;
					}
					getStudents.changeGrades(student, subject, grade);
				}
				request.setAttribute("chosenSubject", subject);
				request.setAttribute("msg", "Grades succesfully changed.");
				request.getRequestDispatcher("/editGrades.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		} else if (action.equals("announce")){
			Announce announce = new Announce(conn);
			try {
				String msg = announce.add(request.getParameter("className"), request.getParameter("announcement"));
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("/announce.jsp").forward(request, response);
			} catch (SQLException e) {
				request.getRequestDispatcher("/error.jsp").forward(request, response);
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
}
