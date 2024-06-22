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


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		User u=dao.getUserByEmailAndPswd(email, password);
		if(u==null) {
			System.out.print("something went wrong!");
			Msg msg=new Msg("Invalid email or password,try with another!","error","alert-danger");
			HttpSession s=request.getSession();
			s.setAttribute("msg", msg);
					
			response.sendRedirect("login.jsp");
		}else {
			HttpSession session=request.getSession();
			session.setAttribute("CurUser", u);
			response.sendRedirect("profile.jsp");
		}
		
	}

}
