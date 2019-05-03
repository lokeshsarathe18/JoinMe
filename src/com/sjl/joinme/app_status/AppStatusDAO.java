package com.sjl.joinme.app_status;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sjl.joinme.database.JoinMeDB;

public class AppStatusDAO {

	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public int getAppDownloads() {
		int a = 0;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select app_download from app_status";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			if (rs.next()) {
				a = rs.getInt("app_download");
				//System.out.println("App Downloads:" + rs.getInt("app_download"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception at getAppDownloads" + e);
		} finally {
			rs = null;
			conn = null;
			ps = null;
			return a;
		}
	}

	public boolean incrementAppDownloads() {
		int a = getAppDownloads();
		a++;
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}

		try {
			String query = "update app_status set app_download=?";
			ps = conn.prepareStatement(query);
			
			ps.setInt(1, a);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
           
			System.out.println("+++Exception at incrementAppDownloads" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;
		}
	}

	
	public int getWebAppVisits() {
		int a=0;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select web_app_visit from app_status";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			if (rs.next()) {
				a = rs.getInt("web_app_visit");
				//System.out.println("Web App Visits:" +a"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception at getWebAppVisits" + e);
		} finally {
			rs = null;
			conn = null;
			ps = null;
			return a;
		}
	}

	public boolean incrementWebAppVisits() {
		int a = getWebAppVisits();
		a++;
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}

		try {
			String query = "update app_status set web_app_visit=?";
			ps = conn.prepareStatement(query);
			
			ps.setInt(1, a);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
           
			System.out.println("+++Exception at incrementWebAppVisits" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;
		}
	}

	
	public int getAppVisits() {
		int a=0;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select app_visit from app_status";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			if (rs.next()) {
				a = rs.getInt("app_visit");
				//System.out.println("App Visits:" +a"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception at getAppVisits" + e);
		} finally {
			rs = null;
			conn = null;
			ps = null;
			return a;
		}
	}

	public boolean incrementAppVisits() {
		int a = getAppVisits();
		a++;
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}

		try {
			String query = "update app_status set app_visit=?";
			ps = conn.prepareStatement(query);
			
			ps.setInt(1, a);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
           
			System.out.println("+++Exception at incrementAppVisits" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;
		}
	}

}
