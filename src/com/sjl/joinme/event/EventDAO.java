package com.sjl.joinme.event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sjl.joinme.database.JoinMeDB;
import com.sjl.joinme.tags.TagsDTO;


public class EventDAO {

	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public ArrayList<EventDTO> getAllEvents() {
		ArrayList<EventDTO> al = new ArrayList<>();
		EventDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from event order by event_name";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new EventDTO();
				dto.setEvent_id(rs.getInt("event_id"));
				dto.setEvent_name(rs.getString("event_name"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllEvents:" + e);
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
}
