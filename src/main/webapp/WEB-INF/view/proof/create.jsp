<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Proof Creation" bodyheader="Proof Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {
                
                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 3}) {

                                    if (index == 1) {

                                        if (!$("#idProofName").val()) {
                                            alert("Please Enter Proof Name");
                                            $("#idProofName").focus();
                                            return false;
                                        }
                                        if (!$("#idForm1 input[name='proofOrganization']").val()) {
                                            alert("Please Enter Proof Organization");
                                            $("#idForm1 input[name='proofOrganization']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 select[name='productAlignment']").val()){
                                            alert("Please Select Product Alignment");
                                            $("#idForm1 select[name='productAlignment']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='proofImpact']").val()){
                                            alert("Please Enter Proof Impact");
                                            $("#idForm1 input[name='proofImpact']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='proofTitle']").val()){
                                            alert("Please Enter Proof Title");
                                            $("#idForm1 input[name='proofTitle']").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 input[name='proofContent']").val()){
                                            alert("Please Enter Proof Content");
                                            $("#idForm1 input[name='proofContent']").focus();
                                            return false;
                                        }
                                        submitForm1();
                                    }
                                    if (index == 2) {
                                        submitForm2();
                                    }
                                    if (index == 3) {
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

                    var id = $("#proofId").val();
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    formData.append("id", id);
                    $.post({
                        url: '${pageContext.request.contextPath}/proof/upload',
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

            function populateFields(proof) {
                $("#proofId").val(proof.id);
                $("#customerQuoteId").val(proof.id);
                $("#narrationProofId").val(proof.id);
            }

            function submitForm1() {
                var id = $("#proofId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/proof/enrolFirst?id=' + id,
                    data: $('#idForm1').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm2() {
                var id = $("#proofId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/proof/enrolSecond?id=' + id,
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
                        var statement = "We recently worked with ${proof.proofOrganization} , whom we helped with ${proof.productAlignment} that helped them ${proof.proofImpact} . When they were successful with that, the ${proof.proofTitle} shared ${proof.proofContent}.";
                        $("#idForm4 input[name='" + name + "']").val(statement);
                        var items = "_proofOrganization=${proof.proofOrganization},_productAlignment=${proof.productAlignment},_proofImpact=${proof.proofImpact},_proofTitle=${proof.proofTitle},_proofContent=${proof.proofContent}";
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
                                <h4 class="mb-sm-0 font-size-18">Proofs</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Proof Creation Wizard</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#proof" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Proof">
                                                        1
                                                    </div>
                                                </a>
                                                Proof
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#story" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Customer Story">
                                                        2
                                                    </div>
                                                </a>
                                                Customer Story
                                            </li>

                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#quote" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Customer Quote">
                                                        3
                                                    </div>
                                                </a>
                                                Customer Quote
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
                                            <div class="tab-pane" id="proof">
                                                <div class="text-center mb-4">
                                                    <p class="card-title-desc">Fill the information below</p>
                                                </div>
                                                <input id="proofId" type="hidden" name="id" value="${proof.id}"/>
                                                <form id="idForm1" action="${pageContext.request.contextPath}/proof/enrolFirst" method="POST" class="needs-validation" novalidate="">

                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idProofName" class="form-label">* What is the name of this proof?</label>
                                                                    <input name="proofName" value="${proof.proofName}" type="text" class="form-control" placeholder="Name of the proof is ..." id="idProofName" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idTitles" class="form-label">* What is the name of the person's organization?</label>
                                                                    <input name="proofOrganization" value="${proof.proofOrganization}" type="text" class="form-control" placeholder="Name of the person's organization..." required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idTitles" class="form-label">* What is the main point shared by the person providing the proof?</label>
                                                                    <input name="proofImpact" value="${proof.proofImpact}" type="text" class="form-control" placeholder="Proof impact is ..." required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">What type of proof is this?</label>
                                                                        <select name="proofType" class="form-select" required="false">
                                                                            <option value="">Select</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                    <div class="mb-3">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">* What product does this proof align to?</label>
                                                                            <select name="productAlignment" class="form-select" required="false">
                                                                                <option value="">Select</option>
                                                                            <c:forEach items="${products}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq proof.productAlignment}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- second column -->
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idTitles" class="form-label">* What is the title of the person providing the proof?</label>
                                                                    <input name="proofTitle" value="${proof.proofTitle}" type="text" class="form-control" placeholder="Person title is ..." required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">What altitude level is the person providing the proof?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="proofAltitude"
                                                                                   id="formRadios1" checked value="Executive" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Executive
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="proofAltitude"
                                                                                   id="formRadios2" required="false" value="Manager" <c:if test="${proof.proofAltitude eq 'Manager'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       Manager
                                                                                   </label>
                                                                            </div>
                                                                            <div class="form-check col-4">
                                                                                <input class="form-check-input" type="radio" name="proofAltitude"
                                                                                       id="formRadios3" value="Practitioner" required="false" <c:if test="${proof.proofAltitude eq 'Practitioner'}">checked</c:if>>
                                                                                <label class="form-check-label" for="formRadios3">
                                                                                    Practitioner
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idTitles" class="form-label">* What do you want to share for proof?</label>
                                                                    <input name="proofContent" value="${proof.proofContent}" type="text" class="form-control" placeholder="Proof content is ..." required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idTitles" class="form-label">Where does this proof reside?</label>
                                                                    <input name="proofLink" value="${proof.proofLink}" type="text" class="form-control" placeholder="Proof reside in ..." required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">Is this a referenceable account you want to emphasize with your buyers?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="proofReferenceableAccount"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="proofReferenceableAccount"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${proof.proofReferenceableAccount eq 'No'}">checked</c:if> >
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
                                                <div class="tab-pane" id="story">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <form id="idForm2" action="${pageContext.request.contextPath}/proof/enrolSecond" method="POST" class="needs-validation" novalidate="">

                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">Customer Stories</label>

                                                                                <c:choose>
                                                                                    <c:when test="${proof.customerStories ne null and fn:length(proof.customerStories) > 0}">
                                                                                        <c:forEach items="${proof.customerStories}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="customerStories" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                    <input name="customerStories" type="text" class="inner form-control" required=""/>
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Story"/>
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

                                            <div class="tab-pane" id="quote">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm3" action="${pageContext.request.contextPath}/proof/enrolThird" method="POST" class="needs-validation" novalidate="">
                                                                    <input id="customerQuoteId" type="hidden" name="id" value="${proof.id}"/>
                                                                    <div data-repeater-list="outer-group" class="outer">
                                                                        <div class="outer-repeater mb-4">
                                                                            <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                                <label class="col-form-label col-lg-2">Customer Quote</label>
                                                                                <c:choose>
                                                                                    <c:when test="${proof.customerQuotes ne null and fn:length(proof.customerQuotes) > 0}">
                                                                                        <c:forEach items="${proof.customerQuotes}" var="result">
                                                                                            <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                                <div class="mb-3 row align-items-center">
                                                                                                    <div class="col-md-6">
                                                                                                        <input name="customerQuotes" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                    <input name="customerQuotes" type="text" class="inner form-control"  required=""/>
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
                                                                                    <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Quote"/>
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
                                                    <li class="next"><a id="idStepSixNext" href="javascript: void(0);" class="btn btn-primary">Preview<i
                                                                class="bx bx-chevron-right ms-1"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="tab-pane" id="preview">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <form id="idForm4" action="${pageContext.request.contextPath}/proof/enrolFourth" method="POST" class="needs-validation" novalidate="">
                                                            <input id="narrationProofId" type="hidden" name="id" value="${proof.id}"/>
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
                                                                                                    <input name="statement" type="hidden" value="${proof.proofName}"/>
                                                                                                    <input name="items" type="hidden" value=""/>
                                                                                                    We recently worked with <input type="text" style="width: 200px;" value="${proof.proofOrganization}"/>, whom we helped with
                                                                                                    <input type="text" style="width: 200px;" value="${proof.productAlignment}"/> that helped them <br><br>
                                                                                                    <input type="text" style="width: 200px;" value="${proof.proofImpact}"/>.  When they were successful with that, the 
                                                                                                    <input type="text" style="width: 200px;" value="${proof.proofTitle}"/> shared <br><br> 
                                                                                                    <input type="text" style="width: 200px;" value="${proof.proofContent}"/> . 
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