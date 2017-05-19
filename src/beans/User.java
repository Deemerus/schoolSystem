package beans;

public class User {
	private String username = null;
	private int authorization;
	private String className;

	public User() {

	}

	public User(String username, Integer authorization, String className) {
		this.username = username;
		this.authorization = authorization;
		this.className = className;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getAuthorization() {
		return authorization;
	}

	public void setAuthorization(int authorization) {
		this.authorization = authorization;
	}

}
