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
                                <h4 class="mb-sm-0 font-size-18">Proof Details</h4>
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
                                                    <label for="example-text-input" class="form-label">What is the name of this proof?</label>
                                                    <input name="category" class="form-control" type="text" value="${proof.proofName}"
                                                           id="example-text-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-search-input" class="form-label">What is the name of the person's organization?</label>
                                                    <input name="domain" class="form-control" type="text" value="${proof.proofOrganization}" id="example-search-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-email-input" class="form-label">What is the main point shared by the person providing the proof?</label>
                                                    <input name="model" class="form-control" type="text" value="${proof.proofImpact}"
                                                           id="example-email-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">What type of proof is this?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${proof.proofType}"
                                                           id="example-url-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">What product does this proof align to?</label>
                                                    <input name="category" class="form-control" type="text" value="${proof.productAlignment}"
                                                           id="example-text-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-search-input" class="form-label">What is the title of the person providing the proof?</label>
                                                    <input name="domain" class="form-control" type="text" value="${proof.proofTitle}" id="example-search-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-email-input" class="form-label">What altitude level is the person providing the proof?</label>
                                                    <input name="model" class="form-control" type="text" value="${proof.proofAltitude}"
                                                           id="example-email-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">What do you want to share for proof?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${proof.proofContent}"
                                                           id="example-url-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">Where does this proof reside?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${proof.proofLink}"
                                                           id="example-url-input">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="example-url-input" class="form-label">Is this a referenceable account you want to emphasize with your buyers?</label>
                                                    <input name="vendor" class="form-control" type="text" value="${proof.proofReferenceableAccount}"
                                                           id="example-url-input">
                                                </div>

                                            </div>
                                            <div>
                                                <div class="col-lg-10">
                                                    <a href="${pageContext.request.contextPath}/proof/download?id=${proof.id}"><input type="button" class="btn btn-success inner" value="Download Attachment"/></a>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mt-3 mt-lg-0">
                                                <div class="card-body">
                                                    <c:forEach items="${proof.narrations}" var="result">
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