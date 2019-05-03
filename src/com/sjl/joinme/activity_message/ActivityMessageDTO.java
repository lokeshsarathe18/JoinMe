package com.sjl.joinme.activity_message;

public class ActivityMessageDTO {

	public ActivityMessageDTO() {

	}

	private int activity_message_id, activity_id, user_id, reply_user_message_id;
	private String message, created_datetime, status;

	

	public int getReply_user_message_id() {
		return reply_user_message_id;
	}

	public void setReply_user_message_id(int reply_user_message_id) {
		this.reply_user_message_id = reply_user_message_id;
	}


	  public String getStatus() { return status; }
	  
	  public void setStatus(String status) { this.status = status; }
	 

	public int getActivity_message_id() {
		return activity_message_id;
	}

	public void setActivity_message_id(int activity_message_id) {
		this.activity_message_id = activity_message_id;
	}

	public int getActivity_id() {
		return activity_id;
	}

	public void setActivity_id(int activity_id) {
		this.activity_id = activity_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

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
