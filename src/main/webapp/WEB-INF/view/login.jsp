<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper title="Login" bodyheader="Login">
    <jsp:attribute name="script">
        <script src="${pageContext.request.contextPath}/resources/assets/js/pages/pass-addon.init.js"></script>
    </jsp:attribute>

    <jsp:attribute name="style">

    </jsp:attribute>

    <jsp:body>
        <div class="auth-full-page-content d-flex p-sm-5 p-4">
            <div class="w-100">
                <div class="d-flex flex-column h-100">
                    <div class="mb-4 mb-md-5 text-center">
                        <a href="#" class="d-block auth-logo">
                            <img src="${pageContext.request.contextPath}/resources/assets/images/logo.png" alt="" height="28"> <span class="logo-txt"></span>
                        </a>
                    </div>
                    <div class="auth-content my-auto">
                        <div class="text-center">
                            <h5 class="mb-0">Welcome Back !</h5>
                            <p class="text-muted mt-2">Sign in to continue.</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/j_login" method='POST' class="mt-4 pt-2" >
                            <c:if test="${error ne ''}">
                                <div class="alert mb-4" role="alert">
                                    <strong><code>${error}</code></strong>
                                </div>
                            </c:if>
                            <div class="form-floating form-floating-custom mb-4">
                                <input name="username" type="text" class="form-control" id="input-username" placeholder="Enter User Name">
                                <label for="input-username">Username</label>
                                <div class="form-floating-icon">
                                    <i data-feather="users"></i>

                                </div>
                            </div>

                            <div class="form-floating form-floating-custom mb-4 auth-pass-inputgroup">
                                <input name="password" type="password" class="form-control pe-5" id="password-input" placeholder="Enter Password">

                                <button type="button" class="btn btn-link position-absolute h-100 end-0 top-0" id="password-addon">
                                    <i class="mdi mdi-eye-outline font-size-18 text-muted"></i>
                                </button>
                                <label for="input-password">Password</label>
                                <div class="form-floating-icon">
                                    <i data-feather="lock"></i>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col">
                                    <div class="form-check font-size-15">
                                        <input class="form-check-input" type="checkbox" id="remember-check">
                                        <label class="form-check-label font-size-13" for="remember-check">
                                            Remember me
                                        </label>
                                    </div>  
                                </div>

                            </div>
                            <div class="mb-3">
                                <button class="btn btn-primary w-100 waves-effect waves-light" type="submit">Log In</button>
                            </div>
                        </form>

                        <!--                                <div class="mt-4 pt-2 text-center">
                                                            <div class="signin-other-title">
                                                                <h5 class="font-size-14 mb-3 text-muted fw-medium">- Sign in with -</h5>
                                                            </div>
                        
                                                            <ul class="list-inline mb-0">
                                                                <li class="list-inline-item">
                                                                    <a href="javascript:void()"
                                                                        class="social-list-item bg-primary text-white border-primary">
                                                                        <i class="mdi mdi-facebook"></i>
                                                                    </a>
                                                                </li>
                                                                <li class="list-inline-item">
                                                                    <a href="javascript:void()"
                                                                        class="social-list-item bg-info text-white border-info">
                                                                        <i class="mdi mdi-twitter"></i>
                                                                    </a>
                                                                </li>
                                                                <li class="list-inline-item">
                                                                    <a href="javascript:void()"
                                                                        class="social-list-item bg-danger text-white border-danger">
                                                                        <i class="mdi mdi-google"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>-->

                        <div class="mt-5 text-center">
                            <p class="text-muted mb-0">Don't have an account ? <a href="${pageContext.request.contextPath}/register"
                                                                                  class="text-primary fw-semibold"> Signup now </a> </p>
                        </div>
                    </div>
                    <div class="mt-4 mt-md-5 text-center">
                        <p class="mb-0">© <script>document.write(new Date().getFullYear())</script> salesfuse.app</p>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:wrapper>