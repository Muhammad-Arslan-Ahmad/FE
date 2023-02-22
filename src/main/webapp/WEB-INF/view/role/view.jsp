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
                                            <div>
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">What is the role you are defining?</label>
                                                    <input name="category" class="form-control" type="text" value="${role.roleName}"
                                                           id="example-text-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-search-input" class="form-label">What are example job titles for people in this job?</label>
                                                    <input name="domain" class="form-control" type="text" value="${role.jobTitle}" id="example-search-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-email-input" class="form-label">What is the role altitude level?</label>
                                                    <input name="model" class="form-control" type="text" value="${role.roleAltitudeLevel}"
                                                           id="example-email-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">Which role does this role typically report into?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${role.reportingRole}"
                                                           id="example-url-input">
                                                </div>


                                            </div>
                                            <div>
                                                <div class="col-lg-10">
                                                    <a href="${pageContext.request.contextPath}/role/download?id=${role.id}"><input type="button" class="btn btn-success inner" value="Download Attachment"/></a>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mt-3 mt-lg-0">
                                                <div class="card-body">
                                                    <c:forEach items="${role.narrations}" var="result">
                                                        <h8 class="card-title mb-4">${result.narration}</h8>
                                                        <br>
                                                        <br>
                                                    </c:forEach>
                                                </div>
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