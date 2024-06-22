package com.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	private Connection con;

	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean addLike(int pid, int uid) {
		boolean f = false;
		try {
			String query = "insert into liked(pid,uid) values(?,?)";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, pid);
			ps.setInt(2, uid);

			f = true;
			int i = ps.executeUpdate();

			System.out.println(i + " row(s) affected");

		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}

	public int countLike(int pid) {
		int c = 0;
		try {
			String query = "select count(*) from liked where pid=?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, pid);
			
			
			ResultSet rs = ps.executeQuery();

			if(rs.next()) {
				c=rs.getInt("count(*)");
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return c;
	}
	
	public boolean isLikedByUser(int pid,int uid) {
		boolean f=false;
		try {
			String query = "select * from liked where pid=? and uid=?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, pid);
			ps.setInt(2, uid);
		
			ResultSet rs = ps.executeQuery();

			if(rs.next()) {
				f=true;
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}
	
	public boolean isDisliked(int pid,int uid) {
		boolean f=false;
		try {
			String query = "delete from liked where pid=? and uid=?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setInt(1, pid);
			ps.setInt(2, uid);
		
			ps.executeUpdate();
			f=true;

		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}
	
}
