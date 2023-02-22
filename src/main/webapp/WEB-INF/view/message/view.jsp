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
                                <h4 class="mb-sm-0 font-size-18">Message Details</h4>
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
                                                    <label for="example-text-input" class="form-label">What is the name of this message?</label>
                                                    <input name="category" class="form-control" type="text" value="${message.name}"
                                                           id="example-text-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-search-input" class="form-label">The buyer role</label>
                                                    <input name="domain" class="form-control" type="text" value="${message.messageRoleAlignment}" id="example-search-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-email-input" class="form-label">The product name</label>
                                                    <input name="model" class="form-control" type="text" value="${message.messageProductAlignment}"
                                                           id="example-email-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">Is this a primary value point you want to emphasize with your buyers?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${message.messageValueHighlight}"
                                                           id="example-url-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">Is this a direct message you want to emphasize with your buyers?</label>
                                                    <input name="category" class="form-control" type="text" value="${message.messageVeryImportant}"
                                                           id="example-text-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-search-input" class="form-label">What type question is this?</label>
                                                    <input name="domain" class="form-control" type="text" value="${message.messageQuestionType}" id="example-search-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-email-input" class="form-label">What identity do do you want to give the response to this objection?</label>
                                                    <input name="model" class="form-control" type="text" value="${message.messageResponseName}"
                                                           id="example-email-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">What win them does this align to?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${message.messageWinThemeAlignment}"
                                                           id="example-url-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">The industry name</label>
                                                    <input name="vendor" class="form-control" type="text" value="${message.messageIndustryAlignment}"
                                                           id="example-url-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">Is this a primary problem you want to emphasize with your buyers?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${message.messageProblemCritical}"
                                                           id="example-url-input">
                                                </div>

                                            </div>
                                            <div>
                                                <div class="col-lg-10">
                                                    <a href="${pageContext.request.contextPath}/message/download?id=${message.id}"><input type="button" class="btn btn-success inner" value="Download Attachment"/></a>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mt-3 mt-lg-0">
                                                <div class="card-body">
                                                    <c:forEach items="${message.narrations}" var="result">
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