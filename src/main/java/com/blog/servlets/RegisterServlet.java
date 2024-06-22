package com.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.blog.dao.UserDao;
import com.blog.entities.Msg;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegisterServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String password=request.getParameter("password");			
			User user  = new User(name,email,password);
			
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			
			dao.saveUser(user);
			HttpSession s=request.getSession();
			Msg msg=new Msg("Registered Successfully!!!","success","alert-success");
			s.setAttribute("msg", msg);
			
			response.sendRedirect("login.jsp");
		}catch(Exception e) {
			System.out.println(e);
		}	
	}
}
