<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.entities.Msg"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.dao.UserDao"%>
<%@page import="com.blog.entities.Category"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.LikeDao"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>


<%
User user = (User) session.getAttribute("CurUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>

<% 
	int postId=Integer.parseInt(request.getParameter("post_id"));
    PostDao dao = new PostDao(ConnectionProvider.getConnection());
	Post p=dao.getPostByPid(postId);
%>
<title><%=p.getTitle() %></title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">


<nav class="navbar navbar-expand-lg navbar-dark primary-background">
	<a class="navbar-brand" href="home.jsp"> <span><i
			class="fa fa-edit"></i></span> Blog
	</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="home.jsp">Home
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
			<li class="nav-item"><a class="nav-link" href="profile.jsp">View Posts</a></li>
		</ul>
		<ul class="navbar-nav mr-right">
			<li class="nav-item"><a class="nav-link" href="#!"
				data-toggle="modal" data-target="#profile-modal"><span
					class="fa fa-user-circle"></span> <%=user.getName()%></a></li>
			<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
					class="fa fa-user-plus"></span> Logout</a></li>
		</ul>
	</div>
</nav>

<!-- profile modal -->
<div class="modal fade" id="profile-modal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header primary-background text-white text-center">
				<h5 class="modal-title" id="exampleModalLabel">Blog</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container text-center">
					<h5 class="modal-title" id="exampleModalLabel"><%=user.getName()%></h5>
				</div>
				<hr>
				<div id="profile-detail">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th scope="row">ID :</th>
								<td><%=user.getId()%></td>
							</tr>
							<tr>
								<th scope="row">Email :</th>
								<td><%=user.getEmail()%></td>
							</tr>
							<tr>
								<th scope="row">Registered on :</th>
								<td><%=user.getDateTime().toString()%></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div id="profile-edit" style="display: none" class="text-center">
					<h4 class="mt-3">Update your details-</h4>
					<form action="EditServlet" method="post">
						<table class="table table-bordered">

							<tbody>
								<tr>
									<th scope="row">ID :</th>
									<td><%=user.getId()%></td>
								</tr>
								<tr>
									<th scope="row">Name :</th>
									<td><input type="text" class="form-control"
										name="user_name" value="<%=user.getName()%>"></td>
								</tr>
								<tr>
									<th scope="row">Email :</th>
									<td><input type="email" class="form-control"
										name="user_email" value="<%=user.getEmail()%>"></td>
								</tr>
								<tr>
									<th scope="row">Password :</th>
									<td><input type="password" class="form-control"
										name="user_password" value="<%=user.getPassword()%>"></td>
								</tr>

							</tbody>
						</table>
						<div class="container">
							<button type="submit" class="btn btn-outline-primary">Save</button>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="edit-profile">Edit</button>
			</div>
		</div>
	</div>
</div>

<%
LikeDao l_dao = new LikeDao(ConnectionProvider.getConnection());
%>

<main>
	<div class="container">
		<div class="row my-4">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-header text-white primary-background">
						<h4 class="post-title"><%=p.getTitle() %></h4>
					</div>
					
					<div class="card-body">
						<p class="post-content"><%=p.getContent() %></p><br><br>
						<div class="post-code">
							<pre><%=p.getPcode() %></pre>
						</div>
					
						<hr>
						<div class="row row-user">
							<div class="col-md-8">
								<%
									UserDao udao = new UserDao(ConnectionProvider.getConnection());
									User u=udao.getUserByUserId(p.getUserId());
								%>
								<p><a href="#"><%=u.getName()%></a> has posted.</p>
							</div>
							
							<div class="col-md-4">
								<p style="font-style:italic"> <%=p.getPdate().toLocaleString() %></p>
							</div>
						</div>
					</div>
					<div class="card-footer text-white primary-background">
						<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId() %>)" class="btn btn-sm text-white btn-outline-light"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%=l_dao.countLike(p.getPid()) %></span></a>
						<a href="#!" class="btn btn-sm text-white btn-outline-light"><i class="fa fa-commenting"></i><span> 1</span></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>


<%@include file="footer.jsp"%>
<!-- loading posts -->
<script src="js/script.js"></script>
<script src="js/likedScript.js"></script>