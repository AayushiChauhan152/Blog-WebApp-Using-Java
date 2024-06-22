package com.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.blog.dao.LikeDao;
import com.blog.helper.ConnectionProvider;

public class LikedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LikedServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String operation=request.getParameter("operation");
		int uid=Integer.parseInt(request.getParameter("uid"));
		int pid=Integer.parseInt(request.getParameter("pid"));
		LikeDao dao=new LikeDao(ConnectionProvider.getConnection());
		
		out.println(uid+" "+pid+" "+operation );
		if(operation.equals("like")) {
			boolean f=dao.addLike(pid, uid);
			out.print(f);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
