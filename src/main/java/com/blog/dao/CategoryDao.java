package com.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.blog.entities.Category;

public class CategoryDao {

	private Connection con;

	public CategoryDao(Connection con) {
		this.con = con;
	}
	public boolean saveCategory(Category c) {
		boolean f = false;
		try {
			String query = "insert into category(title,content) values(?,?)";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setString(1, c.getTitle());
			ps.setString(2, c.getContent());
		
			f = true;
			int i = ps.executeUpdate();

			System.out.println(i + " row(s) affected");
		} catch (SQLException e) {
			System.out.println(e);
		}
		return f;
	}
}
