<%@include file="base.jsp"%>
<%@page import="com.blog.entities.Msg" %>
<main class="d-flex align-items-center" style="height:70vh">

	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
				
				<div class="card-header primary-background text-white text-center">
					<span class="fa fa-user-plus fa-3x"></span><p>Login here</p>
				</div>
				
					<%
					Msg m=(Msg)session.getAttribute("msg");
					if(m!=null){
					%>
					<div class="alert <%=m.getCssClass() %>" role="alert">
					<%=m.getContent() %>
					</div>
					<%
					session.removeAttribute("msg");
					}
					%>

					<div class="card-body">
					
						<form action="LoginServlet" method="post">					
							<div class="form-group">
								<label for="email">Email address</label> <input
									type="email" class="form-control" id="email" name="email" required>
							</div>
							<div class="form-group">
								<label for="password">Password</label> <input
									type="password" class="form-control" id="password" name="password" required>
							</div>
							<button type="submit" class="btn primary-background ">Submit</button>
							
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<%@include file="footer.jsp"%>
