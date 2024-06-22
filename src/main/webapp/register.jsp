<%@include file="base.jsp"%>

<main class="d-flex align-items-center">

	<div class="container mt-4">

		<div class="col-md-4 offset-md-4">
			<div class="card">

				<div class="card-header primary-background text-white text-center">
					<span class="fa fa-user-circle fa-3x"></span>
					<p>Register here</p>
				</div>

				<div class="card-body">
				
					<form action="RegisterServlet" method="post" id="rform">

						<div class="form-group">
							<label for="name">Username</label> <input type="text"
								class="form-control" name="name" id="name" >
						</div>

						<div class="form-group">
							<label for="email">Email</label> <input type="email"
								class="form-control" id="email" name="email">
						</div>

						<div class="form-group">
							<label for="password">Enter Password</label> <input type="password"
								class="form-control" id="password" name="password">
						</div>

						<button type="submit" class="btn primary-background ">Submit</button>
					</form>

				</div>
			</div>
		</div>

	</div>
</main>
<%@include file="footer.jsp"%>

