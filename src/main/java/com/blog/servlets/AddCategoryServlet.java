package com.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.blog.dao.CategoryDao;
import com.blog.entities.Category;
import com.blog.entities.Msg;
import com.blog.helper.ConnectionProvider;

public class AddCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddCategoryServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String desc = request.getParameter("desc");

		HttpSession session=request.getSession();
		Category c=new Category(title,desc);
		CategoryDao dao=new CategoryDao(ConnectionProvider.getConnection());
		
		if(dao.saveCategory(c)) {
			System.out.println("done");
			
			Msg msg=new Msg("Category added Successfully!!!","success","alert-success");
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
