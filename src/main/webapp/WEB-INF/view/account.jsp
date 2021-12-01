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

<body>
    <div class="hero">
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
                <a class="navbar-brand d-none d-lg-block" href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/assets/img/Logo.png" alt="">
                </a>
                <c:choose>
                    <c:when test="${user != null}">
                        <ul class="navbar-nav">
                            <security:authorize access="hasRole('ADMIN')">
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Create Club</a>
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
                                    <a class="nav-link" href="#">Manage Club</a>
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
    </div>
    <section class="gradient-form" style="background-color: #eee;">
        <div class="container py-4">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-xl-10">
                    <div class="card rounded-3 text-black">
                        <div class="row g-0">
                            <div class="col-lg-4 mx-auto gradient py-md-5 px-0">
                                <nav class="">
                                    <ul class=" nav nav-pills flex-column text-uppercase side-nav">
                                        <li class="nav-item side-nav-item active">
                                            <a class="side-nav-link nav-link px-md-5 py-3" href="#">
                                                <svg class="menu-icon mr-3">
                                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                </svg>
                                                Settings
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
                                        <li class="nav-item side-nav-item">
                                            <a class="side-nav-link nav-link px-md-5 py-3" href="#">
                                                <svg class="menu-icon mr-3">
                                                    <use xlink:href="${pageContext.request.contextPath}/assets/img/icons.svg#icon-settings"></use>
                                                </svg>
                                                My Events
                                            </a>
                                        </li>
                                    </ul>
                                </nav>

                            </div>
                            <div class="col-lg-8 mx-auto">
                                <div class="card-body p-md-5 mx-md-4">
                                    <h3 class="font-weight-bold text-uppercase">YOUR ACCOUNT SETTINGS</h3>
                                    <form:form action="${pageContext.request.contextPath}/user/me" method="POST">
                                        <div class="form-group">
                                            <label for="firstName">First Name</label>
                                            <input class="form-control" name="firstName" id="firstName" value="${user.firstname}">
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name</label>
                                            <input class="form-control" name="lastName" id="lastName" value="${user.lastname}">
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Email address</label>
                                            <input type="email" class="form-control" id="email" name="email"
                                                aria-describedby="emailHelp" value="${user.email}">
                                        </div>
                                        <div class="form-group">
                                            <img src="${pageContext.request.contextPath}/assets/img/users/${user.avatar}" style="width:5rem;height:5rem;"
                                                class="rounded-circle mr-3" alt="">
                                            <label for="photo" class="border-bottom border-dark" role="button">Choose new photo</label>
                                            <input type="file" class="d-none form-control" id="photo">
                                        </div>
                                        <div class="text-right pt-1 mb-4 pb-1">
                                            <button class="btn btn-purple mb-3">Save changes</button>
                                        </div>
                                    </form:form>


                                    <h3 class="font-weight-bold text-uppercase">Password Change</h3>
                                    <form:form action="${pageContext.request.contextPath}/user/updatePassword" method="POST" modelAttribute="crmPassword">
                                        <c:if test="${passwordChangeConfirm != null }">
                                            <span class="alert-success" >${passwordChangeConfirm}</span>
                                        </c:if>
                                        <div class="form-group">
                                            <label for="oldPassword">Current password</label>
                                            <form:password path="oldPassword" cssClass="form-control" id="oldPassword"/>
                                            <form:errors path="oldPassword" cssClass="form-error" />
                                            <c:if test="${oldPasswordMatch != null }"><span class="form-error">${oldPasswordMatch}</span></c:if>
                                        </div>

                                        <div class="form-group">
                                            <label for="password">New password</label>
                                            <form:password path="password" cssClass="form-control" id="password"/>
                                            <form:errors path="password" cssClass="form-error" />
                                        </div>

                                        <div class="form-group">
                                            <label for="matchingPassword">Confirm password</label>
                                            <form:password path="matchingPassword" cssClass="form-control" id="matchingPassword"/>
                                        </div>

                                        <div class="text-right pt-1 mb-4 pb-1">
                                            <button class="btn btn-purple mb-3" >Save
                                                password</button>
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

    <footer class="bg-color-blue d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
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