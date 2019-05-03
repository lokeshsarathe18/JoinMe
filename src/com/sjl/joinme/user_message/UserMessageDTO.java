package com.sjl.joinme.user_message;

public class UserMessageDTO {

	public UserMessageDTO() {

	}

	private int user_message_id, sender_id, receiver_id;

	private String message, created_datetime/* ,status */;

	/* message,sender_id,receiver_id */
	public int getUser_message_id() {
		return user_message_id;
	}

	public void setUser_message_id(int user_message_id) {
		this.user_message_id = user_message_id;
	}

	public int getSender_id() {
		return sender_id;
	}

	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}

	public int getReceiver_id() {
		return receiver_id;
	}

	public void setReceiver_id(int receiver_id) {
		this.receiver_id = receiver_id;
	}

	/*
	 * public String getStatus() { return status; }
	 * 
	 * public void setStatus(String status) { this.status = status; }
	 */

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCreated_datetime() {
		return created_datetime;
	}

	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}

}
