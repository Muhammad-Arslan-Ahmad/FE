<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Details" bodyheader="Details">
    <jsp:attribute name="script">
        <script>


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
                                <h4 class="mb-sm-0 font-size-18">Role Details</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title -->

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body p-4">
                                    <div class="row">
                                        <div class="col-lg-6">

                                            <div class="mb-3">
                                                <label for="example-text-input" class="form-label">First Name</label>
                                                <input class="form-control" type="text" value="${user.firstName}"
                                                       id="example-text-input">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-search-input" class="form-label">Last Name</label>
                                                <input class="form-control" type="text" value="${user.lastName}" id="example-search-input">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-email-input" class="form-label">User Name</label>
                                                <input class="form-control" type="text" value="${user.userName}"
                                                       id="example-email-input">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-url-input" class="form-label">Email</label>
                                                <input class="form-control" type="text" value="${user.email}"
                                                       id="example-url-input">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-text-input" class="form-label">Company Name</label>
                                                <input class="form-control" type="text" value="${user.companyName}"
                                                       id="example-text-input">
                                            </div>

                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label for="example-text-input" class="form-label">User Photo</label>
                                                <img class="mg-fluid square-switch d-block img-thumbnail" src="data:image/png;base64,${img}">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-text-input" class="form-label">Company Phone</label>
                                                <input class="form-control" type="text" value="${user.companyPhone}"
                                                       id="example-text-input">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-text-input" class="form-label">Company Email</label>
                                                <input class="form-control" type="text" value="${user.companyEmail}"
                                                       id="example-text-input">
                                            </div>
                                            <div class="mb-3">
                                                <label for="example-text-input" class="form-label">Company Web</label>
                                                <input class="form-control" type="text" value="${user.companyWeb}"
                                                       id="example-text-input">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- end col -->
                    </div>
                    <!-- end row -->

                </div> <!-- container-fluid -->
            </div>
            <!-- End Page-content -->
            <jsp:include page="../common/footer.jsp" flush="true"/>
        </div>
    </jsp:body>
</t:wrapper_dashboard>