package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ChangePassword {
	private Connection conn;
	public ChangePassword(Connection conn){
		this.conn = conn;
	}
	public String change(String username, String newPassword1, String newPassword2, String oldPassword) throws SQLException{
		String sql = "select * from users where username=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, username);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		if(rs.getString("password").equals(oldPassword)){
			if(newPassword1.equals(newPassword2)){
				if(newPassword1.length()>=8 && newPassword1.length()<=20){
					sql = "update users set password=? where username=?";
					stmt = conn.prepareStatement(sql);
					stmt.setString(1, newPassword1);
					stmt.setString(2, username);
					stmt.execute();
					return "Password succesfully changed.";
				} else {
					return "Password must contain 8 to 20 characters.";
				}
			} else {
				return "Entered passwords don't match.";
			}
		} else{
			return "Old password is incorrect.";
		}
	}
}
