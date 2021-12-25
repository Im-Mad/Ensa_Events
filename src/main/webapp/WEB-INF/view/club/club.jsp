<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<jsp:useBean id="user" scope="session" type="ma.ensaevents.entity.User"/>

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
<body>
    <header class="footer-color">
        <nav class="navbar navbar-expand-lg navbar-dark ">

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
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/login" class="btn  btn-lg btn-outline-light round btn-header " role="button"
                                   aria-disabled="true">Sign In</a>
                            </li>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>
    </header>

    <div class="text-center bg-main d-flex justify-content-center ">
        <div style="background-image:url('${pageContext.request.contextPath}/assets/img/clubs/cover_photos/${club.coverPhoto}')" class="cover-img" alt="club cover image">

        </div>
    </div>
    <div class="px-md-5 px-3">
        <div class="row">
            <div class="col-8 row align-items-center">
                <img src="${pageContext.request.contextPath}/assets/img/clubs/logos/${club.logo}" height="40" width="40" class="m-2 rounded-circle" alt="" >
                <h3 class="mb-0">${club.name}</h3>
            </div>
            <div class="col-4  d-flex justify-content-start justify-content-md-end pt-2">
                <div class="">

                    <button class="btn btn-light ">
                        <svg class="btn-icon">
                            <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-plus"></use>
                        </svg>
                        Join
                    </button>
                    <button class="btn btn-light">
                        <svg class="btn-icon">
                            <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-share-2"></use>
                        </svg>
                        Share
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="px-md-4 p-0 pb-3">
        <div class="row">
            <div class="col-md-8 col-lg-9 col-12 px-4 px-md-3 px-lg-4">
                <div class="bg-white mt-4 p-4 rounded">
                    <h3>About</h3>
                    <p>
                        ${club.description}
                    </p>
                </div>
                <div class="bg-white mt-4 p-4 rounded">
                    <h3>Events</h3>
                    <div class="row">
                        <c:forEach items="${club.events}" var="event">
                            <div class="col-12 col-sm-6 col-lg-6 col-md-12">
                                <div class=" card rounded mx-0 mx-sm-1 mx-md-2 mb-3">
                                    <div class="card-img-box">
                                        <img class="card-img-top"
                                             src="${pageContext.request.contextPath}/assets/img/events/${event.coverPhoto}"
                                             alt="${event.name}">
                                    </div>
                                    <div class="card-body row">
                                        <div class="col-6">
                                            <h5 class="card-title">${event.name}</h5>
                                            <p class="card-text">${event.date}</p>
                                        </div>
                                        <div class="col-6 text-right">
                                            <a href="#" class="btn btn-purple">Participate</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>
            <div class="px-4 px-md-0 py-4 col-md-4 col-lg-3  col-sm-12 ">
                <div class="bg-white p-4 rounded">
                    <h3>Members</h3>
                    <div class="d-flex  justify-content-center py-4">
                        <div class="d-flex flex-column align-items-center">
                            <h2 class="">${club.members.size()}</h2>
                            <h4 class="text-uppercase">Member</h4>
                        </div>

                    </div>
                    <div class="overflow-auto border-light border rounded users px-2">
                        <c:forEach items="${club.members}" var="member">
                            <div class="user d-flex align-items-center">
                                <img class="user-img m-2" src="${pageContext.request.contextPath}/assets/img/users/${member.avatar}" alt=""/>
                                <span class="user-name">${member.firstname} ${member.lastname}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="d-flex flex-wrap justify-content-between mt-auto align-items-center py-2 footer-color">
        <p class="col-md-4 mb-0 text-white">&copy; 2021 Company, Inc</p>

        <a href="${pageContext.request.contextPath}/"
           class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
            <img class="bi me-2" height="40" src="${pageContext.request.contextPath}/assets/img/Logo.png" alt=""/>
        </a>
        <ul class="nav col-md-4 justify-content-end .text-white">
            <li class="nav-item"><a href="#" class="nav-link px-2 text-white">Home</a></li>
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