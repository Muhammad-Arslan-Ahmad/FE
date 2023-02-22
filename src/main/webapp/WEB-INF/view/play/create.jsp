<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Play Creation" bodyheader="Play Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {
                
                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 5}) {

                                    if (index == 1) {

                                        if (!$("#idPlayName").val()) {
                                            alert("Please Enter Play Name");
                                            $("#idPlayName").focus();
                                            return false;
                                        }
                                        if(!$("#idPlayBusinessOutcome").val()){
                                            alert("Please Enter Business Outcome");
                                            $("#idPlayBusinessOutcome").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='playProductCategory']").val()){
                                            alert("Please Enter Product Category");
                                            $("#idForm1 input[name='playProductCategory']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='playStartStr']").val()){
                                            alert("Please Enter Play Start Date");
                                            $("#idForm1 input[name='playStartStr']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='playEndStr']").val()){
                                            alert("Please Enter Play End Date");
                                            $("#idForm1 input[name='playEndStr']").focus();
                                            return false;
                                        }
                                        submitForm1();
                                    }
                                    if (index == 2) {
                                        var name = "inner-group[0][playProductNames]";
                                        var val = $("#idForm2 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm2 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm2();
                                    }
                                    if (index == 3) {
                                        var name = "inner-group[0][playRoles]";
                                        var val = $("#idForm3 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm3 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm3();
                                    }
                                    if (index == 4) {
                                        var name = "inner-group[0][playIndustry]";
                                        var val = $("#idForm4 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm4 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm4();
                                    }
                                    if (index == 5) {
                                        var name = "inner-group[0][playWinThemes]";
                                        var val = $("#idForm5 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm5 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm5();
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


                for (var i = 0; i < "${tab}"; i++) {
                    $('#basic-pills-wizard').bootstrapWizard('next');
                }

                $('#idForm1 input[type=file]').on('change', function (e) {

                    var id = $("#playId").val();
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    formData.append("id", id);
                    $.post({
                        url: '${pageContext.request.contextPath}/play/upload',
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
                var id = $("#playId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/play/enrolFirst?id=' + id,
                    data: $('#idForm1').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm2() {
                var id = $("#playId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/play/enrolSecond?id=' + id,
                    data: $('#idForm2').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm3() {
                var id = $("#playId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/play/enrolThird?id=' + id,
                    data: $('#idForm3').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm4() {
                var id = $("#playId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/play/enrolFourth?id=' + id,
                    data: $('#idForm4').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
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

            function populateFields(play) {
                $("#playId").val(play.id);
                $("#playThemeId").val(play.id);
                $("#narrationPlayId").val(play.id);
            }

            function submitForm5() {
                $("#idForm5").submit();
            }
            
            function getPosition() {
                var count = 0;
                $("#idRepeater :input").each(function (e) {
                    var name = this.name;
                    if (name.includes("position")) {
                        $("#idForm6 input[name='" + name + "']").val(count);
                        count++;
                    }
                });
            }
            
            function submitForm6() {
                var name = "inner-group[0][statement]";
                var val = $("#idForm6 input[name='" + name + "']").val();
                for (var i = 0; i < 5; i++) {
                    var name = "inner-group[" + i + "][statement]";
                    var itemsName = "inner-group[" + i + "][items]";
                    var playRolesName = "inner-group[" + i + "][playRoles]";
                    var playProductNamesName = "inner-group[" + i + "][playProductNames]";
                    var playWinThemesName = "inner-group[" + i + "][playWinThemes]";


                    var playRolesVal = $("#idForm6 select[name='" + playRolesName + "']").val();
                    if (playRolesVal != null && playRolesVal != '' && playRolesVal != 'undefined') {
                        var playProductNamesVal = $("#idForm6 select[name='" + playProductNamesName + "']").val();
                        var playWinThemesVal = $("#idForm6 select[name='" + playWinThemesName + "']").val();
                        var statement = "We have a business objective to ${play.playBusinessOutcome}.  We’re running a play called "+val+" to achieve that objective.  We’ll run this play from ${play.playStartStr}  to ${play.playEndStr}, where we’ll target "+playRolesVal+"  to help them see how our ${play.playProductCategory} help through our "+playProductNamesVal+" We will win because "+playWinThemesVal+".  ";
                        $("#idForm6 input[name='" + name + "']").val(statement);
                        var items = "_playBusinessOutcome=${play.playBusinessOutcome},_playName="+val+",_playStart=${play.playStartStr},_playEnd=${play.playEndStr},_playRoles="+playRolesVal+",_playProductCategory=${play.playProductCategory},_playProductNames="+playProductNamesVal+",_playWinThemes="+playWinThemesVal;
                        $("#idForm6 input[name='" + itemsName + "']").val(items);
                    } else {
                        break;
                    }
                }

                $("#idForm6").submit();
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
                                <h4 class="mb-sm-0 font-size-18">Play</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Play Creation Wizard</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#play" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Play">
                                                        1
                                                    </div>
                                                </a>
                                                Play
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#products" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Products">
                                                        2
                                                    </div>
                                                </a>
                                                Products
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#roles" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Roles">
                                                        3
                                                    </div>
                                                </a>
                                                Roles
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm3()" href="#industries" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Industries">
                                                        4
                                                    </div>
                                                </a>
                                                Industries
                                            </li>

                                            <li onclick="submitForm4()" class="nav-item">
                                                <a href="#themes" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Themes">
                                                        5
                                                    </div>
                                                </a>
                                                Themes
                                            </li>
                                            
                                            <li onclick="submitForm5()" class="nav-item">
                                                <a href="#preview" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Preview">
                                                        6
                                                    </div>
                                                </a>
                                                Preview
                                            </li>
                                        </ul>
                                        <!-- wizard-nav -->

                                        <div class="tab-content twitter-bs-wizard-tab-content">
                                            <div class="tab-pane" id="play">
                                                <div class="text-center mb-4">
                                                    <p class="card-title-desc">Fill the information below</p>
                                                </div>
                                                <input id="playId" type="hidden" name="id" value="${play.id}"/>
                                                <form id="idForm1" action="${pageContext.request.contextPath}/play/enrolFirst" method="POST" class="needs-validation" novalidate="">

                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idPlayName" class="form-label">* Name of the play</label>
                                                                    <input name="playName" value="${play.playName}" type="text" class="form-control" placeholder="Play Name" id="idPlayName" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label class="form-label">* What outcome do you want to achieve with this play?</label>
                                                                    <input id="idPlayBusinessOutcome" name="playBusinessOutcome" value="${play.playBusinessOutcome}" type="text" class="form-control" placeholder="Business Outcomes"  required="">
                                                                </div>
                                                            </div>
<!--                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label class="form-label">What industry are you selling to in this play?</label>
                                                                    <input name="playIndustry" value="${play.playIndustry}" type="text" class="form-control" placeholder="Play Industry Name" required="">
                                                                </div>
                                                            </div>-->
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">What type of solutions are you selling in this play?</label>
                                                                        <select name="playSolutionType" class="form-select" required="false">
                                                                            <option value="">Select</option>
                                                                            <c:forEach items="${solutions}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq play.playSolutionType}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label class="form-label">* What solution area does this product map to, if any?</label>
                                                                    <input name="playProductCategory" value="${play.playProductCategory}" type="text" class="form-control" placeholder="Product Category ... " required="">
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label class="form-label">* When does this play start?</label>
                                                                    <input name="playStartStr" id="example-date-input" value="${play.playStartStr}" type="date" class="form-control" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label class="form-label">* When does this play end?</label>
                                                                    <input name="playEndStr" id="example-date-input" value="${play.playEndStr}" type="date" class="form-control" required="">
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
                                                </form>
                                                <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                    <li class="next"><a id="idStepOneNext" href="javascript: void(0);" class="btn btn-primary">Next<i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>

                                                </ul>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="products">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm2" action="${pageContext.request.contextPath}/play/enrolSecond" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What product are you trying to sell? Be as granular as possible</label>

                                                                            <c:choose>
                                                                                <c:when test="${play.playProductNames ne null and fn:length(play.playProductNames) > 0}">
                                                                                    <c:forEach items="${play.playProductNames}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="playProductNames" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="playProductNames" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Product"/>
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

                                        <div class="tab-pane" id="roles">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm3" action="${pageContext.request.contextPath}/play/enrolThird" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">Which specific buyer role are you targeting with this play?</label>
                                                                            <c:choose>
                                                                                <c:when test="${play.playRoles ne null and fn:length(play.playRoles) > 0}">
                                                                                    <c:forEach items="${play.playRoles}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="playRoles" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="playRoles" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Role"/>
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

                                        <div class="tab-pane" id="industries">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm4" action="${pageContext.request.contextPath}/play/enrolFourth" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What industry are you selling to in this play?</label>
                                                                            <c:choose>
                                                                                <c:when test="${play.playIndustry ne null and fn:length(play.playIndustry) > 0}">
                                                                                    <c:forEach items="${play.playIndustry}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="playIndustry" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="playIndustry" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Role Altitude"/>
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
                                        <div class="tab-pane" id="themes">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm5" action="${pageContext.request.contextPath}/play/enrolFifth" method="POST" class="needs-validation" novalidate="">
                                                                <input id="playThemeId" type="hidden" name="id" value="${play.id}"/>
                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">Why will buyers choose you over the competition? </label>
                                                                            <c:choose>
                                                                                <c:when test="${play.playWinThemes ne null and fn:length(play.playWinThemes) > 0}">
                                                                                    <c:forEach items="${play.playWinThemes}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="playWinThemes" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="playWinThemes" type="text" class="inner form-control"  required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Theme"/>
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
                                                    <form id="idForm6" action="${pageContext.request.contextPath}/play/enrolSixth" method="POST" class="needs-validation" novalidate="">
                                                        <input id="narrationPlayId" type="hidden" name="id" value="${play.id}"/>
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
                                                                                                <input name="statement" type="hidden" value="${play.playName}"/>
                                                                                                <input name="items" type="hidden" value=""/>
                                                                                                We have a business objective to <input type="text" style="width: 200px;" value="${play.playBusinessOutcome}"/>. We’re running a play called
                                                                                                <input type="text" style="width: 200px;" value="${play.playName}"/> to achieve <br><br> that objective.  We’ll run this play 
                                                                                                from <input type="text" style="width: 200px;" value="${play.playStartStr}"/> to <input type="text" style="width: 200px;" value="${play.playEndStr}"/>, 
                                                                                                where we will <br><br>
                                                                                                target
                                                                                                <select name="playRoles" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${play.playRoles}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                to help them see how our 
                                                                                                <input type="text" style="width: 200px;" value="${play.playProductCategory}"/> 
                                                                                                help through our <br><br>
                                                                                                <select name="playProductNames" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${play.playProductNames}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                We will win because 
                                                                                                <select name="playWinThemes" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${play.playWinThemes}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select> .  
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
                                onclick="submitForm6();">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</jsp:body>
</t:wrapper_dashboard>