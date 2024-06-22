package com.blog.helper;

import java.sql.*;

public class ConnectionProvider {
	
	private static Connection con;
	
	public static Connection getConnection() {
		String url = "jdbc:mysql://localhost:3306/blog?autoReconnect=true&useSSL=false";
        String username = "root";
        String password = "12345";
		try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
//            System.out.println("success!!");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
		return con;
	}
}
