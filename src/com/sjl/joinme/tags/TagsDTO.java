package com.sjl.joinme.tags;

import java.io.Serializable;

public class TagsDTO implements Serializable{
	
	private int tag_id;
	private String tag, tag_description, created_datetime;

	public String getTag_description() {
		return tag_description;
	}

	public void setTag_description(String tag_description) {
		this.tag_description = tag_description;
	}

	public TagsDTO() {
	}

	public int getTag_id() {
		return tag_id;
	}

	public void setTag_id(int tag_id) {
		this.tag_id = tag_id;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}


	public String getCreated_datetime() {
		return created_datetime;
	}

	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
}