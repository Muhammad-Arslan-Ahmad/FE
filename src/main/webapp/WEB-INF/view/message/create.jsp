<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Message Creation" bodyheader="Message Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {
                
                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 6}) {

                                    if (index == 1) {

                                        if (!$("#idMessageName").val()) {
                                            alert("Please Enter Message Name");
                                            $("#idMessageName").focus();
                                            return false;
                                        }
                                        if (!$("#idForm1 select[name='messageProductAlignment']").val()) {
                                            alert("Please Select Product");
                                            $("#idForm1 select[name='messageProductAlignment']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 select[name='messageRoleAlignment']").val()){
                                            alert("Please Select Role");
                                            $("#idForm1 select[name='messageRoleAlignment']").focus();
                                            return false;
                                        }
                                        
                                        submitForm1();
                                    }
                                    if (index == 2) {
                                        var name = "inner-group[0][messageValuePoints]";
                                        var val = $("#idForm2 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm2 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm2();
                                    }
                                    if (index == 3) {
                                        var name = "inner-group[0][messageQuestions]";
                                        var val = $("#idForm3 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm3 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm3();
                                    }
                                    if (index == 4) {
                                        var name = "inner-group[0][messageObjections]";
                                        var val = $("#idForm4 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm4 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm4();
                                    }
                                    if (index == 5) {
                                        var name = "inner-group[0][messageResponses]";
                                        var val = $("#idForm5 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm5 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm5();
                                    }
                                    if (index == 6) {
                                        var name = "inner-group[0][messageProblemResolutions]";
                                        var val = $("#idForm6 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm6 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm6();
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

                $('#idForm4').on('keyup keypress keydown', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
                    }
                });

                $('#idForm5').on('keyup keypress keydown', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
                    }
                });

                $('#idForm6').on('keyup keypress keydown', function (e) {
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

                    var id = $("#messageId").val();
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    formData.append("id", id);
                    $.post({
                        url: '${pageContext.request.contextPath}/message/upload',
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

            function submitForm1() {
                var id = $("#messageId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/message/enrolFirst?id=' + id,
                    data: $('#idForm1').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm2() {
                var id = $("#messageId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/message/enrolSecond?id=' + id,
                    data: $('#idForm2').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm3() {
                var id = $("#messageId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/message/enrolThird?id=' + id,
                    data: $('#idForm3').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm4() {
                var id = $("#messageId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/message/enrolFourth?id=' + id,
                    data: $('#idForm4').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm5() {
                var id = $("#messageId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/message/enrolFifth?id=' + id,
                    data: $('#idForm5').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function populateFields(message) {
                $("#messageId").val(message.id);
                $("#messageResolutionId").val(message.id);
                $("#narrationMessageId").val(message.id);
            }

            function submitForm6() {
                
                $("#idForm6").submit();
            }

            function submitForm7() {
                var messageName = "inner-group[0][statement]";
                var val = $("#idForm7 input[name='" + messageName + "']").val();
                for (var i = 0; i < 5; i++) {
                    try {
                        var name = "inner-group[" + i + "][statement]";
                        var itemsName = "inner-group[" + i + "][items]";
                        var messageValuePointsName = "inner-group[" + i + "][messageValuePoints]";
                        var messageProblemResolutionsName = "inner-group[" + i + "][messageProblemResolutions]";
                        var messageResponsesName = "inner-group[" + i + "][messageResponses]";
                        var messageQuestionsName = "inner-group[" + i + "][messageQuestions]";
                        var messageObjectionsName = "inner-group[" + i + "][messageObjections]";

                        var messageValuePointsVal = $("#idForm7 select[name='" + messageValuePointsName + "']").val();
                        var messageProblemResolutionsVal = $("#idForm7 select[name='" + messageProblemResolutionsName + "']").val();
                        var messageResponsesVal = $("#idForm7 select[name='" + messageResponsesName + "']").val();
                        var messageQuestionsVal = $("#idForm7 select[name='" + messageQuestionsName + "']").val();
                        var messageObjectionsVal = $("#idForm7 select[name='" + messageObjectionsName + "']").val();

                        var statement = " Our {_messageProductAlignment} helps people in the {_messageRoleAlignment} role improve {_messageValuePoints} while also overcoming {_messageProblemResolutions}. When engaging with them, asking questions like {_messageResponses} is important.  Be prepared to follow up with {_messageQuestions}. Also, be ready for them to say things like {_messageObjections}";
                        $("#idForm7 input[name='" + name + "']").val(statement);
                        var items = "_messageProductAlignment=${message.messageProductAlignment},_messageRoleAlignment=${message.messageRoleAlignment},_messageValuePoints=" + messageValuePointsVal + ",_messageProblemResolutions=" + messageProblemResolutionsVal + ",_messageResponses=" + messageResponsesVal + ",_messageQuestions=" + messageQuestionsVal + ",_messageObjections=" + messageObjectionsVal;
                        $("#idForm7 input[name='" + itemsName + "']").val(items);
                    } catch (e) {
                    }
                }

                $("#idForm7").submit();
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
                                <h4 class="mb-sm-0 font-size-18">Message</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Message Creation Wizard</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#message" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Message">
                                                        1
                                                    </div>
                                                </a>
                                                Message
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#values" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Value Points">
                                                        2
                                                    </div>
                                                </a>
                                                Value Points
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#questions" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Questions">
                                                        3
                                                    </div>
                                                </a>
                                                Questions
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm3()" href="#objections" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Objections">
                                                        4
                                                    </div>
                                                </a>
                                                Objections
                                            </li>

                                            <li onclick="submitForm4()" class="nav-item">
                                                <a href="#responses" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Responses">
                                                        5
                                                    </div>
                                                </a>
                                                Responses
                                            </li>

                                            <li onclick="submitForm5()" class="nav-item">
                                                <a href="#resolutions" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Problem Resolutions">
                                                        6
                                                    </div>
                                                </a>
                                                Problem Resolutions
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm6()" href="#preview" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Preview">
                                                        7
                                                    </div>
                                                </a>
                                                Preview
                                            </li>
                                        </ul>
                                        <!-- wizard-nav -->

                                        <div class="tab-content twitter-bs-wizard-tab-content">
                                            <div class="tab-pane" id="message">
                                                <div class="text-center mb-4">
                                                    <p class="card-title-desc">Fill the information below</p>
                                                </div>
                                                <input id="messageId" type="hidden" name="id" value="${message.id}"/>
                                                <form id="idForm1" action="${pageContext.request.contextPath}/message/enrolFirst" method="POST" class="needs-validation" novalidate="">

                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idMessageName" class="form-label">* Name of the message</label>
                                                                    <input name="name" value="${message.name}" type="text" class="form-control" placeholder="Message Name" id="idMessageName" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">* Please select a buyer role</label>
                                                                        <select name="messageRoleAlignment" class="form-select" required="false">
                                                                            <option value="">Select</option>
                                                                            <c:forEach items="${roles}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq message.messageRoleAlignment}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">* Please select a product</label>
                                                                        <select name="messageProductAlignment" class="form-select" required="false">
                                                                            <option value="">Select</option>
                                                                            <c:forEach items="${products}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq message.messageProductAlignment}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">Is this a primary value point you want to emphasize with your buyers?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="messageValueHighlight"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="messageValueHighlight"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${message.messageValueHighlight eq 'No'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       No
                                                                                   </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-10">
                                                                    <div class="mb-3">
                                                                        <label for="basicpill-lastname-input" class="form-label">Is this a direct message you want to emphasize with your buyers?</label>
                                                                        <div class="row" style="margin-left: 10px;">
                                                                            <div class="form-check col-4">
                                                                                <input class="form-check-input" type="radio" name="messageVeryImportant"
                                                                                       id="formRadios1" checked value="Yes" required="false">
                                                                                <label class="form-check-label" for="formRadios1">
                                                                                    Yes
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-4">
                                                                                <input class="form-check-input" type="radio" name="messageVeryImportant"
                                                                                       id="formRadios2" required="false" value="No" <c:if test="${message.messageVeryImportant eq 'No'}">checked</c:if> >
                                                                                <label class="form-check-label" for="formRadios2">
                                                                                    No
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-10">
                                                                    <div class="mb-3">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">What type question is this?</label>
                                                                            <select name="messageQuestionType" class="form-select" required="false">
                                                                                <option value="">Select</option>
                                                                            <c:forEach items="${questionTypes}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq message.messageQuestionType}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label class="form-label">What identity do do you want to give the response to this objection?</label>
                                                                    <input name="messageResponseName" value="${message.messageResponseName}" type="text" class="form-control" placeholder="Message Response Name" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">What win them does this align to?</label>
                                                                        <select name="messageWinThemeAlignment" class="form-select" required="false">
                                                                            <option value="">Select</option>
                                                                            <c:forEach items="${messageThemes}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq message.messageWinThemeAlignment}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Please select an industry</label>
                                                                        <select name="messageIndustryAlignment" class="form-select" required="false">
                                                                            <option value="">Select</option>
                                                                            <c:forEach items="${industries}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq message.messageIndustryAlignment}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">Is this a primary problem you want to emphasize with your buyers?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="messageProblemCritical"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="messageProblemCritical"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${message.messageProblemCritical eq 'No'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       No
                                                                                   </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col">
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
                                            </div>
                                            <div class="tab-pane" id="values">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm2" action="${pageContext.request.contextPath}/message/enrolSecond" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What is the value of your product or services (solution)?</label>

                                                                            <c:choose>
                                                                                <c:when test="${message.messageValuePoints ne null and fn:length(message.messageValuePoints) > 0}">
                                                                                    <c:forEach items="${message.messageValuePoints}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="messageValuePoints" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="messageValuePoints" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Value Point"/>
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
                                                <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick="nextTab()"><i
                                                            class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                <li class="next"><a id="idStepTwoNext" href="javascript: void(0);" class="btn btn-primary">Next <i
                                                            class="bx bx-chevron-right ms-1"></i></a></li>
                                            </ul>
                                        </div>

                                        <div class="tab-pane" id="questions">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm3" action="${pageContext.request.contextPath}/message/enrolThird" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What question can you ask a buyer to help them move forward?</label>
                                                                            <c:choose>
                                                                                <c:when test="${message.messageQuestions ne null and fn:length(message.messageQuestions) > 0}">
                                                                                    <c:forEach items="${message.messageQuestions}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="messageQuestions" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="messageQuestions" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Question"/>
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
                                                <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick="nextTab()"><i
                                                            class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                <li class="next"><a id="idStepThreeNext" href="javascript: void(0);" class="btn btn-primary">Next <i
                                                            class="bx bx-chevron-right ms-1"></i></a></li>
                                            </ul>
                                        </div>

                                        <div class="tab-pane" id="objections">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm4" action="${pageContext.request.contextPath}/message/enrolFourth" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What is the identity you want to give this objection?</label>
                                                                            <c:choose>
                                                                                <c:when test="${message.messageObjections ne null and fn:length(message.messageObjections) > 0}">
                                                                                    <c:forEach items="${message.messageObjections}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="messageObjections" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="messageObjections" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Objection"/>
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
                                                <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick="nextTab()"><i
                                                            class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                <li class="next"><a id="idStepFourNext" href="javascript: void(0);" class="btn btn-primary">Next <i
                                                            class="bx bx-chevron-right ms-1"></i></a></li>
                                            </ul>
                                        </div>
                                        <div class="tab-pane" id="responses">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm5" action="${pageContext.request.contextPath}/message/enrolFifth" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">How do you want to respond to this objection?</label>
                                                                            <c:choose>
                                                                                <c:when test="${message.messageResponses ne null and fn:length(message.messageResponses) > 0}">
                                                                                    <c:forEach items="${message.messageResponses}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="messageResponses" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="messageResponses" type="text" class="inner form-control"  required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Response"/>
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
                                                <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick="nextTab()"><i
                                                            class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                <li class="next"><a id="idStepFiveNext" href="javascript: void(0);" class="btn btn-primary">Next <i
                                                            class="bx bx-chevron-right ms-1"></i></a></li>
                                            </ul>
                                        </div>

                                        <div class="tab-pane" id="resolutions">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm6" action="${pageContext.request.contextPath}/message/enrolSixth" method="POST" class="needs-validation" novalidate="">
                                                                <input id="messageResolutionId" type="hidden" name="id" value="${message.id}"/>
                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What problem does the product or service specifically solve for buyers?</label>
                                                                            <c:choose>
                                                                                <c:when test="${message.messageProblemResolutions ne null and fn:length(message.messageProblemResolutions) > 0}">
                                                                                    <c:forEach items="${message.messageProblemResolutions}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="messageProblemResolutions" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="messageProblemResolutions" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Resolution"/>
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
                                                <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick="nextTab()"><i
                                                            class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                <li class="next"><a id="idStepSixNext" href="javascript: void(0);" class="btn btn-primary">Preview<i
                                                            class="bx bx-chevron-right ms-1"></i></a></li>
                                            </ul>
                                        </div>
                                        <div class="tab-pane" id="preview">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <form id="idForm7" action="${pageContext.request.contextPath}/message/enrolSeventh" method="POST" class="needs-validation" novalidate="">
                                                        <input id="narrationMessageId" type="hidden" name="id" value="${message.id}"/>
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
                                                                                                <input id="idNarration" name="statement" type="hidden" value="${message.name}"/>
                                                                                                <input name="items" type="hidden" value=""/>
                                                                                                Our <input type="text" style="width: 200px;" value="${message.messageProductAlignment}"/> helps people in the
                                                                                                <input type="text" style="width: 200px;" value="${message.messageRoleAlignment}"/>
                                                                                                role improve <br><br>
                                                                                                <select name="messageValuePoints" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${message.messageValuePoints}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                while also overcoming
                                                                                                <select name="messageProblemResolutions" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${message.messageProblemResolutions}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                . When engaging with them, asking <br><br> questions like 
                                                                                                <select name="messageResponses" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${message.messageResponses}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                is important.  Be prepared to follow up with
                                                                                                <select name="messageQuestions" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${message.messageQuestions}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>. Also, be <br><br> ready for them to say things like
                                                                                                <select name="messageObjections" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${message.messageObjections}" var="result">
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
                                onclick="submitForm7();">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</jsp:body>
</t:wrapper_dashboard>