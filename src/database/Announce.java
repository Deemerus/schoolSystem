package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Announce {
	private Connection conn;
	
	public Announce(Connection conn){
		this.conn=conn;
	}
	
	public String add(String className, String text) throws SQLException {
		if(text.equals("")){
			return "Announcement can't be empty";
		} else if(text.length()>=500){
			return "Announcements must contain up to 500 characters";
		} else{
			java.util.Date dt = new java.util.Date();
			java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			String sql = "insert into news (class, date, message) values (?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,  className);
			ps.setString(2, currentTime);
			ps.setString(3, text);
			ps.executeUpdate();
			return "Announcement succesfully added.";	
		}
	}
	
	
	
}
