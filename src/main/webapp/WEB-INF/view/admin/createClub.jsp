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

<body class="hero">
    <header>
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">Sign Up</a>
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
    </header>

    <section>
        <div class="container py-4">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-xl-10">
                    <div class="text-black">
                        <div class="row g-0">
                            <div class="col-lg-4 mx-auto account-navigation-left py-md-5 px-0">
                                <nav class="">
                                    <ul class=" nav nav-pills flex-column text-uppercase side-nav">
                                        <li class="nav-item side-nav-item ">
                                            <a class="side-nav-link nav-link px-md-5 py-3" href="${pageContext.request.contextPath}/user/me">
                                                <svg class="menu-icon mr-3">
                                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                </svg>
                                                Account Settings
                                            </a>
                                        </li>
                                        <li class="nav-item side-nav-item">
                                            <a class="side-nav-link nav-link px-md-5 py-3" href="#">
                                                <svg class="menu-icon mr-3">
                                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                </svg>
                                                My Events
                                            </a>
                                        </li>
                                        <li class="nav-item side-nav-item">
                                            <a class="side-nav-link nav-link px-md-5 py-3" href="#">
                                                <svg class="menu-icon mr-3">
                                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                </svg>
                                                My Clubs
                                            </a>
                                        </li>
                                        <security:authorize access="hasRole('MANAGER')">
                                            <li class="nav-item side-nav-item ">
                                                <a class="side-nav-link nav-link px-md-5 py-3" href="${pageContext.request.contextPath}/club/update">
                                                    <svg class="menu-icon mr-3">
                                                        <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                    </svg>
                                                    Manage Club
                                                </a>
                                            </li>
                                        </security:authorize>
                                        <security:authorize access="hasRole('ADMIN')">
                                            <li class="nav-item side-nav-item active">
                                                <a class="side-nav-link nav-link px-md-5 py-3" href="${pageContext.request.contextPath}/club/create">
                                                    <svg class="menu-icon mr-3">
                                                        <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                    </svg>
                                                    Create Club
                                                </a>
                                            </li>
                                        </security:authorize>
                                        <security:authorize access="hasRole('ADMIN')">
                                            <li class="nav-item side-nav-item ">
                                                <a class="side-nav-link nav-link px-md-5 py-3" href="${pageContext.request.contextPath}/club/create">
                                                    <svg class="menu-icon mr-3">
                                                        <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                    </svg>
                                                    Manage Users
                                                </a>
                                            </li>
                                        </security:authorize>
                                    </ul>
                                </nav>
                            </div>
                            <div class="col-lg-8 mx-auto bg-white account-navigation-right">
                                <div class="card-body p-md-5 mx-md-4">
                                    <h3 class="font-weight-bold text-uppercase">Create a club</h3>
                                    <span class="alert-success" >${creationClubConfirmation}</span>
                                    <form:form action="${pageContext.request.contextPath}/club/create" method="POST" modelAttribute="newClub">
                                        <div class="form-group">
                                            <label for="clubManager">Select a club manager</label>
                                            <form:select path="username" items="${userNames}" class="form-control" id="clubManager"/>
                                        </div>

                                        <div class="form-group">
                                            <label for="clubName">Club Name</label>
                                            <form:input path="clubName" cssClass="form-control" id="clubName"/>
                                            <form:errors path="clubName" cssClass="form-error" />
                                            <c:if test="${registrationError != null }"><span class="form-error">${registrationError}</span></c:if>
                                        </div>

                                        <div class="text-right pt-1 mb-4 pb-1">
                                            <button class="btn btn-purple mb-3" >Create Club</button>
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

    <footer class="d-flex flex-wrap justify-content-between align-items-center py-2 footer-color">
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
    <!-- Swiper JS -->
    <script src="${pageContext.request.contextPath}/assets/js/swiper-bundle.min.js"></script>

    <!-- Main script -->
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>

</html>