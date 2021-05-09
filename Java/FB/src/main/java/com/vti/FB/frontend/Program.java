package com.vti.FB.frontend;

import java.util.List;
import java.util.Scanner;

import com.vti.FB.backend.presentation.UserController;
import com.vti.FB.entity.MenuScreen;
import com.vti.FB.entity.Message;
import com.vti.FB.entity.User;

public class Program {
	private static UserController userController;
	private static Scanner scanner;
	private static MenuScreen menuScreen;
	private static User user;
	private static boolean isLogin;

	public static void main(String[] args) {
		scanner = new Scanner(System.in);
		userController = new UserController();
		menuScreen = new MenuScreen();
		isLogin = false;
//		createAccount("trung", "123456", "Trung");
//		login("trung", "123456");
//		showFriendList(1);
//		showLastContacts(3);
//		showMessages(2, 3);
//		sendMessage(5, 6, "gửi cho 1 bạn đang chờ kết bạn");
//		requestFriend(1, 15);
//		acceptFriend(1, 15);
		mainMenu();
	}

	private static void mainMenu() {
		while (true) {
			if (!isLogin) {
				menuScreen.showMainMenuScreen();
				int choose = scanner.nextInt();
				System.out.println();

				if (choose == 1) {
					menuScreen.showCreateAccountScreen();
					System.out.print(". - Username = ");
					String userName = scanner.next();
					System.out.print(". - Password = ");
					String passWord = scanner.next();
					System.out.print(". - Yourname = ");
					String name = scanner.next();
					createAccount(userName, passWord, name);
					menuScreen.showEndScreen();
				}

				if (choose == 2) {
					menuScreen.showLoginScreen();
					System.out.print(". - Username = ");
					String userName = scanner.next();
					System.out.print(". - Password = ");
					String passWord = scanner.next();
					user = login(userName, passWord);
					if (user != null)
						isLogin = true;
					menuScreen.showEndScreen();
				}

				if (choose == 0) {
					System.out.println("Bye bye.");
					break;
				}
			} else {
				menuScreen.showAccountFunction();
				int choose = scanner.nextInt();
				System.out.println();

				if (choose == 1)
					menuScreen.showFriendListScreen(showFriendList(user.getUserID()));
				else if (choose == 2)
					menuScreen.showLastContactsScreen(showLastContacts(user.getUserID()));
				else if (choose == 3) {
					menuScreen.showMessagesScreen();
					System.out.print(". - FriendID = ");
					int friendID = scanner.nextInt();
					List<Message> messages = userController.showMessages(user.getUserID(), friendID);
					if (messages != null) {
						for (Message message : messages) {
							System.out.printf(". %-49s.\n", message.toString());
						}
					} else
						System.out.printf(".%-50s.\n", "Chưa phải bạn, không thể xem / gửi tin nhắn");
					menuScreen.showEndScreen();
				} else if (choose == 4) {
					menuScreen.showSendMessageScreen();
					System.out.print(". - FriendID = ");
					int receiverID = scanner.nextInt();
					System.out.print(". - Your msg = ");
					String msg = scanner.next();
					sendMessage(user.getUserID(), receiverID, msg);
					menuScreen.showEndScreen();
				} else if (choose == 5) {
					menuScreen.showRequestFriendScreen();
					System.out.print(". - FriendID = ");
					int friendID = scanner.nextInt();
					requestFriend(user.getUserID(), friendID);
					menuScreen.showEndScreen();
				} else if (choose == 6) {
					menuScreen.showAcceptFriendScreen();
					System.out.print(". - FriendID = ");
					int friendID = scanner.nextInt();
					acceptFriend(user.getUserID(), friendID);
					menuScreen.showEndScreen();
				}

				if (choose == 0) {
					System.out.println("Bye bye.");
					break;
				}
			}
		}
	}

	private static void createAccount(String userName, String passWord, String name) {
		userController.createAccount(userName, passWord, name);
	}

	private static User login(String userName, String passWord) {
		return userController.login(userName, passWord);
	}

	private static List<User> showFriendList(int userID) {
		return userController.getFriendList(userID);
	}

	private static List<User> showLastContacts(int userID) {
		return userController.getLastContacts(userID);
	}

	private static void showMessages(int userID, int friendID) {
		List<Message> messages = userController.showMessages(userID, friendID);
		if (messages.size() == 0)
			System.out.println("Chưa phải bạn, không thể xem / gửi tin nhắn.");
		else
			for (Message message : messages) {
				System.out.println(message.toString());
			}
	}

	private static void sendMessage(int senderID, int receiverID, String content) {
		userController.sendMessage(senderID, receiverID, content);
	}

	private static void requestFriend(int userID, int friendID) {
		userController.requestFriend(userID, friendID);
	}

	private static void acceptFriend(int userID, int friendID) {
		userController.acceptFriend(userID, friendID);
	}
}
