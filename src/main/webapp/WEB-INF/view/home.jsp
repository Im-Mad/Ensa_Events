<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<body>

    <div class="hero-home">
        <nav class="navbar navbar-expand-lg navbar-dark bg-transparent ">

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
                        <a class="nav-link active header-typography" href="${pageContext.request.contextPath}/">Home </a>
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
                    <c:when test="${seuser != null}">
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
                                    <img class="rounded-circle mx-4" height="40" width="40" src="${pageContext.request.contextPath}/assets/img/users/${user.avatar}" alt="" />
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
                            <a href="${pageContext.request.contextPath}/login" class="btn  btn-lg btn-outline-light round btn-header" role="button"
                               aria-disabled="true">Sign In</a>
                        </li>
                    </ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <div class="container-fluid jumbotron mb-0" style="height: 300px;">
            <h1 class="heading-title"><span class="heading-title_white">ENSA</span>EVENTS</h1>
            <h4 class="heading-subtitle">Keep track of all ensa's events</h4>
        </div>
        <div class="container search-bar position-absolute shadow-sm">
            <form class="row">
                <div class="col-md-4 col-12 px-1 d-flex align-items-center justify-content-center padding-smallSize">
                    <select class="custom-select w-75 text-center" id="inputGroupSelect01">
                        <option selected style="font-size: 1rem;">Select Club</option>
                        <c:forEach items="${clubs}" var="club">
                            <option>${club.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4 col-12 px-1 d-flex align-items-center justify-content-center padding-smallSize">
                    <input id="demo-mobile-picker-input" class="custom-select w-75 text-center" placeholder="Date Range" required />
                </div>
                <div class="col-md-4 col-12 px-1 d-flex align-items-center justify-content-center padding-smallSize">
                    <button type="button" class="btn btn-purple rounded-pill w-75">Filter Events</button>
                </div>
            </form>
        </div>
    </div>
    <div class="py-5"></div>
    <div class="container-fluid" style="height: 280px;">
        <!-- Swiper -->
        <div class="swiper events" id="events">
            <h1 class="font-weight-bold mb-3">Upcoming Events</h1>
            <div class="swiper-pagination"></div>
            <div class="swiper-wrapper  mb-5">

                <c:forEach items="${events}" var="event">
                    <div class="swiper-slide">
                        <div class="card rounded">
                            <div class="card-img-box">
                                <img class="card-img-top" src="${pageContext.request.contextPath}/assets/img/events/${event.coverPhoto}" alt="Card image cap">
                            </div>
                            <div class="card-body row">
                                <div class="col-8">
                                    <h5 class="card-title">${event.name}</h5>
                                    <p class="card-text"
                                        <fmt:formatDate value="${event.date}" type="date" pattern="EE, MM DD YYYY"/>
                                    </p>
                                </div>
                                <div class="col-4 text-right">
                                    <a href="#" class="btn btn-purple">Participate</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>
    <div class="py-5"></div>
    <div class="container-fluid">
        <div class="swiper clubs" id="clubs">

            <h1 class="font-weight-bold mb-3">Clubs</h1>
            <div class="swiper-wrapper  mb-5">
                <c:forEach items="${clubs}" var="club">
                    <div class="swiper-slide">
                        <a class="card-img-box" href="${pageContext.request.contextPath}/club/${club.name}">
                            <img class="rounded-circle" style="width:100px" src="${pageContext.request.contextPath}/assets/img/clubs/logos/${club.logo}" alt="${club.name}">
                        </a>
                        <div class="d-flex forever justify-content-center">
                            ${club.name}
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-pagination"></div>
        </div>

    </div>
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-2 border-top footer-color">
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