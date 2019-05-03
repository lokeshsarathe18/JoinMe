package com.sjl.joinme.selected_activity_list;

import java.io.Serializable;

public class SelectedActivityListDTO implements Serializable{
	
	private int selected_activity_list_id, user_id ,activity_id;
	private String created_datetime;
	private String feedback_message;
	
	public SelectedActivityListDTO() {
	}

	public String getFeedback_message() {
		return feedback_message;
	}

	public void setFeedback_message(String feedback_message) {
		this.feedback_message = feedback_message;
	}

	public int getSelected_activity_list_id() {
		return selected_activity_list_id;
	}

	public void setSelected_activity_list_id(int selected_activity_list_id) {
		this.selected_activity_list_id = selected_activity_list_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getActivity_id() {
		return activity_id;
	}

	public void setActivity_id(int activity_id) {
		this.activity_id = activity_id;
	}

	public String getCreated_datetime() {
		return created_datetime;
	}

	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
}
