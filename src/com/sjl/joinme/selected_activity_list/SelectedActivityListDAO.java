package com.sjl.joinme.selected_activity_list;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sjl.joinme.created_activity_list.CreatedActivityListDTO;
import com.sjl.joinme.database.JoinMeDB;

public class SelectedActivityListDAO {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public boolean addSelectedActivityList(int user_id, int activity_id, String feedback_message) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "insert into selected_activity_list(user_id, activity_id,feedback_message)"
					+ " values(?,?,?)";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			ps.setInt(2, activity_id);
			ps.setString(3, feedback_message);

			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in addSelectedActivityList:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean updateSelectedActivityList(SelectedActivityListDTO dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "update selected_activity_list set user_id=?, activity_id=? where selected_activity_list_id="
					+ dto.getSelected_activity_list_id();
			ps = conn.prepareStatement(query);
			ps.setInt(1, dto.getUser_id());
			ps.setInt(2, dto.getActivity_id());
			// ps.setString(3, dto.getCreated_datetime());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in updateSelectedActivityList:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<CreatedActivityListDTO> getSelectedActivities(int user_id) {
		ArrayList<CreatedActivityListDTO> al = new ArrayList<>();
		CreatedActivityListDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String qurey = "select created_activity_list.* from selected_activity_list,"
					+ " created_activity_list where created_activity_list.activity_id=selected_activity_list.activity_id"
					+ " and selected_activity_list.user_id=" + user_id;
			ps = conn.prepareStatement(qurey);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new CreatedActivityListDTO();
				dto.setActivity_date(rs.getString("activity_date"));
				dto.setActivity_id(rs.getInt("activity_id"));
				dto.setActivity_name(rs.getString("activity_name"));
				dto.setCost(rs.getInt("cost"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setActivity_description(rs.getString("activity_description"));
				dto.setStatus(rs.getString("status").charAt(0));
				dto.setTag_id(rs.getInt("tag_id"));
				dto.setUser_id(rs.getInt("user_id"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getSelectedActivities: " + e);
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

	public boolean deleteSelectedActivityList(int activity_id, int user_id) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "delete from selected_activity_list where activity_id=? and user_id=?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, activity_id);
			ps.setInt(2, user_id);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in deleteSelectedActivityList:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean userIDANDActivityIDExist(int user_id, int activity_id) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from selected_activity_list where user_id=" + user_id + "&& activity_id="
					+ activity_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in userIDANDActivityIDExist:" + e);
		} finally {
			ps = null;
			rs = null;
			conn = null;
			return flag;
		}
	}

	public SelectedActivityListDTO getSelectedActivityList(int selected_activity_list_id) {
		SelectedActivityListDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from selected_activity_list where selected_activity_list_id="
					+ selected_activity_list_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new SelectedActivityListDTO();
				dto.setActivity_id(rs.getInt("activity_id"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setSelected_activity_list_id(rs.getInt("selected_activity_list_id"));
				dto.setUser_id(rs.getInt("user_id"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getSelectedActivityList:" + e);
		} finally {
			ps = null;
			rs = null;
			conn = null;
			return dto;
		}
	}

	public ArrayList<SelectedActivityListDTO> getAllSelectedActivityList() {
		ArrayList<SelectedActivityListDTO> al = new ArrayList<>();
		SelectedActivityListDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from selected_activity_list";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new SelectedActivityListDTO();
				dto.setActivity_id(rs.getInt("activity_id"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setSelected_activity_list_id(rs.getInt("selected_activity_list_id"));
				dto.setUser_id(rs.getInt("user_id"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllSelectedActivityList:" + e);
		} finally {
			if (al.isEmpty()) {
				al = null;
			}
			ps = null;
			rs = null;
			conn = null;
			return al;
		}
	}

	public ArrayList<SelectedActivityListDTO> getAllSelectedActivityListWithActivityID(int activity_id) {
		ArrayList<SelectedActivityListDTO> al = new ArrayList<>();
		SelectedActivityListDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from selected_activity_list where activity_id=" + activity_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new SelectedActivityListDTO();
				dto.setActivity_id(rs.getInt("activity_id"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setSelected_activity_list_id(rs.getInt("selected_activity_list_id"));
				dto.setUser_id(rs.getInt("user_id"));
				dto.setFeedback_message(rs.getString("feedback_message"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllSelectedActivityListWithActivityID:" + e);
		} finally {
			if (al.isEmpty()) {
				al = null;
			}
			ps = null;
			rs = null;
			conn = null;
			return al;
		}
	}

	public int getAllSelectedActivityListCountWithActivityID(int activity_id) {
		int count = -1;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select count(*) as count from selected_activity_list where activity_id=" + activity_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllSelectedActivityListCountWithActivityID:" + e);
		} finally {
			ps = null;
			rs = null;
			conn = null;
			return count;
		}
	}
}