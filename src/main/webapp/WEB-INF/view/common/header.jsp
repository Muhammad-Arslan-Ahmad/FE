<%-- 
    Document   : menu
    Created on : May 8, 2017, 11:21:59 PM
    Author     : Asus
--%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Topbar -->
<header id="page-topbar">
    <div class="navbar-header">
        <div class="d-flex">
            <!-- LOGO -->
            <div class="navbar-brand-box">
                <a href="${pageContext.request.contextPath}/play/list" class="logo logo-dark">
                    <span class="logo-sm">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/favicon.png" alt="" height="30">
                    </span>
                    <span class="logo-lg">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/logo.png" alt="" height="24"> <span class="logo-txt"></span>
                    </span>
                </a>

                <a href="${pageContext.request.contextPath}/play/list" class="logo logo-light">
                    <span class="logo-sm">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/logo.png" alt="" height="30">
                    </span>
                    <span class="logo-lg">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/logo.png" alt="" height="24"> <span class="logo-txt"></span>
                    </span>
                </a>
            </div>

            <button type="button" class="btn btn-sm px-3 font-size-16 header-item" id="vertical-menu-btn">
                <i class="fa fa-fw fa-bars"></i>
            </button>

            <!-- App Search-->
<!--            <form action="${pageContext.request.contextPath}/search" method="post" id="searchForm" class="app-search d-none d-lg-block">
                <div class="position-relative">
                    <input name="queryString" id="input_query" value="" type="text" class="form-control" placeholder="Search...">
                    <button class="btn btn-primary" type="submit"><i class="bx bx-search-alt align-middle"></i></button>
                </div>-->
            </form>
        </div>

        <div class="d-flex">

            <div class="dropdown d-inline-block d-lg-none ms-2">
                <button type="button" class="btn header-item" id="page-header-search-dropdown"
                        data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i data-feather="search" class="icon-lg"></i>
                </button>
<!--                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
                     aria-labelledby="page-header-search-dropdown">

                    <form action="${pageContext.request.contextPath}/search" method="post" class="p-3">
                        <div class="form-group m-0">
                            <div class="input-group">
                                <input name="queryString" id="input_query_mob" value="" type="text" class="form-control" placeholder="Search ..." aria-label="Search Result">

                                <button class="btn btn-primary" type="submit"><i class="mdi mdi-magnify"></i></button>
                            </div>
                        </div>
                    </form>
                </div>-->
            </div>

<!--            <div class="dropdown d-none d-sm-inline-block">
                <button type="button" class="btn header-item"
                        data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <img id="header-lang-img" src="${pageContext.request.contextPath}/resources/assets/images/flags/us.jpg" alt="Header Language" height="16">
                </button>
                <div class="dropdown-menu dropdown-menu-end">

                     item
                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="en">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/flags/us.jpg" alt="user-image" class="me-1" height="12"> <span class="align-middle">English</span>
                    </a>
                     item
                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="sp">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/flags/spain.jpg" alt="user-image" class="me-1" height="12"> <span class="align-middle">Spanish</span>
                    </a>

                     item
                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="gr">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/flags/germany.jpg" alt="user-image" class="me-1" height="12"> <span class="align-middle">German</span>
                    </a>

                     item
                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="it">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/flags/italy.jpg" alt="user-image" class="me-1" height="12"> <span class="align-middle">Italian</span>
                    </a>

                     item
                    <a href="javascript:void(0);" class="dropdown-item notify-item language" data-lang="ru">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/flags/russia.jpg" alt="user-image" class="me-1" height="12"> <span class="align-middle">Russian</span>
                    </a>
                </div>
            </div>-->
            <div class="dropdown d-inline-block d-sm-inline-block">
                <button type="button" class="btn header-item" id="mode-setting-btn">
                    <i data-feather="moon" class="icon-lg layout-mode-dark"></i>
                    <i data-feather="sun" class="icon-lg layout-mode-light"></i>
                </button>
            </div>

            

            <div class="dropdown d-inline-block">
                <button type="button" class="btn header-item noti-icon position-relative" id="page-header-notifications-dropdown"
                        data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i data-feather="bell" class="icon-lg"></i>
                    <span class="badge bg-danger rounded-pill" id="unreadId"></span>
                </button>
                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
                     aria-labelledby="page-header-notifications-dropdown">
                    <div class="p-3">
                        <div class="row align-items-center">
                            <div class="col">
                                <h6 class="m-0"> Notifications </h6>
                            </div>
<!--                            <div class="col-auto">
                                <a href="#!" class="small text-reset text-decoration-underline"> Unread (3)</a>
                            </div>-->
                        </div>
                    </div>

                    <div data-simplebar style="max-height: 230px;" id="chatNotificationId"></div>
<!--                    <div class="p-2 border-top d-grid">
                        <a class="btn btn-sm btn-link font-size-14 text-center" href="javascript:void(0)">
                            <i class="mdi mdi-arrow-right-circle me-1"></i> <span>View More..</span> 
                        </a>
                    </div>-->
                </div>
            </div>      

            <!-- go to cart -->
<!--            <div class="dropdown d-inline-block d-sm-inline-block">
                <a href="${pageContext.request.contextPath}/cart/view-cart">
                    <button type="button" class="btn header-item" id="mode-setting-btn">
                        <i data-feather="shopping-cart"></i>
                    </button>
                </a>
            </div>-->
                                
<!--            <div class="dropdown d-inline-block">
                <button type="button" class="btn header-item right-bar-toggle me-2">
                    <i data-feather="settings" class="icon-lg"></i>
                </button>
            </div>-->

            <div class="dropdown d-inline-block">
                <button type="button" class="btn header-item bg-soft-light border-start border-end" id="page-header-user-dropdown"
                        data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                    <span class="d-inline-block d-xl-inline-block ms-1 fw-medium">${pageContext.request.userPrincipal.name}</span>
                    <i class="mdi mdi-chevron-down d-inline-block d-xl-inline-block"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-end">
                    <!-- item-->
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="mdi mdi-face-profile font-size-16 align-middle me-1"></i> Profile</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword"><i class="mdi mdi-key font-size-16 align-middle me-1"></i> Change Password</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/signout"><i class="mdi mdi-logout font-size-16 align-middle me-1"></i> Logout</a>

                </div>
            </div>
        </div>
    </div>
</header>