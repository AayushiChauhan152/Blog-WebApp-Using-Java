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

public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EditServlet() {
        super();
       
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		
		HttpSession s=request.getSession();
		User u=(User) s.getAttribute("CurUser");
		u.setName(name);
		u.setEmail(email);
		u.setPassword(password);
		
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		dao.updateUser(u);
		
		Msg msg=new Msg("Profile updated Successfully!!!","success","alert-success");
		s.setAttribute("msg", msg);
		response.sendRedirect("profile.jsp");
	}

}
