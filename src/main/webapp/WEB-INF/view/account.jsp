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

<body>
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
                                    <form>
                                        <div class="form-group">
                                            <label for="Current password">Current password</label>
                                            <input type="password" class="form-control" id="Current password">
                                        </div>
                                        <div class="form-group">
                                            <label for="New Password">New password</label>
                                            <input type="password" class="form-control" id="New Password">
                                        </div>
                                        <div class="form-group">
                                            <label for="New Password Confirm">Confirm Password</label>
                                            <input type="password" class="form-control" id="New Password Confirm">
                                        </div>

                                        <div class="text-right pt-1 mb-4 pb-1">
                                            <button class="btn btn-purple mb-3" type="button">Save
                                                password</button>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
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