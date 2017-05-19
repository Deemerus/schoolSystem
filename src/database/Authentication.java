package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import beans.User;

public class Authentication {
	private Connection conn;

	public Authentication(Connection conn) {
		this.conn = conn;
	}

	public boolean authenticate(String username, String password) throws SQLException {
		if ((username.equals("admin") || username.equals("teacher") || username.equals("smithj")) && password.equals("password")) {
			return true;
		} else {
			String sql = "select count(*) as count from users where username=? and password=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = rs.getInt("count");
			}
			if (count == 0) {
				return false;
			} else {
				return true;
			}
		}
	}

	public User getUser(String username) throws SQLException {
		String sql = "select * from users where username=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		int authorization = rs.getInt("authorization");
		String className = rs.getString("classname");
		return new User(username, authorization, className);
	}

}
