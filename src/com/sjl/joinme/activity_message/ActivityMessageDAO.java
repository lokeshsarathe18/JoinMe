package com.sjl.joinme.activity_message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sjl.joinme.database.JoinMeDB;
import com.sjl.joinme.user.UserDAO;
import com.sjl.joinme.user_message.UserMessageDTO;

public class ActivityMessageDAO {

	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private Connection conn = null;

	public boolean sendActivityMessage(int sender_user_id, int receiver_activity_id, int reply_user_message_id,
			String message) {

		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}

		try {
			String query = "insert into activity_message(user_id,activity_id,reply_user_message_id,message) values(?,?,?,?)";
			ps = conn.prepareStatement(query);
			ps.setInt(1, sender_user_id);
			ps.setInt(2, receiver_activity_id);
			ps.setInt(3, reply_user_message_id);
			ps.setString(4, message);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("+++Exception at SendActivityMessage" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;

		}
	}

	public boolean editActivityMessageStatus(int activity_message_id, String newStatus) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}

		try {
			String query = "update activity_message set status=? where activity_message_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, newStatus);
			ps.setInt(2, activity_message_id);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("+++Exception at editActivityMessageStatus" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;
		}
	}

	public ArrayList<ActivityMessageDTO> showActivityMessageDateVise(int receiver_activity_id, int sender_user_id,
			String status, String dateFrom, String dateTo) {

		ArrayList<ActivityMessageDTO> list = new ArrayList<>();
		ActivityMessageDTO dto = null;

		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {

			String query = "select * from activity_message where "
					+ "activity_id=? and user_id=? and created_datetime>? and created_datetime<? and status=? ";
			ps = conn.prepareStatement(query);
			ps.setInt(1, receiver_activity_id);
			ps.setInt(2, sender_user_id);
			ps.setString(3, dateFrom);
			ps.setString(4, dateTo);
			ps.setString(5, status);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ActivityMessageDTO();
				dto.setMessage(rs.getString("message"));
				dto.setReply_user_message_id(rs.getInt("reply_user_message_id"));
				dto.setActivity_message_id(rs.getInt("activity_message_id"));
				if (status == "U")
					editActivityMessageStatus(dto.getActivity_message_id(), "R");
				list.add(dto);
			}
		} catch (Exception e) {

			System.out.println("+++Exception at recieveActivityMessage" + e);

		} finally {
			if (list.isEmpty()) {
				return null;
			}
			conn = null;
			ps = null;
			rs = null;
			return list;
		}

	}

	public ArrayList<ActivityMessageDTO> getActivityComment(int activity_id) {
		ArrayList<ActivityMessageDTO> list = new ArrayList<>();
		ActivityMessageDTO dto = null;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {

			String query = "select * from activity_message where activity_id=? order by created_datetime desc";
			ps = conn.prepareStatement(query);
			ps.setInt(1, activity_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ActivityMessageDTO();
				dto.setMessage(rs.getString("message"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setActivity_id(activity_id);
				dto.setActivity_message_id(rs.getInt("activity_message_id"));
				dto.setReply_user_message_id(rs.getInt("reply_user_message_id"));
				dto.setStatus(rs.getString("status"));
				dto.setUser_id(rs.getInt("user_id"));

				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception at getActivityComment" + e);
		} finally {
			if (list.isEmpty()) {
				return null;
			}
			conn = null;
			ps = null;
			rs = null;
			return list;
		}
	}

	public boolean activityComment(int activity_id, int user_id, String message) {

		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}

		try {
			String query = "insert into activity_message(activity_id,user_id,message) values(?,?,?)";
			ps = conn.prepareStatement(query);
			ps.setInt(1, activity_id);
			ps.setInt(2, user_id);
			ps.setString(3, message);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("+++Exception at activityComment" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;

		}
	}

	// 56,62
	public static void main(String[] args) {

	}

}
