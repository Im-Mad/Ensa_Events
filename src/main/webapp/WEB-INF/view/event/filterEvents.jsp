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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mobiscroll.javascript.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/mobiscroll.javascript.min.js"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
</head>

<body class="d-flex flex-column min-vh-100">

    <header class="footer-color">
        <nav class="navbar navbar-expand-lg navbar-dark">

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

    <section class="container-fluid">
        <h5 class="event__page-header pt-2 pr-md-3">Events</h5>
        <div class="row mx-5">
            <c:forEach items="${events}" var="event">
                <div class="card col-12 col-sm-6 col-lg-4 border-0 p-2 event-card my-2">
                    <div class="card__side card__side--front ">

                        <div style="background-image:url('${pageContext.request.contextPath}/assets/img/events/${event.coverPhoto}')" class="card-img" alt="...">
                            &nbsp;<p class="status status-${event.status.label} status-home mr-2">
                                <c:choose>
                                    <c:when test="${event.status.equals(EventStatus.UPCOMING)}">
                                        In ${event.leftDays} Days
                                    </c:when>
                                    <c:otherwise>
                                        ${event.status}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="card-body text-center">
                            <h5 class="card-title">${event.name}</h5>
                        </div>
                    </div>
                    <div class="card__side card__side--back d-flex justify-content-center">
                        <div class="card-body text-black my-auto">
                            <div class="d-flex justify-content-center">
                                <svg class="card-icon mr-2 mb-2">
                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-users"></use>
                                </svg>
                                <span>${event.participants.size()}</span>
                            </div>
                            <div class="d-flex justify-content-center">
                                <svg class="card-icon mr-2  mb-2">
                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-user"></use>
                                </svg>
                                <span>Event By <strong>Club ${event.club.name}</strong></span>
                            </div>
                            <div class="d-flex justify-content-center">
                                <svg class="card-icon mr-2 mb-2">
                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-map-pin"></use>
                                </svg>
                                <span>Location: ${event.location}</span>
                            </div>
                            <div class="d-flex justify-content-center">
                                <svg class="card-icon mr-2 mb-2">
                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-public"></use>
                                </svg>
                                <span>Public - Anyone can attend this event</span>
                            </div>
                            <div class="d-flex justify-content-center">
                                <a  href="${pageContext.request.contextPath}/event/${event.id}" class="btn btn-purple">Show More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="p-2"></div>
    </section>

    <footer class="d-flex flex-wrap justify-content-between mt-auto align-items-center py-2 footer-color">
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
<!-- Swiper JS -->
<script src="${pageContext.request.contextPath}/assets/js/swiper-bundle.min.js"></script>

<!-- Main script -->
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body>

</html>