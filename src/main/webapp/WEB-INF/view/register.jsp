<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper title="Registation" bodyheader="Registration">
    <jsp:attribute name="script">
        <script src="${pageContext.request.contextPath}/resources/assets/js/pages/validation.init.js"></script>
        
        <script>
            function checkConfirmPassword(){
                var orig = $("#input-password").val();
                var conf = $("#input-confirmpassword").val();
                if(orig === conf){
                    return true;
                }
                alert("Confirm password doesn't match");
                return false;
            }
        </script>
        
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
                                    <h5 class="mb-0">Register Account</h5>
                                    <p class="text-muted mt-2">Get your free Salesfuse account now.</p>
                                </div>
                                <form action="${pageContext.request.contextPath}/register" method='POST' class="needs-validation mt-4 pt-2" novalidate>
                                    <c:if test="${msg ne ''}">
                                        <div class="alert mb-4" role="alert">
                                            <strong>${msg}</strong>
                                        </div>
                                   </c:if>
                                    <div class="form-floating form-floating-custom mb-4">
                                        <input name="firstName" type="text" class="form-control" id="input-firstname" placeholder="Enter First Name" required>
                                        <div class="invalid-feedback">
                                            Please Enter First Name
                                        </div> 
                                        <label for="input-username">First Name</label>
                                        <div class="form-floating-icon">
                                            <i data-feather="users"></i>
                                        </div>
                                    </div>
                                    
                                    <div class="form-floating form-floating-custom mb-4">
                                        <input name="lastName" type="text" class="form-control" id="input-lastname" placeholder="Enter Last Name" required>
                                        <div class="invalid-feedback">
                                            Please Enter Last Name
                                        </div> 
                                        <label for="input-username">Last Name</label>
                                        <div class="form-floating-icon">
                                            <i data-feather="users"></i>
                                        </div>
                                    </div>

                                    <div class="form-floating form-floating-custom mb-4">
                                        <input name="email" type="email" class="form-control" id="input-email" placeholder="Enter Email" required>
                                        <div class="invalid-feedback">
                                            Please Enter Email
                                        </div> 
                                        <label for="input-email">Email</label>
                                        <div class="form-floating-icon">
                                            <i data-feather="mail"></i>
                                        </div>
                                    </div>

                                    <div class="form-floating form-floating-custom mb-4">
                                        <input name="username" type="text" class="form-control" id="input-username" placeholder="Enter User Name" required>
                                        <div class="invalid-feedback">
                                            Please Enter Username
                                        </div> 
                                        <label for="input-username">Username</label>
                                        <div class="form-floating-icon">
                                            <i data-feather="users"></i>
                                        </div>
                                    </div>

                                    <div class="form-floating form-floating-custom mb-4">
                                        <input name="password" type="password" class="form-control" id="input-password" placeholder="Enter Password" required>
                                        <div class="invalid-feedback">
                                            Please Enter Password
                                        </div> 
                                        <label for="input-password">Password</label>
                                        <div class="form-floating-icon">
                                            <i data-feather="lock"></i>
                                        </div>
                                    </div>
                                    
                                    
                                    <div class="form-floating form-floating-custom mb-4">
                                        <input type="password" class="form-control" id="input-confirmpassword" placeholder="Enter Password" required>
                                        <div class="invalid-feedback">
                                            Please Confirm Password
                                        </div> 
                                        <label for="input-password">Confirm Password</label>
                                        <div class="form-floating-icon">
                                            <i data-feather="lock"></i>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <p class="mb-0">By registering you agree to the Salesfuse <a href="#" class="text-primary">Terms of Use</a></p>
                                    </div>
                                    <div class="mb-3">
                                        <button class="btn btn-primary w-100 waves-effect waves-light" type="submit" onclick="return checkConfirmPassword();">Register</button>
                                    </div>
                                </form>

<!--                                <div class="mt-4 pt-2 text-center">
                                    <div class="signin-other-title">
                                        <h5 class="font-size-14 mb-3 text-muted fw-medium">- Sign up using -</h5>
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
                                    <p class="text-muted mb-0">Already have an account ? <a href="${pageContext.request.contextPath}/"
                                            class="text-primary fw-semibold"> Login </a> </p>
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