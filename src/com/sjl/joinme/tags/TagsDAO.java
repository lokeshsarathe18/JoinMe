package com.sjl.joinme.tags;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.sjl.joinme.database.JoinMeDB;

public class TagsDAO {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public TagsDAO() {
	}

	public boolean addTags(TagsDTO dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "insert into tags(tag, tag_description) values(?,?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, dto.getTag());
			ps.setString(2, dto.getTag_description());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in addTags:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public int tagNameToTagID(String tag) {
		int flag = -1;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select tag_id from tags where tag='" + tag + "'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = rs.getInt("tag_id");
			}
		} catch (Exception e) {
			System.out.println("+++Exception in tagNameToTagID:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean updateTags(TagsDTO dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "update tags set tag=?, tag_description=? where tag_id=" + dto.getTag_id();
			ps = conn.prepareStatement(query);
			ps.setString(1, dto.getTag());
			ps.setString(2, dto.getTag_description());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in updateTags:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean deleteTags(int tag_id) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "delete from tags where tag_id=" + tag_id;
			ps = conn.prepareStatement(query);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("+++Exception in deleteTags:" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<TagsDTO> getAllTagsDTOByEvent(String event_id) {
		ArrayList<TagsDTO> al = new ArrayList<>();
		TagsDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from tags where event_id=" + event_id;
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new TagsDTO();
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setTag(rs.getString("tag"));
				dto.setTag_description(rs.getString("tag_description"));
				dto.setTag_id(rs.getInt("tag_id"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllTagsDTOByEvent:" + e);
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

	public ArrayList<TagsDTO> getAllTagsDTO() {
		ArrayList<TagsDTO> al = new ArrayList<>();
		TagsDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from tags";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new TagsDTO();
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setTag(rs.getString("tag"));
				dto.setTag_description(rs.getString("tag_description"));
				dto.setTag_id(rs.getInt("tag_id"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllTags:" + e);
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

	public ArrayList<String> getAllTags() {
		ArrayList<String> al = new ArrayList<>();
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select tag from tags order by tag";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				al.add(rs.getString("tag"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllTags:" + e);
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

	public TagsDTO getTagDTO(int tag_id) {

		TagsDTO dto = null;
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "select * from tags where tag_id='" + tag_id + "'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new TagsDTO();
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setTag(rs.getString("tag"));
				dto.setTag_description(rs.getString("tag_description"));
				dto.setTag_id(rs.getInt("tag_id"));

			}
		} catch (Exception e) {
			System.out.println("+++Exception in getTagDTO:" + e);
		} finally {

			ps = null;
			rs = null;
			conn = null;
			return dto;
		}
	}

	public HashMap<String,Integer> getTagsByEvent(String event_name) {
		HashMap<String,Integer> map = new HashMap<>();
		try {
			if (conn == null) {
				conn = JoinMeDB.getConnection();
			}
			String query = "SELECT tag,tag_id FROM tags,event where tags.event_id = event.event_id and event.event_name = '"
					+ event_name + "'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				map.put(rs.getString("tag"),rs.getInt("tag_id"));
			}
		} catch (Exception e) {
			System.out.println("+++Exception in getAllTags:" + e);
		} finally {
			if (map.isEmpty()) {
				map = null;
			}
			ps = null;
			rs = null;
			conn = null;
			return map;
		}
	}

	public static void main(String[] args) {
		System.out.println(new TagsDAO().tagNameToTagID("Sell"));
	}
}
