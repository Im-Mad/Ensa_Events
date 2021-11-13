<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert Form</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/add-customer-style.css" />
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- Reference Bootstrap files -->
		<link rel="stylesheet"
			 href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
		
		<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
			<style>
			.error {color:red}
		</style>
	</head>
	
	<body>
		<div id="wrapper">
			<div id="header">	
				<h2>CRM - Customer Relation Manager</h2>
			</div>
			<c:if test="${param.success != null}">            
				<div class="alert alert-success col-xs-offset-1 col-xs-10">
					You have uploaded your data successfully.
				</div>
			</c:if>
			<div id="container">
				<h3>Save Customer</h3>
				<form:form action="${pageContext.request.contextPath}/porcessFormUpdate" modelAttribute="currentUser" method="POST">
				<form:hidden path="id"/>				
						<!-- First name -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<form:errors path="username" cssClass="error" />
							<form:input path="username" class="form-control" />
						</div>
						
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<form:errors path="firstname" cssClass="error" />
							<form:input path="firstname" class="form-control" />
						</div>
						
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<form:errors path="lastname" cssClass="error" />
							<form:input path="lastname" class="form-control" />
						</div>
						
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<form:errors path="password" cssClass="error" />
							<form:input path="password" class="form-control" />
						</div>
						
						<!-- Last name -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<form:errors path="email" cssClass="error" />
							<form:input path="email" class="form-control" />
						</div>
						
						<!-- Email -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<form:errors path="avatar" cssClass="error" />
							<form:input path="avatar" class="form-control" />
						</div>
						
						<!-- Register Button -->
						<div style="margin-top: 10px" class="form-group">						
							<div class="col-sm-6 controls">
								<button type="submit" class="btn btn-primary">Register</button>
							</div>
						</div>
				</form:form>
				
				<div style="clear; both;"></div>
			</div>
		</div>
	</body>
</html>