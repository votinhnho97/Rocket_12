package com.vti.FB.backend.business;

import java.util.List;

import com.vti.FB.entity.Message;
import com.vti.FB.entity.User;

public interface IUserService {
	/*
	 * Kiểm tra xem userName đã tồn tại trong CSDL chưa. Nếu có, trả về true.
	 */
	boolean isAccountExists(String userName);

	/*
	 * Tạo tài khoản
	 */
	void createAccount(String userName, String passWord, String name);

	/*
	 * Đăng nhập thành công trả về User object chứa thông tin của tài khoản
	 */
	User login(String userName, String passWord);

	/*
	 * Trả về danh sách các tài khoản có mối quan hệ Friend với userID
	 */
	List<User> getFriendList(int userID);

	/*
	 * Trả về danh sách các tài khoản liên hệ gần nhất của userID, theo thứ tự giảm
	 * dần
	 */
	List<User> getLastContacts(int userID);

	/*
	 * Trả về danh sách tin nhắn của userID và friendID
	 */
	List<Message> getMessages(int userID, int friendID);

	/*
	 * Gửi tin nhắn từ senderID tới receiverID với nội dung content. Trả về true,
	 * nếu gửi thành công.
	 */
	boolean sendMessage(int senderID, int receiverID, String content);

	/*
	 * Gửi 1 yêu cầu kết bạn tới friendID
	 */
	void requestFriend(int userID, int friendID);

	/*
	 * Chấp nhận yêu cầu kết bạn từ friendID
	 */
	void acceptFriend(int userID, int friendID);

	/*
	 * Kiểm tra xem có yêu cầu kết bạn từ friendID không. Có thì trả về true.
	 */
	boolean isRequestFriend(int userID, int friendID);

	/*
	 * Kiểm tra xem userID và friendID có phải là bạn không. Trả về true nếu là bạn.
	 */
	boolean isFriend(int userID, int friendID);

}
