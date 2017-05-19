package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

public class ManageUsers {
	private Connection conn;
	private String username = null;
	private String password = null;

	public ManageUsers(Connection conn) {
		this.conn = conn;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	@SuppressWarnings("resource")
	public String add(String firstName, String secondName, String className, int authorization) throws SQLException {
		if (firstName.equals("") || secondName.equals("")) {
			return "Must enter both first and second name.";
		}
		char[] first = firstName.toCharArray();
		char[] second = secondName.toCharArray();
		for(char letter:first){
			if(!Character.isLetter(letter)){
				return "First and second names can only contain letters.";
			}
		}
		for(char letter:second){
			if(!Character.isLetter(letter)){
				return "First and second names can only contain letters.";
			}
		}
		firstName = firstName.substring(0, 1).toUpperCase() + firstName.substring(1).toLowerCase();
		secondName = secondName.substring(0, 1).toUpperCase() + secondName.substring(1).toLowerCase();
		String sql = "select count(*) as count from users where username=?";
		username = secondName + firstName.charAt(0);
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		int i = 0;
		while (rs.getInt("count") != 0) {
			i++;
			stmt.setString(1, username + Integer.toString(i));
			rs = stmt.executeQuery();
			rs.next();

		}
		if (i > 0)
			username = username + Integer.toString(i);
		username = username.toLowerCase();
		password = generatePass();
		sql = "insert into users (username, password, authorization, firstName, secondName, classname) values (?, ?, ?, ?, ?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		stmt.setString(2, password);
		stmt.setInt(3, authorization);
		stmt.setString(4, firstName);
		stmt.setString(5, secondName);
		stmt.setString(6, className);
		stmt.execute();
		return "Added user with username: " + username + " and password: " + password + ".";
	}

	private String generatePass() {
		String set = "1234567890qwertyuiopasdfghjklzxcvbnm";
		String password = "";
		Random random = new Random();
		for (int i = 0; i < 8; i++) {
			password = password + set.charAt(random.nextInt(set.length()));
		}
		return password;
	}

	public String remove(String username) throws SQLException {
		if(username.equals("teacher") || username.equals("smithj")){
			return "Cannot remove test users.";
		}
		String sql = "delete from users where username=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		stmt.execute();
		return "User succesfully removed.";
	}

	public void changeClass(String username, String newClass) throws SQLException {
		String sql = "update users set classname=? where username=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newClass);
		stmt.setString(2, username);
		stmt.executeUpdate();
	}

	public ArrayList<String> getStudentsFromClass(String className) throws SQLException {
		ArrayList<String> users = new ArrayList<String>();
		String sql = "select * from users where classname=? and authorization=0";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, className);
		ResultSet rs = stmt.executeQuery();
		while (rs.isLast() == false) {
			rs.next();
			users.add(rs.getString("username"));
		}
		return users;
	}

	public void changeGrades(String user, String subject, int grade) throws SQLException {
		String sql = "update users set " + subject + "=? where username=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, grade);
		stmt.setString(2, user);
		stmt.executeUpdate();
	}

}
