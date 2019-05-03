package com.sjl.joinme.activity_images;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sjl.joinme.database.JoinMeDB;

public class ActivityImagesDAO {

	PreparedStatement ps = null;
	ResultSet rs = null;
	Connection conn = null;

	public boolean addActivityImages(ActivityImagesDTO DTO) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "insert into activity_images( activity_id, description, image) values (?,?,?)";
			ps = conn.prepareStatement(query);

			ps.setInt(1, DTO.getActivity_id());
			ps.setString(2, "");
			ps.setString(3, DTO.getImage());
			//ps.setString(4, DTO.getCreated_datetime());
			if (ps.executeUpdate() > 0) {
				//System.out.println("success");
				flag =true;
			}

		} catch (Exception e) {
			System.out.println("+++Exception at addActivityImages: " + e);
		} finally {
			ps = null;
			rs = null;
			conn = null;
			return flag;

		}
	}

	public boolean editActivityImage(int image_id, ActivityImagesDTO dto) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query="update activity_images set activity_id=?,description=?,image=? where image_id=?";
			ps=conn.prepareStatement(query);
			ps.setInt(1, dto.getActivity_id());
			ps.setString(2, dto.getDescription());
			ps.setString(3, dto.getImage());
			//ps.setString(2, dto.getCreated_datetime());
			ps.setInt(4, image_id);
			if(ps.executeUpdate()>0)
			{
				flag=true;
			}

		} catch (Exception e) {
			System.out.println("+++Execution at editActivityImage"+e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}
	
	public boolean deleteActivityImage(int image_id) {
		boolean flag = false;
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		try {
			String query = "delete from activity_images where image_id=?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, image_id);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("+++ Eception at deleteActiityImage" + e);
		} finally {
			ps = null;
			rs = null;
			conn = null;
			return flag;

		}

	}

	public ArrayList<ActivityImagesDTO> getActivityImageByActivityID(int activity_id) {
		if (conn == null) {
			conn = JoinMeDB.getConnection();
		}
		ArrayList<ActivityImagesDTO> list = new ArrayList<>();
		ActivityImagesDTO dto = null;
		try {
			String query = "select * from activity_images where activity_id=?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, activity_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ActivityImagesDTO();
				dto.setActivity_id(rs.getInt("activity_id"));
				dto.setCreated_datetime(rs.getString("created_datetime"));
				dto.setDescription(rs.getString("description"));
				dto.setImage(rs.getString("image"));
				dto.setImage_id(rs.getInt("Image_id"));
				list.add(dto);

			}

		} catch (Exception e) {
			System.out.println("+++Exception at getActivityImageByActivityID " + e);
		} finally {
			if (list.isEmpty()) {
				return null;
			}
			ps = null;
			rs = null;
			conn = null;
			return list;
		}
	}
}
