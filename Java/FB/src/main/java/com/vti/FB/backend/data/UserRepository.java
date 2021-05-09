package com.vti.FB.backend.data;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vti.FB.entity.Message;
import com.vti.FB.entity.User;
import com.vti.FB.utils.JDBCUtils;
import com.vti.FB.utils.Properties.MessageProperties;

public class UserRepository implements IUserRepository {
	private JDBCUtils jdbcUtils;
	private MessageProperties msgProperties;

	public UserRepository() throws FileNotFoundException, IOException {
		jdbcUtils = new JDBCUtils();
		msgProperties = new MessageProperties();
	}

	public boolean isAccountExists(String userName) throws SQLException {
		boolean isExists = false;
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT `userName` FROM `Users` WHERE `userName` = ?";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setString(1, userName);
		ResultSet resultSet = preStatement.executeQuery();
		isExists = resultSet.next() ? true : false;
		jdbcUtils.disconnect();
		return isExists;
	}

	public void createAccount(String userName, String passWord, String name) throws SQLException {
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "INSERT INTO `Users` (`userName`, `passWord`, `name`) VALUES (?, ?, ?)";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setString(1, userName);
		preStatement.setString(2, passWord);
		preStatement.setString(3, name);
		int rowEffected = preStatement.executeUpdate();
		System.out.println(rowEffected > 0 ? msgProperties.getValue("createAccount.success")
				: msgProperties.getValue("createAccount.fail"));
		jdbcUtils.disconnect();
	}

	public User login(String userName, String passWord) throws SQLException {
		User user = null;
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT * FROM `Users` WHERE `userName` = ? AND `passWord` = ?";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setString(1, userName);
		preStatement.setString(2, passWord);
		ResultSet resultSet = preStatement.executeQuery();
		while (resultSet.next()) {
			user = new User(resultSet.getInt("userID"), resultSet.getString("userName"), resultSet.getString("name"));
		}
		jdbcUtils.disconnect();
		return user;
	}

	public List<User> getFriendList(int userID) throws SQLException {
		List<User> users = new ArrayList<User>();
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT * FROM `Users` WHERE userID IN (SELECT `friendID` FROM `Relationship` WHERE userID = ? AND status = 'Friend')";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, userID);
		ResultSet resultSet = preStatement.executeQuery();
		while (resultSet.next()) {
			User user = new User(resultSet.getInt("userID"), resultSet.getString("userName"),
					resultSet.getString("name"));
			users.add(user);
		}
		jdbcUtils.disconnect();
		return users;
	}

	public List<User> getLastContacts(int userID) throws SQLException {
		List<User> users = new ArrayList<User>();
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT u.`userID`, u.`userName`, u.`name` "
				+ "FROM (SELECT DISTINCT(receiverID) FROM `Messages` WHERE senderID = ? ORDER BY timeCreated DESC) r "
				+ "JOIN `Users` u " + "ON r.`receiverID` = u.`userID`";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, userID);
		ResultSet resultSet = preStatement.executeQuery();
		while (resultSet.next()) {
			User user = new User(resultSet.getInt("userID"), resultSet.getString("userName"),
					resultSet.getString("name"));
			users.add(user);
		}
		jdbcUtils.disconnect();
		return users;
	}

	public List<Message> getMessages(int userID, int friendID) throws SQLException {
		List<Message> messages = new ArrayList<Message>();
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT * FROM `Messages` WHERE senderID IN (?, ?) AND receiverID IN (?, ?) ORDER BY timeCreated";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, userID);
		preStatement.setInt(2, friendID);
		preStatement.setInt(3, userID);
		preStatement.setInt(4, friendID);
		ResultSet resultSet = preStatement.executeQuery();
		while (resultSet.next()) {
			Message msg = new Message(resultSet.getInt("senderID"), resultSet.getInt("receiverID"),
					resultSet.getString("content"));
			messages.add(msg);
		}
		jdbcUtils.disconnect();
		return messages;
	}

	public boolean sendMessage(int senderID, int receiverID, String content) throws SQLException {
		boolean isSent = false;
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "INSERT INTO `Messages` (senderID, receiverID, content) VALUES (?, ?, ?)";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, senderID);
		preStatement.setInt(2, receiverID);
		preStatement.setString(3, content);
		int rowEffected = preStatement.executeUpdate();
		if (rowEffected > 0) {
			isSent = true;
			System.out.println(msgProperties.getValue("sendMessage.success"));
		} else {
			System.out.println(msgProperties.getValue("sendMessage.fail"));
		}
		jdbcUtils.disconnect();
		return isSent;
	}

	public void requestFriend(int userID, int friendID) throws SQLException {
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "INSERT INTO `Relationship` VALUES (?, ?, 'Wait')";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, userID);
		preStatement.setInt(2, friendID);
		int rowEffected = preStatement.executeUpdate();
		if (rowEffected > 0) {
			System.out.println(msgProperties.getValue("requestFriend.success"));
		} else {
			System.out.println(msgProperties.getValue("requestFriend.fail"));
		}
		jdbcUtils.disconnect();
	}

	public void acceptFriend(int userID, int friendID) throws SQLException {
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "UPDATE `Relationship` SET `status` = 'Friend' WHERE `userID` = ? AND `friendID` = ?";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, friendID);
		preStatement.setInt(2, userID);
		int rowEffected1 = preStatement.executeUpdate();
		
		sql = "INSERT INTO `Relationship` VALUES (?, ?, 'Friend')";
		preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, userID);
		preStatement.setInt(2, friendID);
		int rowEffected2 = preStatement.executeUpdate();
		
		if (rowEffected1 > 0 && rowEffected2 > 0) {
			System.out.println(msgProperties.getValue("acceptFriend.success"));
		} else {
			System.out.println(msgProperties.getValue("acceptFriend.fail"));
		}
		jdbcUtils.disconnect();
	}
// k tra có yêu cầu kết bạn từ friendID tới userID
	public boolean isRequestFriend(int userID, int friendID) throws SQLException {
		boolean isRequest = false;
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT * FROM `Relationship` WHERE userID = ? AND friendID = ? AND status = 'Wait'";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, friendID);
		preStatement.setInt(2, userID);
		ResultSet resultSet = preStatement.executeQuery();
		isRequest = resultSet.next() ? true : false;
		jdbcUtils.disconnect();
		return isRequest;
	}

	public boolean isFriend(int userID, int friendID) throws SQLException {
		boolean isFr = false;
		jdbcUtils.connect();
		Connection connection = jdbcUtils.getConnection();
		String sql = "SELECT * FROM `Relationship` WHERE userID = ? AND friendID = ? AND status = 'Friend'";
		PreparedStatement preStatement = connection.prepareStatement(sql);
		preStatement.setInt(1, userID);
		preStatement.setInt(2, friendID);
		ResultSet resultSet = preStatement.executeQuery();
		isFr = resultSet.next() ? true : false;
		jdbcUtils.disconnect();
		return isFr;
	}

}
