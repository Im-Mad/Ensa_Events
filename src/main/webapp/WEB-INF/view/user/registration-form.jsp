<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
			href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
			rel="stylesheet">
</head>

<body class="hero">

	<div >
		<nav class="navbar navbar-expand-lg navbar-light bg-transparent ">

			<!--  Show this only on mobile to medium screens  -->
			<a class="navbar-brand d-lg-none " href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/assets/img/Logo.png" alt="Header Logo"></a>

			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggle"
					aria-controls="navbarToggle" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!--  Use flexbox utility classes to change how the child elements are justified  -->
			<div class="collapse navbar-collapse justify-content-between px-3" id="navbarToggle">

				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link header-typography" href="${pageContext.request.contextPath}/">Home </a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">All Events</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">All Clubs</a>
					</li>
				</ul>


				<!--   Show this only lg screens and up   -->
				<a class="navbar-brand d-none d-lg-block" href="${pageContext.request.contextPath}/">
					<img src="${pageContext.request.contextPath}/assets/img/Logo.png" alt="">
				</a>
				<c:choose>
					<c:when test="${user != null}">
						<ul class="navbar-nav">
							<security:authorize access="hasRole('ADMIN')">
								<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/club/create">Create Club</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="#">Manage Users</a>
								</li>
							</security:authorize>
							<security:authorize access="hasRole('MANAGER')">
								<li class="nav-item">
									<a class="nav-link" href="#">Create Event</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/club/update">Manage Club</a>
								</li>
							</security:authorize>
							<security:authorize access="hasRole('USER')">
								<li class="nav-item">
									<a class="nav-link" href="#">My Events</a>
								</li>
							</security:authorize>
							<li class="nav-item">
								<a class="nav-link p-0" href="${pageContext.request.contextPath}/user/me">
									<img class="rounded-circle mx-4" height="40" width="40" src="${pageContext.request.contextPath}/assets/img/users/${user.avatar}">
								</a>
							</li>
							<li class="nav-item">
								<form:form action="${pageContext.request.contextPath}/logout"
										   method="POST">
									<input type="submit" class="btn  btn-lg btn-outline-danger round btn-header" value="Log out" />
								</form:form>
							</li>
						</ul>
					</c:when>
					<c:otherwise >
						<ul class="navbar-nav">
							<li class="nav-item pr-2">
								<a class="nav-link active" href="${pageContext.request.contextPath}/register">Sign Up</a>
							</li>
							<li class="nav-item">
								<a href="${pageContext.request.contextPath}/login" class="btn  btn-lg btn-outline-dark round btn-header" role="button"
								   aria-disabled="true">Sign In</a>
							</li>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</nav>
	</div>

	<section>
		<div class="container py-4">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-xl-8">
					<div class="text-black">
						<div class="row g-0">
							<div class="col-lg-10 mx-auto form-background">
								<div class="card-body px-md-5 mx-md-4">
									<form:form action="${pageContext.request.contextPath}/register" method="POST"
													 modelAttribute="newUser">
										<h3 class="font-weight-bold text-uppercase">Create your account</h3>

										<div class="form-group">
											<label for="userName">Username</label>
											<form:input path="userName" cssClass="form-control" id="userName"/>
											<form:errors path="userName" cssClass="form-error" />
											<c:if test="${registrationError != null }"><span class="form-error">${registrationError}</span></c:if>
										</div>

										<div class="form-group">
											<label for="firstName">First Name</label>
											<form:input path="firstName" cssClass="form-control" id="firstName"/>
											<form:errors path="firstName" cssClass="form-error" />
										</div>

										<div class="form-group">
											<label for="lastName">Last Name</label>
											<form:input path="lastName" cssClass="form-control" id="lastName"/>
											<form:errors path="lastName" cssClass="form-error" />
										</div>

										<div class="form-group">
											<label for="email">Email</label>
											<form:input path="email" cssClass="form-control" id="email"/>
											<form:errors path="email" cssClass="form-error" />
										</div>

										<div class="form-group">
											<label for="password">Password</label>
											<form:password path="password" cssClass="form-control" id="password"/>
											<form:errors path="password" cssClass="form-error" />
										</div>

										<div class="form-group">
											<label for="matchingPassword">Password Confirm</label>
											<form:password path="matchingPassword" cssClass="form-control" id="matchingPassword"/>
											<form:errors path="matchingPassword" cssClass="form-error" />
										</div>

										<!-- Register Button -->
										<div class="text-center pt-1 mb-4 pb-1">
											<input type="submit" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" value="Register" />
										</div>

										<div class="d-flex align-items-center justify-content-center">
											<p class="mb-0 mr-2">Have an account?</p>
											<a href="${pageContext.request.contextPath}/login" type="button" class="btn btn-outline-danger">Log In</a>
										</div>

									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<footer class="d-flex flex-wrap justify-content-between align-items-center py-3">
		<p class="col-md-4 mb-0 text-white">&copy; 2021 Company, Inc</p>

		<a href="${pageContext.request.contextPath}/"
		   class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
			<img class="bi me-2" height="40" src="${pageContext.request.contextPath}/assets/img/Logo.png" alt=""/>
		</a>
		<ul class="nav col-md-4 justify-content-end .text-white">
			<li class="nav-item"><a href="#" class="nav-link px-2 text-white">Home</a></li>
			<li class="nav-item"><a href="#" class="nav-link px-2 text-white">Features</a></li>
			<li class="nav-item"><a href="#" class="nav-link px-2 text-white">Pricing</a></li>
			<li class="nav-item"><a href="#" class="nav-link px-2 text-white">FAQs</a></li>
			<li class="nav-item"><a href="#" class="nav-link px-2 text-white">About</a></li>
		</ul>
	</footer>

	<!-- JQuery -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.js"></script>
	<!-- Bootstrap -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.js"></script>

	<!-- Main script -->
	<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>

</html>