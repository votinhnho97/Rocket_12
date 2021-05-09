package com.vti.FB.entity;

public class Message {
	private int senderID;
	private int receiverID;
	private String senderName;
	private String receiverName;
	private String content;

	public Message(int senderID, int receiverID, String content) {
		super();
		this.senderID = senderID;
		this.receiverID = receiverID;
		this.content = content;
	}

	public Message(String senderName, String receiverName, String content) {
		super();
		this.senderName = senderName;
		this.receiverName = receiverName;
		this.content = content;
	}

	public Message(int senderID, int receiverID, String senderName, String receiverName, String content) {
		super();
		this.senderID = senderID;
		this.receiverID = receiverID;
		this.senderName = senderName;
		this.receiverName = receiverName;
		this.content = content;
	}

	public int getSenderID() {
		return senderID;
	}

	public int getReceiverID() {
		return receiverID;
	}

	public String getContent() {
		return content;
	}

	public String getSenderName() {
		return senderName;
	}

	public String getReceiverName() {
		return receiverName;
	}

	@Override
	public String toString() {
		if(senderName == null)
			return "[#" + senderID + "]: " + content;
		return "[" + senderName + "]: " + content;
	}

}
