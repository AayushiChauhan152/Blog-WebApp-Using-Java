<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="java.util.*"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.LikeDao"%>
<%@page import="com.blog.entities.User"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">


<div class="row">
	
	<%
	LikeDao l_dao = new LikeDao(ConnectionProvider.getConnection());
	User user = (User) session.getAttribute("CurUser");
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	
	int cid=Integer.parseInt(request.getParameter("cid"));
	List<Post> allPosts=new ArrayList<>();
	if(cid==0){
	 	allPosts = dao.getAllPosts();
	}else{
		allPosts=dao.getPostByCid(cid);
	}
	if(allPosts.size()==0){
	%>
	<h3>No Post Found..</h3>
	<% 
	}
	for (Post p : allPosts) {
	%>
	<div class="col-md-6 mt-2">
		<div class="card">
			<div class="card-body">
				<b><%=p.getTitle()%></b>
				<p><%=p.getContent()%></p>
			</div>
			<div class="card-footer text-center primary-background">
			<a href="showPost.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-light btn-sm text-white">Read More...</a>
			<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId() %>)" class="btn btn-sm text-white btn-outline-light"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=l_dao.countLike(p.getPid()) %></span></a>
			<a href="#!" class="btn btn-outline-light btn-sm text-white"><i class="fa fa-commenting"></i><span> 1</span></a>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>
<%@include file="footer.jsp"%>
<script src="js/likedScript.js"></script>