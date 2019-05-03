package com.sjl.joinme.contact;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sjl.joinme.database.JoinMeDB;

public class ContactDAO {

	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public boolean addContact(int user_id, int friend_id) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "insert into contact(user_id,friend_id) values(?,?)";
			ps = conn.prepareStatement(query);
			ps.setInt(1, user_id);
			ps.setInt(2, friend_id);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("+++Exception at addContact" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;

		}

	}
	
	public ArrayList<Integer> getFriendList(int user_id) {
		boolean flag = false;
		ArrayList<Integer> contact = new ArrayList<>();
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "SELECT user_id FROM joinme.contact  where friend_id = " + user_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				contact.add(rs.getInt("user_id"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception at getFriendList" + e);
		} finally {
			if (contact.isEmpty()) {
				contact = null;
			}
			conn = null;
			rs = null;
			ps = null;
			return contact;
		}
	}

	public ArrayList<Integer> getContactList(int user_id) {
		ArrayList<Integer> contact = new ArrayList<>();
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select friend_id from contact where user_id=" + user_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				contact.add(rs.getInt("friend_id"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception at getContactList" + e);
		} finally {
			if (contact.isEmpty()) {
				contact = null;
			}
			conn = null;
			rs = null;
			ps = null;
			return contact;
		}
	}

	public boolean friendExist(int user_id, int friend_id) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "select * from contact where user_id=" + user_id + " && friend_id=" + friend_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception at friendExist" + e);
		} finally {
			conn = null;
			ps = null;
			return flag;
		}
	}

	public static void main(String[] args) {
		System.out.println(new ContactDAO().getContactList(76));
	}
}
