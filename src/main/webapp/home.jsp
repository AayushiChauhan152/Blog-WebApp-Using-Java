<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="java.util.*"%>
<%@include file="base.jsp"%>

<div class="container-fluid p-0 m-0">
	<div class="jumbotron primary-background text-white banner-background">
		<div class="container">
			<h3 class="display-3">Welcome to Technology</h3>
			<p>Welcome to technology blog,world of technology!</p>
			<p>Technology is the application of conceptual knowledge for
				achieving practical goals, especially in a reproducible way.</p>
			<button class="btn btn-outline-light btn-lg">
				<span><i class="fa fa-user-plus"></i></span> Start! Its Free
			</button>
			<a href="login.jsp" class="btn btn-outline-light btn-lg">
				<span><i class="fa fa-user-circle"></i></span> Login
			</a>
		</div>
	</div>
</div>

<br>

<%
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	List<Post> allPosts=new ArrayList<>();
	 	allPosts = dao.getAllPosts();
%>

<div class="container">
	<div class="row">
		<%
		for (Post p : allPosts) {
		%>
		<div class="col-md-4">
			<div class="card">

				<div class="card-body">
					<h5 class="card-title"><%=p.getTitle()%></h5>
					<p class="card-text"><%=p.getContent()%></p>
					<a href="showPost.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-primary btn-sm">Read More...</a>
				</div>
			</div>
		</div>

		<%
			}
		%>

	</div>
</div>

<%@include file="footer.jsp"%>


