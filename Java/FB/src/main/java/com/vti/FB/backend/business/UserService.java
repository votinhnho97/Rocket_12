package com.vti.FB.backend.business;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vti.FB.backend.data.IUserRepository;
import com.vti.FB.backend.data.UserRepository;
import com.vti.FB.entity.Message;
import com.vti.FB.entity.User;
import com.vti.FB.utils.Properties.MessageProperties;

public class UserService implements IUserService {
	private IUserRepository userRepository;
	private MessageProperties msgProperties;

	public UserService() {
		try {
			userRepository = new UserRepository();
			msgProperties = new MessageProperties();
		} catch (FileNotFoundException e) {
			System.out.println("`{Filename(s)}.properties` not found!");
		} catch (IOException e) {
			System.out.println("`{Filename(s)}.properties` can't access!");
		}
	}

	public boolean isAccountExists(String userName) {
		try {
			return userRepository.isAccountExists(userName);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("isAccountExists.error"));
		}
		return false;
	}

	public void createAccount(String userName, String passWord, String name) {
		try {
			userRepository.createAccount(userName, passWord, name);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("createAccount.error"));
		}
	}

	public User login(String userName, String passWord) {
		try {
			return userRepository.login(userName, passWord);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("login.error"));
		}
		return null;
	}

	public List<User> getFriendList(int userID) {
		List<User> friends = new ArrayList<User>();
		try {
			friends = userRepository.getFriendList(userID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("getFriendList.error"));
		}
		return friends;
	}

	public List<User> getLastContacts(int userID) {
		List<User> lastContacts = new ArrayList<User>();
		try {
			return userRepository.getLastContacts(userID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("getLastContacts.error"));
		}
		return lastContacts;
	}

	public List<Message> getMessages(int userID, int friendID) {
		try {
			return userRepository.getMessages(userID, friendID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("getMessages.error"));
		}
		return null;
	}

	public boolean sendMessage(int senderID, int receiverID, String content) {
		try {
			return userRepository.sendMessage(senderID, receiverID, content);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("sendMessage.error"));
		}
		return false;
	}

	public void requestFriend(int userID, int friendID) {
		try {
			userRepository.requestFriend(userID, friendID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("requestFriend.error"));
		}
	}

	public void acceptFriend(int userID, int friendID) {
		try {
			userRepository.acceptFriend(userID, friendID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("acceptFriend.error"));
		}
	}

	public boolean isRequestFriend(int userID, int friendID) {
		try {
			return userRepository.isRequestFriend(userID, friendID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("isRequestFriend.error"));
		}
		return false;
	}

	public boolean isFriend(int userID, int friendID) {
		try {
			return userRepository.isFriend(userID, friendID);
		} catch (SQLException e) {
			System.out.println(msgProperties.getValue("isFriend.error"));
		}
		return false;
	}

}
