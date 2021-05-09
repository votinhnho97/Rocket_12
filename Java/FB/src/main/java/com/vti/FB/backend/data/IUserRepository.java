package com.vti.FB.backend.data;

import java.sql.SQLException;
import java.util.List;

import com.vti.FB.entity.Message;
import com.vti.FB.entity.User;

public interface IUserRepository {

	boolean isAccountExists(String userName) throws SQLException;

	void createAccount(String userName, String passWord, String name) throws SQLException;

	User login(String userName, String passWord) throws SQLException;

	List<User> getFriendList(int userID) throws SQLException;

	List<User> getLastContacts(int userID) throws SQLException;

	List<Message> getMessages(int userID, int friendID) throws SQLException;

	boolean sendMessage(int senderID, int receiverID, String content) throws SQLException;

	void requestFriend(int userID, int friendID) throws SQLException;

	void acceptFriend(int userID, int friendID) throws SQLException;

	boolean isRequestFriend(int userID, int friendID) throws SQLException;

	boolean isFriend(int userID, int friendID) throws SQLException;

}
