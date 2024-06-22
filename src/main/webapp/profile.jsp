<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.entities.Msg"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.entities.Category"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="java.util.*"%>
<%@page errorPage="error.jsp"%>


<%
User user = (User) session.getAttribute("CurUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


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
				<li class="nav-item"><a class="nav-link" href="#"
				data-toggle="modal" data-target="#add-category-modal">Add Category</a></li>
			<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
			<li class="nav-item"><a class="nav-link" href="#"
				data-toggle="modal" data-target="#add-post-modal">Add Post</a></li>
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


<%
	Msg m = (Msg) session.getAttribute("msg");
	if (m != null) {
%>
<div class="alert <%=m.getCssClass()%>" role="alert">
	<%=m.getContent()%>
</div>
<%
	session.removeAttribute("msg");
	}
%>


<!-- body of the project -->
<main>
	<div class="conatiner">
		<div class="row mt-4">
			<!-- first col -->
			<div class="col-md-4">
				<!-- categories -->
				<div class="list-group">
					<a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action primary-background text-white"
						aria-current="true"> All Posts </a>
					<%
						PostDao dao = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list = dao.getAllCategories();
						for (Category c : list) {
					%>
					<a href="#" onclick="getPosts(<%=c.getCid() %>,this)" class="c-link list-group-item list-group-item-action "><%=c.getTitle()%></a>
					<%
					}
					%>
				</div>

			</div>
			<!-- second col -->
			<div class="col-md-8">
				<!-- posts -->
				<div class="conatiner-fluid text-center" id="post-container">
					
				</div>

			</div>
		</div>
	</div>
</main>

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


<!-- add post modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add Post Details</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<form action="AddPostServlet" method="post" id="add-post-form">

					<div class="form-group">
						<select class="form-control" name="cid">

							<option selected disabled>---Select Category---</option>
							<%
							for (Category c : list) {
							%>
							<option value="<%=c.getCid()%>"><%=c.getTitle()%></option>
							<%
							}
							%>
						</select>
					</div>

					<div class="form-group mt-3">
						<input type="text" placeholder="enter title" class="form-control"
							name="post_title">
					</div>

					<div class="form-group">
						<textarea class="form-control"
							placeholder="enter post description" name="post_desc"></textarea>
					</div>


					<div class="form-group">
						<textarea class="form-control" placeholder="enter code (if any)"
							name="post_code"></textarea>
					</div>

					<div class="container text-center">
						<button type="submit" class="btn btn-outline-primary">Post</button>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- add post modal -->
<div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Add Category Details</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<form action="AddCategoryServlet" method="post" id="add-category-form">

					<div class="form-group mt-3">
						<input type="text" placeholder="enter title" class="form-control"
							name="title">
					</div>

					<div class="form-group">
						<textarea class="form-control"
							placeholder="enter category description" name="desc"></textarea>
					</div>

					<div class="container text-center">
						<button type="submit" class="btn btn-outline-primary">Add</button>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<%@include file="footer.jsp"%>

<!-- loading posts -->
<script src="js/script.js"></script>

<script>
	function getPosts(cid,ref){
		$(".c-link").removeClass('primary-background text-white')
		
		$.ajax({			
			url:'post.jsp',
			data:{cid:cid},
			success:function(data,textStatus,jqXHR){
				$('#post-container').html(data);
				$(ref).addClass('primary-background text-white');
			},
			
		})
	}
	$(document).ready(function(cid){
		let allPostRef=$('.c-link')[0]
		getPosts(0,allPostRef)
	})
</script>
