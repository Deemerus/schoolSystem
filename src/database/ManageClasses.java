package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ManageClasses {
	private Connection conn;

	public ManageClasses(Connection conn) {
		this.conn = conn;
	}

	public String add(String className) throws SQLException {
		if(className.length()==2){
			if((('a'<=className.charAt(1) && className.charAt(1)<='z') || ('A'<=className.charAt(1) && className.charAt(1)<='Z')) && ('0'<=className.charAt(0) && className.charAt(0)<='9')){
				String sql = "select count(*) as count from classes where name=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, className);
				ResultSet rs = stmt.executeQuery();
				rs.next();
				if (rs.getInt("count") == 1) {
					return "Class already exists.";
				}
				className = className.substring(0, 1) + className.substring(1).toUpperCase();
				sql = "insert into classes (name) values (?)";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, className);
				stmt.execute();
				return "Class: " + className + " succesfully added.";
			} else {
				return "Class name must be a digit followed by letter.";
			}
		} else{
			return "Class name must be a digit followed by letter.";
		}
	}
	public void remove(String className) throws SQLException {
		String sql = "delete from classes where name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, className);
		stmt.execute();
		sql = "update users set class=? where class=?";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, "unassigned");
		stmt.setString(2, className);
		stmt.execute();
	}
}
