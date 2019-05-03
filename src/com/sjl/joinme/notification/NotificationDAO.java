package com.sjl.joinme.notification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sjl.joinme.activity_request.ActivityRequestDAO;
import com.sjl.joinme.database.JoinMeDB;

public class NotificationDAO {
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private Connection conn = null;

	public boolean addNotification(int user_id, int activity_id, String status, String message) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "insert into notification (user_id, activity_id, status, message) values(?,?,?,?)";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			ps.setInt(2, activity_id);
			ps.setString(3, status);
			ps.setString(4, message);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in addNotification: " + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<NotificationDTO> getNotifications(int user_id) {
		ArrayList<NotificationDTO> al = new ArrayList<>();
		NotificationDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from notification where user_id=? order by created_datetime desc";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new NotificationDTO();
				dto.setActivity_id(rs.getInt("activity_id"));
				dto.setMessage(rs.getString("message"));
				dto.setNotification_id(rs.getInt("notification_id"));
				dto.setStatus(rs.getString("status"));
				dto.setUser_id(rs.getInt("user_id"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getNotifications: " + e);
		} finally {
			if (al.isEmpty()) {
				al = null;
			}
			rs = null;
			ps = null;
			conn = null;
			return al;
		}
	}

	public int getNotificationCount(int user_id) {
		int count = 0;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select count(*) as count from notification where user_id=? and status='n' group by user_id";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getNotificationCount: " + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return count;
		}
	}

	public boolean markAsRead(int notification_id) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "update notification set status='r' where notification_id=" + notification_id;
			ps = conn.prepareStatement(query);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in markAsRead: " + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return flag;
		}
	}

	public String getActivityName(int activity_id) {
		String activity_name = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select activity_name from created_activity_list where activity_id=" + activity_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				activity_name = rs.getString("activity_name");
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getActivityName: " + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return activity_name;
		}
	}

	public boolean deleteNotification(int notification_id) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "DELETE FROM `joinme`.`notification` WHERE (`notification_id` = ?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, "" + notification_id);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in deleteNotification: " + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return flag;
		}
	}
}
