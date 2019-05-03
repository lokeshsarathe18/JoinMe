package com.sjl.joinme.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.sjl.joinme.database.JoinMeDB;
import com.sjl.joinme.utility.encryption_decryption;

public class UserDAO {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public boolean addUser(UserDTO dto) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "insert into user( mobile_number,rating,coins,gender,unique_id,first_name,last_name,date_of_birth,email,about,password,lat,lng) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, dto.getMobile_number());
			ps.setInt(2, dto.getRating());
			ps.setInt(3, dto.getCoins());
			ps.setString(4, "" + dto.getGender());
			ps.setString(5, dto.getUnique_id());
			ps.setString(6, dto.getFirst_name());
			ps.setString(7, dto.getLast_name());
			ps.setString(8, dto.getDate_of_birth());
			ps.setString(9, dto.getEmail());
			ps.setString(10, dto.getAbout());
			ps.setString(11, /* encryption_decryption.encrypt( */dto.getPassword()/* ) */);///////////////////// need to
																							///////////////////// remove
																							///////////////////// comment
			ps.setString(12, dto.getLat());
			ps.setString(13, dto.getLng());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception at add user:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public int getUserView(int user_id) {
		int view = 0;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "SELECT sum(count) as view FROM created_activity_list where user_id = " + user_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				view = rs.getInt("view");
			}
		} catch (Exception e) {
			System.out.println("+++exception at getUserView" + e);
		} finally {
			ps = null;
			conn = null;
			return view;
		}
	}

	public boolean checkUserPassword(String unique_id, String password) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select password from user where unique_id='" + unique_id + "'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (/* encryption_decryption.encrypt( */password/* ) */.equals(rs.getString("password")))///////////////////// need
																											///////////////////// to
																											///////////////////// remove
																											///////////////////// comment
				{
					flag = true;
				}
			}
		} catch (Exception e) {
			System.out.println("+++Exception at checkUserPassword: " + e);
		} finally {
			return flag;
		}
	}

	public boolean updateUser(UserDTO dto) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "update user set mobile_number=?,rating=?,coins=?,gender=?,unique_id=?,first_name=?,last_name=?,date_of_birth=?,email=?,about=?,created_datetime=?,password=?,user_id=?,lat=?,lng=? where user_id="
					+ ((Integer) dto.getUser_id()).toString() + "";
			ps = conn.prepareStatement(query);
			ps.setString(1, dto.getMobile_number());
			ps.setInt(2, dto.getRating());
			ps.setInt(3, dto.getCoins());
			ps.setString(4, "" + dto.getGender());
			ps.setString(5, dto.getUnique_id());
			ps.setString(6, dto.getFirst_name());
			ps.setString(7, dto.getLast_name());
			ps.setString(8, dto.getDate_of_birth());
			ps.setString(9, dto.getEmail());
			ps.setString(10, dto.getAbout());
			ps.setString(11, dto.getCreated_datetime());
			ps.setString(12, /* encryption_decryption.encrypt( */dto.getPassword()/* ) */);
			ps.setInt(13, dto.getUser_id());
			ps.setString(14, dto.getLat());
			ps.setString(15, dto.getLng());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++exception at updateUser " + e.getMessage());
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean deleteStudent(int user_id) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "delete from user where user_id=?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++exception at delete user" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<UserDTO> getAllUsers() {
		UserDTO dto = null;
		ArrayList<UserDTO> list = new ArrayList<>();
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select * from user ";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new UserDTO();
				// mobile_number,rating,coins,gender,unique_id,first_name,last_name,
				// date_of_birth,email,location,about,created_datetime,password
				dto.setUser_id(rs.getInt("user_id"));
				dto.setMobile_number(rs.getString("mobile_number"));
				dto.setRating(rs.getInt("rating"));
				dto.setAbout(rs.getString("about"));
				dto.setCoins(rs.getInt("coins"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setDate_of_birth(rs.getString("date_of_birth"));
				dto.setEmail(rs.getString("email"));
				dto.setFirst_name(rs.getString("first_name"));
				dto.setGender(rs.getString("gender").charAt(0));
				dto.setLast_name(rs.getString("last_name"));
				dto.setPassword(encryption_decryption.decrypt(rs.getString("password")));
				dto.setUnique_id(rs.getString("unique_id"));
				dto.setLat(rs.getString("lat"));
				dto.setLng(rs.getString("lng"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++exception at get all user" + e);
		} finally {
			if (list.isEmpty()) {
				return null;
			}
			ps = null;
			conn = null;
			rs = null;
			return list;
		}
	}

	public ArrayList<String> getAllUsersName() {
		ArrayList<String> list = new ArrayList<>();
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select * from user";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add("\"" + rs.getString("unique_id") + "\"");
			}
		} catch (Exception e) {
			System.out.println("+++exception at getAllUsersName: " + e);
		} finally {
			if (list.isEmpty()) {
				return null;
			}
			ps = null;
			conn = null;
			rs = null;
			return list;
		}
	}

	public UserDTO getUser(int user_id) {
		UserDTO dto = null;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select * from user where user_id=?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new UserDTO();
				dto.setUser_id(rs.getInt("user_id"));
				dto.setMobile_number(rs.getString("mobile_number"));
				dto.setRating(rs.getInt("rating"));
				dto.setAbout(rs.getString("about"));
				dto.setCoins(rs.getInt("coins"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setDate_of_birth(rs.getString("date_of_birth"));
				dto.setEmail(rs.getString("email"));
				dto.setFirst_name(rs.getString("first_name"));
				// gives NullPointerException when gender not in database
				dto.setGender(rs.getString("gender").charAt(0));
				dto.setLast_name(rs.getString("last_name"));
				dto.setPassword(/* encryption_decryption.decrypt( */rs.getString("password")/* ) */);
				dto.setUnique_id(rs.getString("unique_id"));
				dto.setLat(rs.getString("lat"));
				dto.setLng(rs.getString("lng"));
			}
		} catch (Exception e) {
			System.out.println("+++exception at getUser: " + e);
		} finally {
			ps = null;
			conn = null;
			rs = null;
			return dto;
		}
	}

	public int getUserID(String unique_id) {
		int user_id = -1;
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select user_id from user where unique_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, unique_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}
		} catch (Exception e) {
			System.out.println("+++exception at get student" + e);
		} finally {
			ps = null;
			conn = null;
			rs = null;
			return user_id;
		}
	}

	public String getUniqueID(int user_id) {
		String unique_id = null;
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select unique_id from user where user_id=?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				unique_id = rs.getString("unique_id");
			}
		} catch (Exception e) {
			System.out.println("+++exception at get student" + e);
		} finally {
			ps = null;
			conn = null;
			rs = null;
			return unique_id;
		}
	}

	public boolean moblieNumberExist(String mobile_number) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select mobile_number from user where mobile_number=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, mobile_number);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++exception at checkMoblieNumber" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean uniqueIDExist(String unique_id) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select unique_id from user where unique_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, unique_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++exception at uniqueIDExist" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean changePassword(String mobile_number, String new_password) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "update user set password=? where mobile_number=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, new_password);
			ps.setString(2, mobile_number);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++exception at changePassword" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<UserDTO> getLocationUnderRadius(float radius, float lat, float lng) {
		ArrayList<UserDTO> al = new ArrayList<UserDTO>();

		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "SELECT * FROM joinme.user where sqrt(pow((lat-" + lat + "),2)+pow((lng-" + lng + "),2))<"
					+ radius + "/109.0319912594731";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				UserDTO dto = new UserDTO();
				dto = new UserDTO();
				dto.setUser_id(rs.getInt("user_id"));
				dto.setRating(rs.getInt("rating"));
				dto.setFirst_name(rs.getString("first_name"));
				dto.setLast_name(rs.getString("last_name"));
				dto.setLat(rs.getString("lat"));
				dto.setLng(rs.getString("lng"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getLocationUnderRadius:" + e);
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

	public ArrayList<String> getUserLocation(int user_id) {
		ArrayList<String> al = new ArrayList<>();
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "SELECT lat, lng FROM joinme.user where user_id= " + user_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				al.add(rs.getString("lat"));
				al.add(rs.getString("lng"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getUserLocation:" + e);
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

	public static void main(String[] args) {
		System.out.println(new UserDAO().getUserLocation(76));
	}
}