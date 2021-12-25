<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/swiper-bundle.min.css"/>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
</head>

<body class="hero d-flex flex-column min-vh-100">

<header class="navbar navbar-expand-lg navbar-dark bg-transparent ">

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
                <a class="nav-link" href="${pageContext.request.contextPath}/event/all">All Events</a>
            </li>
        </ul>


        <!--   Show this only lg screens and up   -->
        <a class="navbar-brand d-none d-lg-block header-logo" href="${pageContext.request.contextPath}/">
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/manage">Manage Users</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasRole('MANAGER')">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/event/create">Create Event</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/club/update">Manage Club</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasRole('USER')">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/myEvents">My Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/myClubs">My Clubs</a>
                        </li>
                    </security:authorize>
                    <li class="nav-item">
                        <a class="nav-link p-0" href="${pageContext.request.contextPath}/user/me">
                            <img class="rounded-circle mx-4" height="40" width="40" src="${pageContext.request.contextPath}/assets/img/users/${user.avatar}" alt="">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">Sign Up</a>
                    </li>
                    <li class="nav-item active">
                        <a href="${pageContext.request.contextPath}/login" class="btn  btn-lg btn-outline-light round btn-header " role="button"
                           aria-disabled="true">Sign In</a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</header>

    <section class="bg-transparent" >
        <div class="container py-4">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-12 col-sm-12 col-md-10 col-lg-8">
                    <div class="text-black bg-transparent">
                        <div class="p-0 col-12 col-sm-12 col-md-10 col-lg-8 mx-auto">
                            <div class="py-4 form-gp-header text-center">
                                <h4 style="font-style: italic">Ensa <strong class="text-white-50">Event</strong></h4>
                                <h3 class="font-weight-bold text-uppercase">Log into your account</h3>
                            </div>
                            <form action="${pageContext.request.contextPath}/authenticateTheUser" method="POST" class="py-4 px-5 bg-white form-gp-body">
                                <c:if test="${param.error != null}">
                                    <div class="w-100 text-center">
                                        <span class="form-error">Invalid Credentials</span>
                                    </div>
                                </c:if>
                                <c:if test="${param.disabled != null}">
                                    <div class="w-100 text-center">
                                        <span class="form-error">Your account is disabled, please contact the admin</span>
                                    </div>
                                </c:if>
                                <div class="form-gp">
                                    <label for="username">Username</label>
                                    <input type="text" id="username" name="username" >
                                    <svg class="btn-icon">
                                        <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#user-icon"></use>
                                    </svg>
                                </div>
                                <div class="form-gp">
                                    <label for="password">Password</label>
                                    <input type="password" name="password" id="password">
                                    <svg class="btn-icon">
                                        <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#user-icon"></use>
                                    </svg>
                                </div>

                                <div class="text-center pt-1 mb-1 pb-1">
                                    <input type="submit" class="btn btn-purple mb-3" value="Log in" />
                                </div>

                                <div class="d-flex align-items-center justify-content-center">
                                    <p class="mb-0 mr-2">Don't have an account?</p>
                                    <a href="${pageContext.request.contextPath}/register" type="button" class="form-gp-link">Create new</a>
                                </div>

                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

<footer class="d-flex flex-wrap justify-content-between align-items-center mt-auto py-2 footer-color">
    <p class="col-md-4 mb-0 text-white">&copy; 2021 Company, Inc</p>

    <a href="${pageContext.request.contextPath}/"
       class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
        <img class="bi me-2" height="40" src="${pageContext.request.contextPath}/assets/img/Logo.png" alt=""/>
    </a>
    <ul class="nav col-md-4 justify-content-end .text-white">
        <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link px-2 text-white">Home</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/#Contact_us" class="nav-link px-2 text-white">Contact Us</a></li>
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