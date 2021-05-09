package com.vti.FB.entity;

public class User {
	private int userID;
	private String userName;
	private String name;

	public User(int userID, String userName, String name) {
		super();
		this.userID = userID;
		this.userName = userName;
		this.name = name;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", userName=" + userName + ", name=" + name + "]";
	}
	
}
