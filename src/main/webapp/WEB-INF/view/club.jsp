<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<div class="text-center bg-main d-flex justify-content-center">
    <img src="${pageContext.request.contextPath}/assets/img/${club.cover_photo}" class="cover-img">
</div>
<div class="py-3 px-md-5 px-3 border-top">
    <div class="row">
        <div class="col-md-8 col-12 row align-items-center">
            <img src="${pageContext.request.contextPath}/assets/img/${club.logo}" heigh="40" width="40" class="m-2">
            <h3 class="mb-0">${club.name}</h3>
        </div>
        <div class="col-md-4 col-12 d-flex justify-content-start justify-content-md-end">
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

<div class="px-md-4 p-0 pb-3 bg-main">
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
                                        <a href="#" class="btn btn-primary">Participate</a>
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
                        <h2 cla>300</h2>
                        <h4 class="text-uppercase">Member</h4>
                    </div>

                </div>
                <div class="overflow-auto border-light border rounded users px-2">
                    <%-- FIXME club.members --%>
                    <c:forEach items="${ null}" var="member">
                        <div class="user d-flex align-items-center">
                            <img class="user-img m-2" src="${pageContext.request.contextPath}/assets/img/users/${member.avatar}"/>
                            <span class="user-name">${member.firstname} ${member.lastname}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
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