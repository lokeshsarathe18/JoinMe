package com.sjl.joinme.activity_request;

import java.io.Serializable;

public class ActivityRequestDTO implements Serializable{
	int activity_request_id, user_id;
	String requested_activity_name, status;
	
	public ActivityRequestDTO() {
		
	}

	public int getActivity_request_id() {
		return activity_request_id;
	}

	public void setActivity_request_id(int activity_request_id) {
		this.activity_request_id = activity_request_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getRequested_activity_name() {
		return requested_activity_name;
	}

	public void setRequested_activity_name(String requested_activity_name) {
		this.requested_activity_name = requested_activity_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
