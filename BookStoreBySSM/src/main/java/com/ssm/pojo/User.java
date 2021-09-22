package com.ssm.pojo;

public class User {
	private String id;
    private String userName;
    private String userPassword;
    private String address;
    
	public User() {
		super();
	}

	public User(String id, String userName, String userPassword, String address) {
		super();
		this.id = id;
		this.userName = userName;
		this.userPassword = userPassword;
		this.address = address;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	
}
