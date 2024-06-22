package com.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.blog.dao.PostDao;
import com.blog.entities.Msg;
import com.blog.entities.Post;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;

public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddPostServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cid = Integer.parseInt(request.getParameter("cid"));
		String title = request.getParameter("post_title");
		String desc = request.getParameter("post_desc");
		String code = request.getParameter("post_code");

		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("CurUser");
		Post p=new Post(title,desc,code,null,cid,user.getId());
		PostDao dao=new PostDao(ConnectionProvider.getConnection());
		
		if(dao.savePost(p)) {
			System.out.println("done");
			
			Msg msg=new Msg("Post Uploaded Successfully!!!","success","alert-success");
			session.setAttribute("msg", msg);
			
			response.sendRedirect("profile.jsp");
		}else {
			System.out.println("error");
			Msg msg=new Msg("Something went wrong!!","error","alert-danger");
			session.setAttribute("msg", msg);
			
			response.sendRedirect("profile.jsp");
		}
		
	}

}
