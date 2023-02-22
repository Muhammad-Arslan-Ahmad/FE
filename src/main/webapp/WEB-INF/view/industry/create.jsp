<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Industry Creation" bodyheader="Industry Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {
                
                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 3}) {

                                    if (index == 1) {

                                        if (!$("#idIndustryName").val()) {
                                            alert("Please Enter Industry Name");
                                            $("#idIndustryName").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 select[name='industryRoleSelected']").val()){
                                            alert("Please Select Industry Role");
                                            $("#idForm1 select[name='industryRoleSelected']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='industryExternalForce']").val()){
                                            alert("Please Enter External Force");
                                            $("#idForm1 input[name='industryExternalForce']").focus();
                                            return false;
                                        }
                                        submitForm1();
                                    }
                                    if (index == 2) {
                                        var name = "inner-group[0][industryTrends]";
                                        var val = $("#idForm2 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm2 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm2();
                                    }
                                    if (index == 3) {
                                        var name = "inner-group[0][industryExternalForceImpacts]";
                                        var val = $("#idForm3 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm3 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm3();
                                    }
                                }
                            }
                        });

                $(".drag").sortable({
                    axis: "y",
                    cursor: 'move',
                    opacity: 0.5,
                    placeholder: "row-dragging",
                    delay: 150,
                    stop: function (e, ui) {
                        getPosition();
                    }

                }).disableSelection();

                $('#idForm2').on('keyup keypress keydown', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
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

                $('#idForm1 input[type=file]').on('change', function (e) {

                    var id = $("#industryId").val();
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    formData.append("id", id);
                    $.post({
                        url: '${pageContext.request.contextPath}/industry/upload',
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (res) {
                            populateFields(res);
                        }
                    });

                });

            });

            function populateFields(industry) {
                $("#industryId").val(industry.id);
                $("#externalForceImpactId").val(industry.id);
                $("#narrationIndustryId").val(industry.id);
            }
            function submitForm1() {
                var id = $("#industryId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/industry/enrolFirst?id=' + id,
                    data: $('#idForm1').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm2() {
                var id = $("#industryId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/industry/enrolSecond?id=' + id,
                    data: $('#idForm2').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm3() {
                $("#idForm3").submit();
            }

            function getPosition() {
                var count = 0;
                $("#idRepeater :input").each(function (e) {
                    var name = this.name;
                    if (name.includes("position")) {
                        $("#idForm4 input[name='" + name + "']").val(count);
                        count++;
                    }
                });
            }

            function submitForm4() {
                var name = "inner-group[0][statement]";
                var val = $("#idForm4 input[name='" + name + "']").val();
                for (var i = 0; i < 5; i++) {
                    try {
                        var name = "inner-group[" + i + "][statement]";
                        var itemsName = "inner-group[" + i + "][items]";
                        var industryRoleSelectedName = "inner-group[" + i + "][industryRoleSelected]";
                        var industryTrendsName = "inner-group[" + i + "][industryTrends]";
                        var industryExternalForceImpactsName = "inner-group[" + i + "][industryExternalForceImpacts]";
                        
                        var industryRoleSelectedVal = $("#idForm4 select[name='" + industryRoleSelectedName + "']").val();
                        var industryTrendsVal = $("#idForm4 select[name='" + industryTrendsName + "']").val();
                        var industryExternalForceImpactsVal = $("#idForm4 select[name='" + industryExternalForceImpactsName + "']").val();
                        
                        var statement = "As a {_industryRoleSelected} in the {_name}, your organization must have a strategy for {_industryTrends} which means you’re likely trying to {_industryExternalForce} which translates to {_industryExternalForceImpacts}";
                        $("#idForm4 input[name='" + name + "']").val(statement);
                        var items = "_industryRoleSelected="+industryRoleSelectedVal+",_name=${industry.name},_industryTrends="+industryTrendsVal+",_industryExternalForce=${industry.industryExternalForce},_industryExternalForceImpacts="+industryExternalForceImpactsVal;
                        $("#idForm4 input[name='" + itemsName + "']").val(items);

                    } catch (e) {
                        break;
                    }
                }

                $("#idForm4").submit();
            }

        </script>
    </jsp:attribute>
    <jsp:attribute name="style">

    </jsp:attribute>
    <jsp:body>
        <div class="main-content">

            <div class="page-content">
                <div class="container-fluid">

                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0 font-size-18">Industry</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Industry Creation Wizard</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#industry" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Industry">
                                                        1
                                                    </div>
                                                </a>
                                                Industry
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#trends" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Industry Trends">
                                                        2
                                                    </div>
                                                </a>
                                                Industry Trends
                                            </li>

                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#challenges" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Industry Challenges">
                                                        3
                                                    </div>
                                                </a>
                                                Industry Challenges
                                            </li>

                                            <li onclick="submitForm3()" class="nav-item">
                                                <a href="#preview" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Preview">
                                                        4
                                                    </div>
                                                </a>
                                                Preview
                                            </li>

                                        </ul>
                                        <!-- wizard-nav -->

                                        <div class="tab-content twitter-bs-wizard-tab-content">
                                            <div class="tab-pane" id="industry">
                                                <div class="text-center mb-4">
                                                    <p class="card-title-desc">Fill the information below</p>
                                                </div>
                                                <input id="industryId" type="hidden" name="id" value="${industry.id}"/>
                                                <form id="idForm1" action="${pageContext.request.contextPath}/industry/enrolFirst" method="POST" class="needs-validation" novalidate="">

                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idIndustryName" class="form-label">* What is the name of the industry?</label>
                                                                    <input name="name" value="${industry.name}" type="text" class="form-control" placeholder="Name of the industry is ..." id="idIndustryName" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idIndustryExternalForce" class="form-label">* What is the name of the external force impacting buyers in this industry?</label>
                                                                    <input name="industryExternalForce" value="${industry.industryExternalForce}" type="text" class="form-control" placeholder="The external force is ..." required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">Is this a primary external force you want to emphasize with your buyers?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="industryExternalForceEmphasize"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="industryExternalForceEmphasize"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${industry.industryExternalForceEmphasize eq 'No'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       No
                                                                                   </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <!-- second column -->
                                                            <div class="col-6">
                                                                <div class="col-lg-10">
                                                                    <div class="mb-3">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">* Please select a buyer role</label>
                                                                            <select name="industryRoleSelected" class="form-select" required="false">
                                                                                <option value="">Select</option>
                                                                            <c:forEach items="${roles}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq industry.industryRoleSelected}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">Is this a primary trend you want to emphasize with your buyers?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="industryTrendPrioritize"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="industryTrendPrioritize"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${industry.industryTrendPrioritize eq 'No'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       No
                                                                                   </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-10">
                                                                    <div class="card">
                                                                        <div class="card-body">
                                                                            <div>
                                                                                <div class="mydropzone">
                                                                                    <div class="fallback">
                                                                                        <input id="idFile" name="file" type="file">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </form>
                                                    <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                        <li class="next"><a id="idStepOneNext" href="javascript: void(0);" class="btn btn-primary">Next<i
                                                                    class="bx bx-chevron-right ms-1"></i></a></li>
                                                    </ul>
                                                </div>
                                                <div class="tab-pane" id="trends">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <form id="idForm2" action="${pageContext.request.contextPath}/industry/enrolSecond" method="POST" class="needs-validation" novalidate="">

                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">Industry Trends</label>

                                                                                <c:choose>
                                                                                    <c:when test="${industry.industryTrends ne null and fn:length(industry.industryTrends) > 0}">
                                                                                        <c:forEach items="${industry.industryTrends}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="industryTrends" value="${result}" type="text" class="inner form-control" required=""/>
                                                                                                    </div>
                                                                                                    <div class="col-md-2">
                                                                                                        <div class="mt-2 mt-md-0 d-grid">
                                                                                                            <input data-repeater-delete type="button" class="btn btn-primary inner" value="Delete"/>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="industryTrends" type="text" class="inner form-control" required=""/>
                                                                                                </div>
                                                                                                <div class="col-md-2">
                                                                                                    <div class="mt-2 mt-md-0 d-grid">
                                                                                                        <input data-repeater-delete type="button" class="btn btn-primary inner" value="Delete"/>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                            <div class="row justify-content-end">
                                                                                <div class="col-lg-10">
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Trend"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="previous"><a href="javascript: void(0);" class="btn btn-primary"><i
                                                                class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                    <li class="next"><a id="idStepTwoNext" href="javascript: void(0);" class="btn btn-primary">Next <i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>

                                            <div class="tab-pane" id="challenges">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm3" action="${pageContext.request.contextPath}/industry/enrolThird" method="POST" class="needs-validation" novalidate="">
                                                                    <input id="externalForceImpactId" type="hidden" name="id" value="${industry.id}"/>
                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">Industry Challenges</label>
                                                                                <c:choose>
                                                                                    <c:when test="${industry.industryExternalForceImpacts ne null and fn:length(industry.industryExternalForceImpacts) > 0}">
                                                                                        <c:forEach items="${industry.industryExternalForceImpacts}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="industryExternalForceImpacts" value="${result}" type="text" class="inner form-control" required=""/>
                                                                                                    </div>
                                                                                                    <div class="col-md-2">
                                                                                                        <div class="mt-2 mt-md-0 d-grid">
                                                                                                            <input data-repeater-delete type="button" class="btn btn-primary inner" value="Delete"/>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="industryExternalForceImpacts" type="text" class="inner form-control"  required=""/>
                                                                                                </div>
                                                                                                <div class="col-md-2">
                                                                                                    <div class="mt-2 mt-md-0 d-grid">
                                                                                                        <input data-repeater-delete type="button" class="btn btn-primary inner" value="Delete"/>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                            <div class="row justify-content-end">
                                                                                <div class="col-lg-10">
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Challenge"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" ><i
                                                                class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                    <li class="next"><a id="idStepSixNext" href="javascript: void(0);" class="btn btn-primary" >Preview<i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="tab-pane" id="preview">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <form id="idForm4" action="${pageContext.request.contextPath}/industry/enrolFourth" method="POST" class="needs-validation" novalidate="">
                                                            <input id="narrationIndustryId" type="hidden" name="id" value="${industry.id}"/>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <div data-repeater-list="outer-group" class="outer" id="idRepeater">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row drag">
                                                                                <div  data-repeater-item class="row">
                                                                                    <div class="card">
                                                                                        <div class="card-body p-4">
                                                                                            <div class="row">
                                                                                                <div class="col-lg-10" style="margin-bottom: 40px;" >
                                                                                                    <input name="position" type="hidden" />
                                                                                                    <input name="statement" type="hidden" value="${industry.name}"/>
                                                                                                    <input name="items" type="hidden" value=""/>
                                                                                                    As a 
                                                                                                    <select name="industryRoleSelected" style="width: 200px;"  required="">
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${industry.industryRoleSelected}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    in the
                                                                                                    <input type="text" style="width: 200px;" value="${industry.name}"/>, your organization must have a strategy for <br><br>
                                                                                                    <select name="industryTrends" style="width: 200px;"  required="">
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${industry.industryTrends}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    which means you’re likely trying to
                                                                                                    <input type="text" style="width: 200px;" value="${industry.industryExternalForce}"/> which translates to <br><br> 
                                                                                                    <select name="industryExternalForceImpacts" style="width: 200px;"  required="">
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${industry.industryExternalForceImpacts}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>. 
                                                                                                </div>
                                                                                                <div class="col-lg-1">
                                                                                                    <div class="mt-2 mt-md-0 d-grid">
                                                                                                        <input data-repeater-delete type="button" class="btn btn-primary inner" value="Delete"/>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row justify-content-end">
                                                                                <div class="col-lg-10">
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another"/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div> <!-- end col -->
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>

                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick="nextTab()"><i
                                                                class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                    <li class="float-end"><a href="javascript: void(0);" class="btn btn-primary" data-bs-toggle="modal"
                                                                             data-bs-target=".confirmModal">Save Changes</a></li>
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
            <!-- End Page-content -->
            <!-- Modal -->
            <div class="modal fade confirmModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-bottom-0">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="text-center">
                                <div class="mb-3">
                                    <i class="bx bx-check-circle display-4 text-success"></i>
                                </div>
                                <h5>Confirm Save Changes</h5>
                            </div>
                        </div>
                        <div class="modal-footer justify-content-center">
                            <button type="button" class="btn btn-light w-md" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary w-md" data-bs-dismiss="modal"
                                    onclick="submitForm4();">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:wrapper_dashboard>