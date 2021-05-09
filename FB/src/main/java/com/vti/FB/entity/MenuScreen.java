package com.vti.FB.entity;

import java.io.IOException;
import java.util.List;

public class MenuScreen {
	private void showLogoScreen() {
		System.out.println(".--------------------------------------------------.");
		System.out.println(".               F A C E B O O K FaKe               .");
		System.out.println(".--------------------------------------------------.");
	}

	public void showMainMenuScreen() {
		showLogoScreen();
		System.out.println(". 1. Tạo tài khoản                                 .");
		System.out.println(". 2. Đăng nhập                                     .");
		System.out.println(". 0. Thoát                                         .");
		System.out.println(".--------------------------------------------------.");
		System.out.print(". Chọn chức năng : ");
	}

	public void showCreateAccountScreen() {
		showLogoScreen();
		System.out.println(". # Tạo tài khoản                                  .");
		System.out.println("....................................................");
	}

	public void showLoginScreen() {
		showLogoScreen();
		System.out.println(". # Đăng nhập                                      .");
		System.out.println("....................................................");
	}

	public void showAccountFunction() {
		showLogoScreen();
		System.out.println(". 1. Hiển thị danh sách bạn bè                     .");
		System.out.println(". 2. Hiển thị danh sách bạn bè nhắn tin gần đây    .");
		System.out.println(". 3. Hiển thị tin nhắn                             .");
		System.out.println(". 4. Nhắn tin                                      .");
		System.out.println(". 5. Yêu cầu kết bạn                               .");
		System.out.println(". 6. Đồng ý kết bạn                                .");
		System.out.println(". 0. Thoát                                         .");
		System.out.println("....................................................");
		System.out.print(". Chọn chức năng : ");
	}

	public void showFriendListScreen(List<User> users) {
		showLogoScreen();
		System.out.println(". # Danh sách bạn bè                               .");
		System.out.println("....................................................");
		System.out.printf(".%5s%25s%20s.\n", "ID", "Username", "Name");
		for (User user : users) {
			System.out.printf(".%5s%25s%20s.\n", user.getUserID(), user.getUserName(), user.getName());
		}
		showEndScreen();
	}

	public void showLastContactsScreen(List<User> users) {
		showLogoScreen();
		System.out.println(". # Danh sách liên hệ gần đây                      .");
		System.out.println("....................................................");
		System.out.printf(".%5s%25s%20s.\n", "ID", "Username", "Name");
		for (User user : users) {
			System.out.printf(".%5s%25s%20s.\n", user.getUserID(), user.getUserName(), user.getName());
		}
		showEndScreen();
	}

	public void showMessagesScreen() {
		showLogoScreen();
		System.out.println(". # Hiển thị tin nhắn                              .");
		System.out.println("....................................................");
	}
	
	public void showSendMessageScreen() {
		showLogoScreen();
		System.out.println(". # Nhắn tin                                       .");
		System.out.println("....................................................");
	}
	
	public void showRequestFriendScreen() {
		showLogoScreen();
		System.out.println(". # Yêu cầu kết bạn                                .");
		System.out.println("....................................................");
	}
	public void showAcceptFriendScreen() {
		showLogoScreen();
		System.out.println(". # Đồng ý kết bạn                                 .");
		System.out.println("....................................................");
	}
	public void showEndScreen() {
		System.out.println("!__________________________________________________!");
		System.out.println();
		System.out.println("Ấn 'Enter' để tiếp tục.");
		try {
			System.in.read();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
