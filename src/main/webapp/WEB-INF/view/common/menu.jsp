<%-- 
    Document   : menu
    Created on : May 8, 2017, 11:21:59 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="vertical-menu">

    <div data-simplebar class="h-100">

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title" data-key="t-menu">Wizard Menu</li>
                <!--                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="edit"></i>
                                        <span data-key="t-ecommerce">Create</span>
                                    </a>-->
                <!--<ul class="sub-menu" aria-expanded="false">-->
                <li class="${play_create_menu}">
                    <a href="${pageContext.request.contextPath}/play/list">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Play</span>
                    </a>
                </li>
                <li class="${role_create_menu}">
                    <a href="${pageContext.request.contextPath}/role/list">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Role</span>
                    </a>
                </li>
                <li class="${proof_create_menu}">
                    <a href="${pageContext.request.contextPath}/proof/list">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Proof</span>
                    </a>
                </li>
                <li class="${industry_create_menu}">
                    <a href="${pageContext.request.contextPath}/industry/list">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Industry</span>
                    </a>
                </li>
                <li class="${product_create_menu}">
                    <a href="${pageContext.request.contextPath}/product/list">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Product</span>
                    </a>
                </li>
                <li class="${message_create_menu}">
                    <a href="${pageContext.request.contextPath}/message/list">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Message</span>
                    </a>
                </li>

                <li class="menu-title" data-key="t-menu">Email Wizard</li>
                <li class="${play_create_menu}">
                    <a href="${pageContext.request.contextPath}/email/home">
                        <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                        <span data-key="t-dashboard">Create Email</span>
                    </a>
                </li>

                <li class="menu-title" data-key="t-menu">User Management</li>
                <li>
                    <a href="javascript: void(0);" class="has-arrow">
                        <i data-feather="user"></i>
                        <span data-key="t-ecommerce">User</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li class="${play_create_menu}">
                            <a href="${pageContext.request.contextPath}/user/create">
                                <span class="badge rounded-pill bg-soft-success text-success float-end"></span>
                                <span data-key="t-dashboard">Create User</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>


        </div>
        <!-- Sidebar -->
    </div>
</div>