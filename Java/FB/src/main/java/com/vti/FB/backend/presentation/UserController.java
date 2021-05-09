package com.vti.FB.backend.presentation;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.vti.FB.backend.business.IUserService;
import com.vti.FB.backend.business.UserService;
import com.vti.FB.entity.Message;
import com.vti.FB.entity.User;
import com.vti.FB.utils.Properties.MessageProperties;

public class UserController {
	private IUserService userService;
	private MessageProperties msgProperties;

	public UserController() {
		userService = new UserService();
		try {
			msgProperties = new MessageProperties();
		} catch (FileNotFoundException e) {
			System.out.println("`{Filename(s)}.properties` not found!");
		} catch (IOException e) {
			System.out.println("`{Filename(s)}.properties` can't access!");
		}
	}

	public void createAccount(String userName, String passWord, String name) {
		if (userService.isAccountExists(userName))
			System.out.println(msgProperties.getValue("isAccountExists.true"));
		else
			userService.createAccount(userName, passWord, name);
	}

	public User login(String userName, String passWord) {
		User user = userService.login(userName, passWord);
		System.out
				.println(user != null ? msgProperties.getValue("login.success") : msgProperties.getValue("login.fail"));
		return user;
	}

	public List<User> getFriendList(int userID) {
		return userService.getFriendList(userID);
	}

	public List<User> getLastContacts(int userID) {
		return userService.getLastContacts(userID);
	}

	public List<Message> showMessages(int userID, int friendID) {
		if (userService.isFriend(userID, friendID))
			return userService.getMessages(userID, friendID);
		return null;
	}

	public void sendMessage(int senderID, int receiverID, String content) {
		if (userService.isFriend(senderID, receiverID))
			userService.sendMessage(senderID, receiverID, content);
		else
			System.out.println(msgProperties.getValue("sendMessage.warning"));
	}

	public void requestFriend(int userID, int friendID) {
		if (userID == friendID)
			System.out.println(msgProperties.getValue("requestFriend.inputValidation"));
		else if (userService.isFriend(userID, friendID))
			System.out.println(msgProperties.getValue("requestFriend.isFriend"));
		else if (userService.isRequestFriend(friendID, userID))
			System.out.println(msgProperties.getValue("requestFriend.isRequestFriend"));
		else
			userService.requestFriend(userID, friendID);
	}

	public void acceptFriend(int userID, int friendID) {
		if (userID == friendID)
			System.out.println(msgProperties.getValue("acceptFriend.inputValidation"));
		else {
			if (userService.isFriend(userID, friendID))
				System.out.println(msgProperties.getValue("acceptFriend.isFriend"));
			else if (!userService.isRequestFriend(userID, friendID))
				System.out.println(msgProperties.getValue("acceptFriend.isntRequestFriend"));
			else {
				userService.acceptFriend(userID, friendID);
			}
		}
	}

}
