package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ManageSubjects {
	private Connection conn;

	public ManageSubjects(Connection conn) {
		this.conn = conn;
	}

	public String add(String subjectName) throws SQLException {
		if(subjectName.equals("")){
			return "Must enter subject name";
		}
		char[] name = subjectName.toCharArray();
		for(char letter:name){
			if(!(Character.isLetter(letter)||(letter=='-'))){
				return "Subject name can only contain letters and dashes.";
			}
		}
		subjectName = name.toString();
		String sql = "select count(*) as count from subjects where name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, subjectName);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		if (rs.getInt("count") == 1) {
			return "Subject already exists.";
		}
		subjectName = subjectName.substring(0, 1).toUpperCase() + subjectName.substring(1).toLowerCase();
		sql = "insert into subjects (name) values (?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, subjectName);
		stmt.execute();
		
		sql="alter table users add column "+ subjectName + " bigint default 0";
		stmt=conn.prepareStatement(sql);
		stmt.executeUpdate();
		return "Subject: " + subjectName + " succesfully added.";
	}
	public void remove(String subjectName) throws SQLException {
		String sql = "delete from subjects where name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, subjectName);
		stmt.execute();
		sql = "alter table users drop column " + subjectName;
		stmt = conn.prepareStatement(sql);
		stmt.execute();
	}
	public ArrayList<String> getSubjects() throws SQLException{
		ArrayList<String> subjects = new ArrayList<String>();
		String sql = "select * from subjects";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.isLast()==false){
			rs.next();
			subjects.add(rs.getString("name"));
		}
		return subjects;
	}
}
