<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Change Password" bodyheader="Change Password">
    <jsp:attribute name="script">
        <script>

            function confirmSubmit() {
                return ConfirmDialog("Want to change password?");
            }

            function ConfirmDialog(message) {
                if (confirm(message)) {
                    return true;
                } else {
                    return false;
                }
            }


        </script>
    </jsp:attribute>

    <jsp:attribute name="style">
        <style>

        </style>
    </jsp:attribute>

    <jsp:body>
        <div class="main-content">

            <div class="page-content">
                <div class="container-fluid">

                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0 font-size-18">Change Password</h4>

                            </div>
                        </div>
                    </div>
                    <!-- end page title -->

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <div>
                                        
                                        <c:if test="${msg ne ''}">
                                            <div class="alert mb-4" role="alert">
                                                <strong>${msg}</strong>
                                            </div>
                                       </c:if>
                                        <c:if test="${errMsg ne ''}">
                                            <div class="alert mb-4" role="alert">
                                                <strong><code>${errMsg}</code></strong>
                                            </div>
                                       </c:if>
                                        <form id="pristine-valid-example" novalidate action="${pageContext.request.contextPath}/changePassword" method='POST'>
                                            
                                            <div class="row">
                                                <div class="col-xl-4 col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label>Old Password</label>
                                                        <input name="oldPassword" type="password" id="pwd" required
                                                            data-pristine-required-message="Please Enter a password" placeholder="Enter your password"
                                                            class="form-control" />
                                                    </div>
                                                </div>
                                                <div class="col-xl-4 col-md-6">
                                                    <div  class="form-group mb-3">
                                                        <label>Password</label>
                                                        <input name="newPassword" type="password" id="pwd" required
                                                            data-pristine-required-message="Please Enter a password" placeholder="Enter your password"
                                                            class="form-control" />
                                                    </div>
                                                </div>
                                                <div class="col-xl-4 col-md-6">
                                                    <div class="form-group mb-3">
                                                        <label>Retype password</label>
                                                        <input name="confirmPassword" type="password" data-pristine-equals="#pwd"
                                                        placeholder="enter your password"
                                                            data-pristine-equals-message="Passwords don't match"
                                                            class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- end row -->

                                            <div class="form-group">
                                                <button type="submit" onclick="return confirmSubmit();" class="btn btn-primary">Change Password</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->

                </div> <!-- container-fluid -->
            </div>
            <!-- End Page-content -->
            <jsp:include page="../common/footer.jsp" flush="true"/>
        </div>
    </jsp:body>
</t:wrapper_dashboard>