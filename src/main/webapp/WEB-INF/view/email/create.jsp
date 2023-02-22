<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Email Creation" bodyheader="Email Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {

                $("#basic-pills-wizard").bootstrapWizard({
                    tabClass: "nav nav-pills nav-justified"});

//                $('#idType').on('change', function (e) {
//                    var type = $('#idType').val();
//
//                    if (type != null) {
//                        if (type == 'Role') {
//                            $("#idSubject").empty().append("Select Subject", "");
//                            $("#idSubject").append(new Option("Expectation", "expectation"));
//                            $("#idSubject").append(new Option("Impacted Work", "impected_work"));
//                            $("#idSubject").append(new Option("Pain Point", "pain_point"));
//                            $("#idSubject").append(new Option("Pitfalls", "pitfalls"));
//                            $("#idSubject").append(new Option("Possibilities", "possibilities"));
//                            $("#idSubject").append(new Option("Struggles Description", "struggles_description"));
//                            $("#idSubject").append(new Option("Pitfalls", "pitfalls"));
//                        }
//                        if (type == 'Proof') {
//                            $("#idSubject").empty().append("Select Subject", "");
//                            $("#idSubject").append(new Option("Impact", "impact"));
//                        }
//                        if (type == 'Product') {
//                            $("#idSubject").empty().append("Select Subject", "");
//                            $("#idSubject").append(new Option("Benefits", "benefits"));
//                            $("#idSubject").append(new Option("Capabilities", "capabilities"));
//                            $("#idSubject").append(new Option("Risks", "risks"));
//                            $("#idSubject").append(new Option("Proof Impact", "proof_impact"));
//                        }
//                        if (type == 'Message') {
//                            $("#idSubject").empty().append("Select Subject", "");
//                            $("#idSubject").append(new Option("Value Points", "value_points"));
//                        }
//                    }
//                });

                $('#idType').on('change', function (e) {
                    var type = $('#idType').val();

                    if (type != null) {
                        if (type == 'Role') {
                            $.get({
                                url: '${pageContext.request.contextPath}/role/smallRoles',
                                success: function (res) {
                                    populateDropdown(res);
                                }
                            });
                        }
                        if (type == 'Proof') {
                            $.post({
                                url: '${pageContext.request.contextPath}/proof/smallProofs',
                                success: function (res) {
                                    populateDropdown(res);
                                }
                            });
                        }
                        if (type == 'Product') {
                            $.post({
                                url: '${pageContext.request.contextPath}/product/smallProducts',
                                success: function (res) {
                                    populateDropdown(res);
                                }
                            });
                        }
                        if (type == 'Message') {
                            $.post({
                                url: '${pageContext.request.contextPath}/message/smallMessages',
                                success: function (res) {
                                    populateDropdown(res);
                                }
                            });
                        }
                    }
                });

                $('#idForm3').on('keyup keypress keydown', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
                    }
                });


                for (var i = 0; i < "${tab}"; i++) {
                    $('#basic-pills-wizard').bootstrapWizard('next');
                }


            });

            function populateDropdown(result) {
                if (result != null) {
                    $("#idSubject").empty().append("Select", "");
                    result.forEach(d => $("#idSubject").append(new Option(d.name, d.id)));
                }
            }

            function submitForm1() {
                $("#idForm1").submit();
            }

            function submitForm2() {
                $("#idForm2").submit();
            }

            function submitForm3() {
                $("#idForm3").submit();
            }


            function submitForm4() {

                $("#idForm4").submit();
            }

        </script>
    </jsp:attribute>
    <jsp:attribute name="style">
        <style>
            .td-table
            {
                word-wrap: break-word;
                word-break: break-all;  
                white-space: normal !important;
                text-align: justify;
            }
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
                                <h4 class="mb-sm-0 font-size-18">Email Wizard</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Create email template</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#main" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Choose Type">
                                                        1
                                                    </div>
                                                </a>
                                                Choose Type
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#narration" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Choose Narration">
                                                        2
                                                    </div>
                                                </a>
                                                Choose Narration
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#template" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Create Template">
                                                        3
                                                    </div>
                                                </a>
                                                Create Template
                                            </li>
                                        </ul>
                                        <!-- wizard-nav -->

                                        <div class="tab-content twitter-bs-wizard-tab-content">
                                            <div class="tab-pane" id="main">

                                                <form id="idForm1" action="${pageContext.request.contextPath}/email/enrolFirst" method="POST" class="needs-validation" novalidate="">

                                                    <div class="row">
                                                        <div class="col-3">
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Choose Type</label>
                                                                        <select name="type" id="idType" class="form-select">
                                                                            <option value="">Select</option>
                                                                            <option value="Role">Role</option>
                                                                            <option value="Proof">Proof</option>
                                                                            <option value="Product">Product</option>
                                                                            <option value="Message">Message</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Choose Subject</label>
                                                                        <select name="id" id="idSubject" class="form-select">

                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-3">
                                                        </div>
                                                    </div>
                                                </form>
                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="next"><a id="idStepOneNext" href="javascript: void(0);" class="btn btn-primary" onclick="submitForm1();">Next<i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="tab-pane" id="narration">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body" >
                                                                <form id="idForm2" action="${pageContext.request.contextPath}/email/enrolSecond" method="POST" class="needs-validation" novalidate="">
                                                                    <input type="hidden" name="id" value="${emailRequest.id}"/>
                                                                    <input type="hidden" name="type" value="${emailRequest.type}"/>
                                                                    <div class="table-responsive">
                                                                        <table class="table table-nowrap align-middle mb-0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <c:forEach var="item" items="${narrations}" >
                                                                                        <td style="width: 40px;">
                                                                                            <div class="form-check font-size-16">
                                                                                                <input name="narrationOrder" class="form-check-input" type="checkbox" id="upcomingtaskCheck01" value="${item.order}">
                                                                                                <label class="form-check-label" for="upcomingtaskCheck01"></label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <h5 class="text-truncate font-size-14 m-0"><a href="javascript: void(0);" class="text-dark">${item.narration}</a></h5>
                                                                                        </td>
                                                                                    </c:forEach>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="next"><a id="idStepTwoNext" href="javascript: void(0);" class="btn btn-primary" onclick="submitForm2()">Next<i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="tab-pane" id="template">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm2" action="${pageContext.request.contextPath}/email/enrolThird" method="POST" class="needs-validation" novalidate="">
                                                                    <input type="hidden" name="id" value="${emailRequest.id}"/>
                                                                    <input type="hidden" name="type" value="${emailRequest.type}"/>
                                                                    <c:if test="${emailRequest.type eq 'Role'}">
                                                                        <p>
                                                                            Subject line: <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${proofs}" var="result">
                                                                                    <option value="${result.proofImpact}">${result.proofImpact}</option>
                                                                                </c:forEach>
                                                                            </select> <br><br>
                                                                            [GREETING] [CONTACT FIRST NAME], <br><br>
                                                                            The reason for my reaching out to you today is to let you know how we have worked with <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${proofs}" var="result">
                                                                                    <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                            and <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${proofs}" var="result">
                                                                                    <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                                                                                </c:forEach>
                                                                            </select> to solve challenges with <c:out value="${map['_expectations']}"/>.
                                                                            We helped to solve that with our <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${plays}" var="result">
                                                                                    <option value="${result.playProductCategory}">${result.playProductCategory}</option>
                                                                                </c:forEach>
                                                                            </select> solutions. <br><br>
                                                                            Our collaborative work with <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${proofs}" var="result">
                                                                                    <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                                                                                </c:forEach>
                                                                            </select> and <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${proofs}" var="result">
                                                                                    <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                                                                                </c:forEach>
                                                                            </select> not only helped them to <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${proofs}" var="result">
                                                                                    <option value="${result.proofImpact}">${result.proofImpact}</option>
                                                                                </c:forEach>
                                                                            </select>, we were ultimately able to 
                                                                            <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${messages}" var="result">
                                                                                    <c:forEach items="${result.messageValuePoints}" var="r">
                                                                                        <option value="${r}">${r}</option>
                                                                                    </c:forEach>
                                                                                </c:forEach>
                                                                            </select> and <select style="width: 200px;"  required="">
                                                                                <option value="">Select</option>
                                                                                <c:forEach items="${messages}" var="result">
                                                                                    <c:forEach items="${result.messageValuePoints}" var="r">
                                                                                        <option value="${r}">${r}</option>
                                                                                    </c:forEach>
                                                                                </c:forEach>
                                                                            </select> .
                                                                            I don't know if we can help you the same way or even if this is a challenge you face. That is why I am reaching out to understand your challenges better and discuss how we can help you and your organization.
                                                                            Are you available for a brief 15-minute call where we can discuss your unique situation, and you can see how we may be able to help? <br><br>
                                                                            Meanwhile, I’ll keep researching your organization to see if there are other areas of focus where we have solutions to help. Expect to hear from me as I learn more about your organization and provide you with those details. Do not hesitate to let me know when you determine an area of focus for us to discuss, and I will make time for us to speak.  
                                                                            <br><br>
                                                                            [LETTER_CLOSE],<br><br>
                                                                            [Email Signature]<br><br>
                                                                            [Unsubscribe note]<br><br>

                                                                        </p>
                                                                    </c:if>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="next"><a id="idStepTwoNext" href="javascript: void(0);" class="btn btn-primary" onclick="submitForm3()">Create<i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- end tab content -->
                                    </div>
                                </div>
                                <!-- end card body -->
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col -->
                    </div>
                    <!-- end row -->
                </div> <!-- container-fluid -->
            </div>
        </div>
    </jsp:body>
</t:wrapper_dashboard>