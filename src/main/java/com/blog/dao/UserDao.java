package com.blog.dao;

import java.sql.*;
import com.blog.entities.User;

public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	public void saveUser(User user) {
		try {

			String query = "insert into user(name,email,password)values(?,?,?)";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());

			int i = ps.executeUpdate();

			System.out.println(i + " row(s) affected");

		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public User getUserByEmailAndPswd(String email, String password) {
		User user = null;
		try {
			String query = "Select * from user where email=? and password=?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet set = stmt.executeQuery();

			if (set.next()) {
				user = new User();
//				data from db
				String name = set.getString("name");
//				set to user object
				user.setName(name);
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setDateTime(set.getTimestamp("rdate"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return user;
	}

	public void updateUser(User user) {
		try {
			String query = "update user set name=?,email=?,password=? where id=?";
			PreparedStatement stmt = this.con.prepareStatement(query);

			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setInt(4, user.getId());

			stmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public User getUserByUserId(int userId) {
		User user = null;
		try {
			String query = "Select * from user where id=?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, userId);
			ResultSet set = stmt.executeQuery();

			if (set.next()) {
				String name = set.getString("name");
				String email=set.getString("email");
				String password=set.getString("password");
				Timestamp date = set.getTimestamp("rdate");
				user=new User(userId,name,email,password,date);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return user;

	}
}
