package com.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.blog.entities.Category;
import com.blog.entities.Post;

public class PostDao {
	private Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<>();

		try {

			String query = "select * from category";
			PreparedStatement ps = this.con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int cid = rs.getInt("cid");
				String title = rs.getString("title");
				String desc = rs.getString("content");
				Category c = new Category(cid, title, desc);
				list.add(c);
			}

		} catch (Exception e) {
			System.out.print(e);
		}
		return list;
	}

	public boolean savePost(Post p) {
		boolean f = false;
		try {
			String query = "insert into post(title,content,pcode,cid,userId)values(?,?,?,?,?)";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setString(1, p.getTitle());
			ps.setString(2, p.getContent());
			ps.setString(3, p.getPcode());
			ps.setInt(4, p.getCid());
			ps.setInt(5, p.getUserId());
			f = true;
			int i = ps.executeUpdate();

			System.out.println(i + " row(s) affected");
		} catch (Exception e) {
			System.out.print(e);
		}
		return f;
	}

	public List<Post> getAllPosts() {
		List<Post> list = new ArrayList<>();

		try {
			String query = "select * from post";
			PreparedStatement ps = this.con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int pid = rs.getInt("pid");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("pcode");
				Timestamp date = rs.getTimestamp("pdate");
				int cid = rs.getInt("cid");
				int userId = rs.getInt("userId");
				Post p = new Post(pid, title, content, code, date, cid, userId);
				list.add(p);
			}

		} catch (Exception e) {
			System.out.print(e);
		}
		return list;
	}

	public List<Post> getPostByCid(int cid) {
		List<Post> list = new ArrayList<>();

		try {
			
			PreparedStatement ps = con.prepareStatement("select * from post where cid=?");
			ps.setInt(1,cid);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				int pid = rs.getInt("pid");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("pcode");
				Timestamp date = rs.getTimestamp("pdate");
				int userId = rs.getInt("userId");
				Post p = new Post(pid, title, content, code, date, cid, userId);
				list.add(p);
			}
		} catch (Exception e) {
			System.out.print(e);
		}
		return list;
	}
	
	
	public Post getPostByPid(int pid) {
		Post post=null;
		try {
			
			PreparedStatement ps = con.prepareStatement("select * from post where pid=?");
			ps.setInt(1,pid);
			ResultSet rs = ps.executeQuery();

			if(rs.next()) {
				String title = rs.getString("title");
				String content = rs.getString("content");
				String code = rs.getString("pcode");
				Timestamp date = rs.getTimestamp("pdate");
				int cid = rs.getInt("cid");
				int userId = rs.getInt("userId");
				post = new Post(pid, title, content, code, date, cid, userId);
				
			}
		} catch (Exception e) {
			System.out.print(e);
		}
		return post;
	}

}
