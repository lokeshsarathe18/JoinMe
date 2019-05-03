package com.sjl.joinme.app_status;

import java.io.Serializable;

public class AppStatusDTO implements Serializable{

	private int app_status_id, app_download, web_app_visit, app_visit;
	
	public AppStatusDTO() {
		
	}
	
	public int getApp_status_id() {
		return app_status_id;
	}

	public void setApp_status_id(int app_status_id) {
		this.app_status_id = app_status_id;
	}

	public int getApp_download() {
		return app_download;
	}

	public void setApp_download(int app_download) {
		this.app_download = app_download;
	}

	public int getWeb_app_visit() {
		return web_app_visit;
	}

	public void setWeb_app_visit(int web_app_visit) {
		this.web_app_visit = web_app_visit;
	}

	public int getApp_visit() {
		return app_visit;
	}

	public void setApp_visit(int app_visit) {
		this.app_visit = app_visit;
	}
	
	
}
