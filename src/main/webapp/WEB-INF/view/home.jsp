<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="ma.ensaevents.entity.EventStatus" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/assets/img/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/assets/img/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/assets/img/favicon-16x16.png">
    <title>EnsaEvents | Home</title>
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
                        <a class="nav-link header-typography active" href="${pageContext.request.contextPath}/">Home </a>
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
        </header>

        <div class="container-fluid jumbotron mb-0" style="height: 300px;">
            <h1 class="heading-title"><span class="heading-title_white">ENSA</span>EVENTS</h1>
            <h4 class="heading-subtitle">Keep track of all ensa's events</h4>
        </div>
        <div class="container search-bar position-absolute shadow-sm">
            <form:form action="${pageContext.request.contextPath}/event/filterEvents" method="GET" class="row w-100">
                <div class="col-md-4 col-12 px-1 d-flex align-items-center justify-content-center padding-smallSize">
                    <select class="custom-select w-75 text-center" id="inputGroupSelect01" name="selectedClub">
                        <option selected style="font-size: 1rem;">All Clubs</option>
                        <c:forEach items="${clubs}" var="club">
                            <option>${club.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4 col-12 px-1 d-flex align-items-center justify-content-center padding-smallSize">
                    <input name="dateRange" id="demo-mobile-picker-input" class="custom-select w-75 text-center" placeholder="Date Range" required />
                </div>
                <div class="col-md-4 col-12 px-1 d-flex align-items-center justify-content-center padding-smallSize">
                    <button type="submit" class="btn btn-purple rounded-pill w-75">Filter Events</button>
                </div>
            </form:form>
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
                                <p class="status status-${event.status.label} status-home">
                                    <c:choose>
                                        <c:when test="${event.status.equals(EventStatus.UPCOMING)}">
                                            In ${event.leftDays} Days
                                        </c:when>
                                        <c:otherwise>
                                            ${event.status}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="${pageContext.request.contextPath}/event/${event.id}" style="height:100%; width: 100%; background-image:url('${pageContext.request.contextPath}/assets/img/events/${event.coverPhoto}'); background-size: cover;">
                                    <!--<img class="card-img-top" src="${pageContext.request.contextPath}/assets/img/events/${event.coverPhoto}" alt="Card image cap" >-->
                                </a>
                            </div>
                            <div class="card-body row mr-lg-2">
                                <div class="col-8">
                                    <h5 class="card-title">${event.name}</h5>
                                    <p class="card-text">
                                        <fmt:formatDate value="${event.date}" type="date" pattern="EE, dd MM YYYY"/>
                                    </p>
                                </div>
                                <c:choose>
                                    <c:when test="${event.participants.contains(user)}">
                                        <div class="col-4 text-right">
                                            <a href="${pageContext.request.contextPath}/event/${event.id}/unparticipate" class="btn btn-info">
                                                Participating
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-4 text-right">
                                            <a href="${pageContext.request.contextPath}/event/${event.id}/participate" class="btn btn-purple">
                                                Participate
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
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

    <div  class="container-fluid py-2">
        <h1 class="font-weight-bold mb-1">Find Us</h1>
        <div id="map" style="height: 300px; width: 100%"></div>
    </div>

    <div  class="container-fluid " id="Contact_us">
        <div class="section-email">
            <div class="row h-100 px-5">
                <div class="col-md-6 col-12 col-sm-12 my-auto section-email_container">
                    <h1 class="font-weight-bold mb-3 mt-2"> Contact Us</h1>
                    <form method="POST" id="emailForm">
                        <div class="form-gp form-home w-50">
                            <label for="sendMailName">Name :</label>
                            <input type="text" id="sendMailName" name="sendMailName" required>
                        </div>
                        <div class="form-gp form-home w-50">
                            <label for="sendMailEmail">Email :</label>
                            <input type="email" id="sendMailEmail" name="sendMailEmail" required>
                        </div>
                        <div class="form-gp form-home w-50">
                            <label for="sendMailBody">Message</label>
                            <textarea type="text" id="sendMailBody" name="sendMailBody" rows="10"></textarea>
                        </div>
                        <div class="text-right pt-1 mb-1 pb-1 w-50 form-home_button">
                            <input type="submit" id="submit" class="btn btn-purple mb-3" value="Send" />
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <div class="container-fluid">
        <footer class="d-flex flex-wrap justify-content-between align-items-center py-2 footer-color">
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
    </div>

    <!-- JQuery -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.js"></script>
    <!-- Swiper JS -->
    <script src="${pageContext.request.contextPath}/assets/js/swiper-bundle.min.js"></script>

    <!-- Main script -->
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

    <!-- Email script -->
    <script src="${pageContext.request.contextPath}/assets/js/smtp.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/email.js"></script>

    <!-- Maps script -->
    <script>
        function initMap() {
            var location = { lat: 30.405456690329103 , lng: -9.529829851343472};
            var map = new google.maps.Map(document.getElementById("map"), {
                zoom: 15,
                center: location,
            });

            var marker = new google.maps.Marker({
                position: location,
                map: map
            });
        }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDPdj7MUx_io2Ad_lSBT8MB3kK6zuHeBdE&callback=initMap"></script>
</body>

</html>
