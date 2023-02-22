<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Role Creation" bodyheader="Role Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {

                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 6}) {

                                    if (index == 1) {

                                        if (!$("#idRoleName").val()) {
                                            alert("Please Enter Role Name");
                                            $("#idRoleName").focus();
                                            return false;
                                        }
                                        submitForm1();
                                    }
                                    if (index == 2) {
                                        var name = "inner-group[0][expectations]";
                                        var val = $("#idForm2 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm2 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm2();
                                    }
                                    if (index == 3) {
                                        var name = "inner-group[0][painAndGains]";
                                        var val = $("#idForm3 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm3 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm3();
                                    }
                                    if (index == 4) {
                                        var name = "inner-group[0][possibilities]";
                                        var val = $("#idForm4 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm4 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm4();
                                    }
                                    if (index == 5) {
                                        var name = "inner-group[0][impactedWorks]";
                                        var val = $("#idForm5 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm5 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm5();
                                    }
                                    if (index == 6) {
                                        var name = "inner-group[0][hiddenPitfalls]";
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

                for (var i = 0; i < "${tab}"; i++) {
                    $('#basic-pills-wizard').bootstrapWizard('next');
                }

//                $('#idStepOneNext').click(function (e) {
//                    e.preventDefault();
//                    submitForm1();
//                });

                $('#idForm1 input[type=file]').on('change', function (e) {

                    var id = $("#roleId").val();
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    formData.append("id", id);
                    $.post({
                        url: '${pageContext.request.contextPath}/role/upload',
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

//                $('#idStepTwoNext').click(function (e) {
//                    e.preventDefault();
//                    submitForm2();
//                });
//
//                $('#idStepThreeNext').click(function (e) {
//                    e.preventDefault();
//                    submitForm3();
//                });
//
//                $('#idStepFourNext').click(function (e) {
//                    e.preventDefault();
//                    submitForm4();
//                });
//
//                $('#idStepFiveNext').click(function (e) {
//                    e.preventDefault();
//                    submitForm5();
//                });
            });

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

            function submitForm1() {
                var id = $("#roleId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/role/enrolFirst?id=' + id,
                    data: $('#idForm1').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm2() {
                var id = $("#roleId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/role/enrolSecond?id=' + id,
                    data: $('#idForm2').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm3() {
                var id = $("#roleId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/role/enrolThird?id=' + id,
                    data: $('#idForm3').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm4() {
                var id = $("#roleId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/role/enrolFourth?id=' + id,
                    data: $('#idForm4').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm5() {
                var id = $("#roleId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/role/enrolFifth?id=' + id,
                    data: $('#idForm5').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function populateFields(role) {
                $("#roleId").val(role.id);
                $("#narrationRoleId").val(role.id);
                $("#pitfallRoleId").val(role.id);
            }

            function prepareRepeater() {
                window.outerRepeater = $(".narration-outer-repeater").repeater(
                        {
                            defaultValues:
                                    {
                                        "text-input": "outer-default"
                                    },
                            show: function ()
                            {
                                console.log("outer show"), $(this).slideDown()
                            },
                            hide: function (e)
                            {
                                console.log("outer delete"),
                                        $(this).slideUp(e)
                            },
                            repeaters:
                                    [{
                                            selector: ".inner-repeater",
                                            defaultValues: {
                                                "inner-text-input": "inner-default"
                                            },
                                            show: function ()
                                            {
                                                console.log("inner show"),
                                                        $(this).slideDown()
                                            },
                                            hide: function (e)
                                            {
                                                console.log("inner delete"),
                                                        $(this).slideUp(e)
                                            }

                                        }]
                        });
            }

            function populateDropdown(id, result) {
                if (result != null) {
                    $("#" + id).empty().append("Select", "");
                    result.forEach(d => $("#" + id).append(new Option(d, d)));
                }
            }

            function submitForm6() {
                $("#idForm6").submit();
            }

            function getPosition() {
                var count = 0;
                $("#idRepeater :input").each(function (e) {
                    var name = this.name;
                    if (name.includes("position")) {
                        $("#idForm7 input[name='" + name + "']").val(count);
                        count++;
                    }
                });
            }

            function submitForm7() {
                var roleName = "inner-group[0][statement]";
                var val = $("#idForm7 input[name='" + roleName + "']").val();
                for (var i = 0; i < 5; i++) {
                    var name = "inner-group[" + i + "][statement]";
                    var itemsName = "inner-group[" + i + "][items]";
                    var expectationName = "inner-group[" + i + "][expectations]";
                    var strugglesName = "inner-group[" + i + "][struggles]";
                    var painAndGainsName = "inner-group[" + i + "][painAndGains]";
                    var possibilitiesName = "inner-group[" + i + "][possibilities]";
                    var hiddenPitfallsName = "inner-group[" + i + "][hiddenPitfalls]";
                    var impactedWorksName = "inner-group[" + i + "][impactedWorks]";


                    var expectationVal = $("#idForm7 select[name='" + expectationName + "']").val();
                    if (expectationVal != null && expectationVal != '' && expectationVal != 'undefined') {
                        var strugglesVal = $("#idForm7 select[name='" + strugglesName + "']").val();
                        var painAndGainsVal = $("#idForm7 select[name='" + painAndGainsName + "']").val();
                        var possibilitiesVal = $("#idForm7 select[name='" + possibilitiesName + "']").val();
                        var hiddenPitfallsVal = $("#idForm7 select[name='" + hiddenPitfallsName + "']").val();
                        var impactedWorksVal = $("#idForm7 select[name='" + impactedWorksName + "']").val();
                        var statement = "As a " + val + ", I assume you are responsible for " + expectationVal + " and might be struggling with " + strugglesVal + " as you " + painAndGainsVal + ". I understand as you work toward that, you're probably wondering how you can " + possibilitiesVal + " without " + hiddenPitfallsVal + " as you " + impactedWorksVal;
                        $("#idForm7 input[name='" + name + "']").val(statement);
                        var items = "_roleName=" + val + ",_expectations=" + expectationVal + ",_struggles=" + strugglesVal + ",_painAndGains=" + painAndGainsVal + ",_possibilities=" + possibilitiesVal + ",_hiddenPitfalls=" + hiddenPitfallsVal + ",_impactedWorks=" + impactedWorksVal;
                        $("#idForm7 input[name='" + itemsName + "']").val(items);
                    } else {
                        break;
                    }
                }

                $("#idForm7").submit();
            }

            function moveUp($item) {
                $before = $item.prev();
                $item.insertBefore($before);
            }

            function moveDown($item) {
                $after = $item.next();
                $item.insertAfter($after);
            }

        </script>
    </jsp:attribute>
    <jsp:attribute name="style">
        <style>
            .twitter-bs-wizard .twitter-bs-wizard-nav .nav-link::after {
                width: 65%;
                left: 68%;
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
                                <h4 class="mb-sm-0 font-size-18">Roles</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Role Creation Wizard</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#role" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Role">
                                                        1
                                                    </div>
                                                </a>
                                                Role
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#objective" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Objectives">
                                                        2
                                                    </div>
                                                </a>
                                                Objectives
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#pain-gain" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Pain/Gain">
                                                        3
                                                    </div>
                                                </a>
                                                Pain/Gain
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm3()" href="#possibility" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Possibilities">
                                                        4
                                                    </div>
                                                </a>
                                                Possibilities
                                            </li>

                                            <li onclick="submitForm4()" class="nav-item">
                                                <a href="#impacted-work" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Impacted Work">
                                                        5
                                                    </div>
                                                </a>
                                                Impacted Work
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm5()" href="#hidden-pitfall" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Hidden Pitfalls">
                                                        6
                                                    </div>
                                                </a>
                                                Hidden Pitfalls
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
                                            <div class="tab-pane" id="role">
                                                <div class="text-center mb-4">
                                                    <p class="card-title-desc">Fill the information below</p>
                                                </div>
                                                <input id="roleId" type="hidden" name="id" value="${role.id}"/>
                                                <form id="idForm1" action="${pageContext.request.contextPath}/role/enrolFirst" method="POST" enctype="multipart/form-data">

                                                    <div class="row">
                                                        <div class="col-8">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idRoleName" class="form-label">* What is the role you are defining?</label>
                                                                    <input name="roleName" value="${role.roleName}" type="text" class="form-control" placeholder="This role is ..." id="idRoleName" required>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idTitles" class="form-label">What are example job titles for people in this job?</label>
                                                                    <input name="jobTitle" value="${role.jobTitle}" type="text" class="form-control" id="idTitles" placeholder="People in this role have these titles ..." >
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">What is the role altitude level? </label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="roleAltitudeLevel"
                                                                                   id="formRadios1" checked value="Executive" >
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Executive
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="roleAltitudeLevel"
                                                                                   id="formRadios2"  value="Manager" <c:if test="${role.roleAltitudeLevel eq 'Manager'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       Manager
                                                                                   </label>
                                                                            </div>
                                                                            <div class="form-check col-4">
                                                                                <input class="form-check-input" type="radio" name="roleAltitudeLevel"
                                                                                       id="formRadios3" value="Practitioner"  <c:if test="${role.roleAltitudeLevel eq 'Practitioner'}">checked</c:if>>
                                                                                <label class="form-check-label" for="formRadios3">
                                                                                    Practitioner
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-10">
                                                                    <div class="mb-3">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Which role does this role typically report into?</label>
                                                                            <select name="reportingRole" class="form-select" >
                                                                                <option value="">Select</option>
                                                                            <c:forEach items="${roles}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq role.reportingRole}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
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
                                            <div class="tab-pane" id="objective">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm2" action="${pageContext.request.contextPath}/role/enrolSecond" method="POST" class="needs-validation" novalidate="">

                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">People in the ${role.roleName} are expected to ... </label>

                                                                                <c:choose>
                                                                                    <c:when test="${role.expectations ne null and fn:length(role.expectations) > 0}">
                                                                                        <c:forEach items="${role.expectations}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="expectations" value="${result}" type="text" class="inner form-control" />
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
                                                                                                    <input name="expectations" type="text" class="inner form-control" />
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Business Objective"/>
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
                                            <div class="tab-pane" id="pain-gain">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm3" action="${pageContext.request.contextPath}/role/enrolThird" method="POST" class="needs-validation" novalidate="">

                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">What are people in the ${role.roleName} struggling to do?</label>
                                                                                <c:choose>
                                                                                    <c:when test="${role.painAndGains ne null and fn:length(role.painAndGains) > 0}">
                                                                                        <c:forEach items="${role.painAndGains}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="painAndGains" value="${result}" type="text" class="inner form-control" />
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
                                                                                                    <input name="painAndGains" type="text" class="inner form-control" />
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Pain/Gain"/>
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
                                            <div class="tab-pane" id="possibility">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm4" action="${pageContext.request.contextPath}/role/enrolFourth" method="POST" class="needs-validation" novalidate="">

                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">People in this ${role.roleName} feel they must achieve ...</label>
                                                                                <c:choose>
                                                                                    <c:when test="${role.possibilities ne null and fn:length(role.possibilities) > 0}">
                                                                                        <c:forEach items="${role.possibilities}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="possibilities" value="${result}" type="text" class="inner form-control" />
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
                                                                                                    <input name="possibilities" type="text" class="inner form-control" />
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Possibility"/>
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
                                            <div class="tab-pane" id="impacted-work">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm5" action="${pageContext.request.contextPath}/role/enrolFifth" method="POST" class="needs-validation" novalidate="">

                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">When people in this ${role.roleName} achieve what's possible, they will change their organization by ...</label>
                                                                                <c:choose>
                                                                                    <c:when test="${role.impactedWorks ne null and fn:length(role.impactedWorks) > 0}">
                                                                                        <c:forEach items="${role.impactedWorks}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="impactedWorks" value="${result}" type="text" class="inner form-control" />
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
                                                                                                    <input name="impactedWorks" type="text" class="inner form-control" />
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Impact"/>
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
                                                    <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" onclick=""><i
                                                                class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                    <li class="next"><a id="idStepFiveNext" href="javascript: void(0);" class="btn btn-primary">Next <i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="tab-pane" id="hidden-pitfall">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm6" action="${pageContext.request.contextPath}/role/enrolSixth" method="POST" class="needs-validation" novalidate="">
                                                                    <input id="pitfallRoleId" type="hidden" name="id" value="${role.id}"/>
                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">What is an unseen and unstated pitfall do ${role.roleName} need to think about?</label>
                                                                                <c:choose>
                                                                                    <c:when test="${role.hiddenPitfalls ne null and fn:length(role.hiddenPitfalls) > 0}">
                                                                                        <c:forEach items="${role.hiddenPitfalls}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="hiddenPitfalls" value="${result}" type="text" class="inner form-control" />
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
                                                                                                    <input name="hiddenPitfalls" type="text" class="inner form-control" />
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Impact"/>
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
                                                        <form id="idForm7" action="${pageContext.request.contextPath}/role/enrolSeventh" method="POST" class="needs-validation" novalidate="">
                                                            <input id="narrationRoleId" type="hidden" name="id" value="${role.id}"/>
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
                                                                                                    <input id="idNarration" name="statement" type="hidden" value="${role.roleName}"/>
                                                                                                    <input name="items" type="hidden" value=""/>
                                                                                                    As a <input id="idNarrationRoleName" type="text" style="width: 200px;" value="${role.roleName}"/> , I assume you are responsible for
                                                                                                    <select id="idNarrationExpectations" name="expectations" style="width: 200px;"  >
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${role.expectations}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    and might be struggling to <br><br>
                                                                                                    <select id="idNarrationStruggles" name="struggles" style="width: 200px;"  >
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${role.painAndGains}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    as you 
                                                                                                    <select id="idNarrationPainAndGains" name="painAndGains" style="width: 200px;"  >
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${role.painAndGains}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    . As you work on that, you're probably wondering how you can <br><br>
                                                                                                    <select id="idNarrationPossibilities" name="possibilities" style="width: 200px;"  >
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${role.possibilities}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    without 
                                                                                                    <select id="idNarrationHiddenPitfalls" name="hiddenPitfalls" style="width: 200px;"  >
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${role.hiddenPitfalls}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
                                                                                                    as you 
                                                                                                    <select id="idNarrationImpactedWorks" name="impactedWorks" style="width: 200px;"  >
                                                                                                        <option value="">Select</option>
                                                                                                        <c:forEach items="${role.impactedWorks}" var="result">
                                                                                                            <option value="${result}">${result}</option>
                                                                                                        </c:forEach>
                                                                                                    </select>
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