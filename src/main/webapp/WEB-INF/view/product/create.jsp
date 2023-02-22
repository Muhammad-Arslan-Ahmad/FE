<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Product Creation" bodyheader="Product Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {

                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 6}) {

                                    if (index == 1) {

                                        if (!$("#idProductName").val()) {
                                            alert("Please Enter Product Name");
                                            $("#idProductName").focus();
                                            return false;
                                        }
                                        if(!$("#idForm1 select[name='productCategorySelected']").val()){
                                            alert("Please Select Product Category");
                                            $("#idForm1 select[name='productCategorySelected']").focus();
                                            return false;
                                        }
                                        submitForm1();
                                    }
                                    if (index == 2) {
                                        var name = "inner-group[0][productFeatures]";
                                        var val = $("#idForm2 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm2 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm2();
                                    }
                                    if (index == 3) {
                                        var name = "inner-group[0][productBenefits]";
                                        var val = $("#idForm3 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm3 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm3();
                                    }
                                    if (index == 4) {
                                        var name = "inner-group[0][productCapabilities]";
                                        var val = $("#idForm4 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm4 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm4();
                                    }
                                    if (index == 5) {
                                        var name = "inner-group[0][productRisks]";
                                        var val = $("#idForm5 input[name='" + name + "']").val();
                                        if (val == null || val == '' || val == 'undefined') {
                                            alert("Atleast one value required");
                                            $("#idForm5 input[name='" + name + "']").focus();
                                            return false;
                                        }
                                        submitForm5();
                                    }
                                    if(index == 6){
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

                    var id = $("#productId").val();
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    formData.append("id", id);
                    $.post({
                        url: '${pageContext.request.contextPath}/product/upload',
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
                var id = $("#productId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/product/enrolFirst?id=' + id,
                    data: $('#idForm1').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm2() {
                var id = $("#productId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/product/enrolSecond?id=' + id,
                    data: $('#idForm2').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm3() {
                var id = $("#productId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/product/enrolThird?id=' + id,
                    data: $('#idForm3').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm4() {
                var id = $("#productId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/product/enrolFourth?id=' + id,
                    data: $('#idForm4').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function submitForm5() {
                var id = $("#productId").val();
                $.post({
                    url: '${pageContext.request.contextPath}/product/enrolFifth?id=' + id,
                    data: $('#idForm5').serialize(),
                    success: function (res) {
                        populateFields(res);
                    }
                });
            }

            function populateFields(product) {
                $("#productId").val(product.id);
                $("#productProofId").val(product.id);
                $("#narrationProductId").val(product.id);
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
                var productName = "inner-group[0][statement]";
                var val = $("#idForm7 input[name='" + productName + "']").val();
                for (var i = 0; i < 5; i++) {
                    try {
                        var name = "inner-group[" + i + "][statement]";
                        var itemsName = "inner-group[" + i + "][items]";
                        var productFeaturesName = "inner-group[" + i + "][productFeatures]";
                        var productBenefitsName = "inner-group[" + i + "][productBenefits]";
                        var productCapabilitiesName = "inner-group[" + i + "][productCapabilities]";
                        var productRisksName = "inner-group[" + i + "][productRisks]";


                        var productFeaturesVal = $("#idForm7 select[name='" + productFeaturesName + "']").val();
                        var productBenefitsVal = $("#idForm7 select[name='" + productBenefitsName + "']").val();
                        var productCapabilitiesVal = $("#idForm7 select[name='" + productCapabilitiesName + "']").val();
                        var productRisksVal = $("#idForm7 select[name='" + productRisksName + "']").val();
                        
                        var statement = "Our {_name}, which is part of our {_productCategorySelected} has a {_productFeatures}  that helps our customers {_productBenefits}. They see the value provided by our {_productCapabilities} that is very focused on {_productRisks}";
                        $("#idForm7 input[name='" + name + "']").val(statement);
                        var items = "_name=" + val + ",_productCategorySelected=${product.productCategorySelected},_productFeatures=" + productFeaturesVal + ",_productBenefits=" + productBenefitsVal + ",_productCapabilities=" + productCapabilitiesVal + ",_productRisks=" + productRisksVal;
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
                                <h4 class="mb-sm-0 font-size-18">Product</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Product Creation Wizard</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#product" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Product">
                                                        1
                                                    </div>
                                                </a>
                                                Product
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm1()" href="#features" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Product Features">
                                                        2
                                                    </div>
                                                </a>
                                                Product Features
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm2()" href="#benefits" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Product Benefits">
                                                        3
                                                    </div>
                                                </a>
                                                Product Benefits
                                            </li>
                                            <li class="nav-item">
                                                <a onclick="submitForm3()" href="#capabilities" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Capabilities Provided">
                                                        4
                                                    </div>
                                                </a>
                                                Capabilities Provided
                                            </li>

                                            <li onclick="submitForm4()" class="nav-item">
                                                <a href="#risks" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Buyer Risks">
                                                        5
                                                    </div>
                                                </a>
                                                Buyer Risks
                                            </li>

                                            <li onclick="submitForm5()" class="nav-item">
                                                <a href="#proof" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Proof Names">
                                                        6
                                                    </div>
                                                </a>
                                                Proof Names
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
                                            <div class="tab-pane" id="product">
                                                <div class="text-center mb-4">
                                                    <p class="card-title-desc">Fill the information below</p>
                                                </div>
                                                <input id="productId" type="hidden" name="id" value="${product.id}"/>
                                                <form id="idForm1" action="${pageContext.request.contextPath}/product/enrolFirst" method="POST" class="needs-validation" novalidate="">

                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="idProductName" class="form-label">* Name of the product</label>
                                                                    <input name="name" value="${product.name}" type="text" class="form-control" placeholder="Product Name" id="idProductName" required="">
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">What altitude level most appreciates this feature?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="productFeatureAltitude"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="productFeatureAltitude"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${product.productFeatureAltitude eq 'No'}">checked</c:if> >
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
                                                                            <label class="form-label">* Please select the main product category</label>
                                                                            <select name="productCategorySelected" class="form-select" required="false">
                                                                                <option value="">Select</option>
                                                                            <c:forEach items="${categories}" var="result">
                                                                                <option value="${result.name}" <c:if test="${result.name eq product.productCategorySelected}">selected</c:if>>${result.name}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="col-lg-10">
                                                                <div class="mb-3">
                                                                    <label for="basicpill-lastname-input" class="form-label">Is this a competitive advantage you want to emphasize with your buyers?</label>
                                                                    <div class="row" style="margin-left: 10px;">
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="productBenefitAdvantage"
                                                                                   id="formRadios1" checked value="Yes" required="false">
                                                                            <label class="form-check-label" for="formRadios1">
                                                                                Yes
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-4">
                                                                            <input class="form-check-input" type="radio" name="productBenefitAdvantage"
                                                                                   id="formRadios2" required="false" value="No" <c:if test="${product.productBenefitAdvantage eq 'No'}">checked</c:if> >
                                                                                   <label class="form-check-label" for="formRadios2">
                                                                                       No
                                                                                   </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-10">
                                                                    <div class="mb-3">
                                                                        <label for="basicpill-lastname-input" class="form-label">Is this a capability you want to emphasize with your buyers?</label>
                                                                        <div class="row" style="margin-left: 10px;">
                                                                            <div class="form-check col-4">
                                                                                <input class="form-check-input" type="radio" name="productCapabilityHighlight"
                                                                                       id="formRadios1" checked value="Yes" required="false">
                                                                                <label class="form-check-label" for="formRadios1">
                                                                                    Yes
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-4">
                                                                                <input class="form-check-input" type="radio" name="productCapabilityHighlight"
                                                                                       id="formRadios2" required="false" value="No" <c:if test="${product.productCapabilityHighlight eq 'No'}">checked</c:if> >
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
                                            <div class="tab-pane" id="features">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <form id="idForm2" action="${pageContext.request.contextPath}/product/enrolSecond" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What is a feature of this product?</label>

                                                                            <c:choose>
                                                                                <c:when test="${product.productFeatures ne null and fn:length(product.productFeatures) > 0}">
                                                                                    <c:forEach items="${product.productFeatures}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="productFeatures" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="productFeatures" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Feature"/>
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

                                        <div class="tab-pane" id="benefits">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm3" action="${pageContext.request.contextPath}/product/enrolThird" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What is a benefit of this product?</label>
                                                                            <c:choose>
                                                                                <c:when test="${product.productBenefits ne null and fn:length(product.productBenefits) > 0}">
                                                                                    <c:forEach items="${product.productBenefits}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="productBenefits" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="productBenefits" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Benifit"/>
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

                                        <div class="tab-pane" id="capabilities">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm4" action="${pageContext.request.contextPath}/product/enrolFourth" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What does your company specifially do to help them be successful?</label>
                                                                            <c:choose>
                                                                                <c:when test="${product.productCapabilities ne null and fn:length(product.productCapabilities) > 0}">
                                                                                    <c:forEach items="${product.productCapabilities}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="productCapabilities" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="productCapabilities" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Capability"/>
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
                                        <div class="tab-pane" id="risks">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm5" action="${pageContext.request.contextPath}/product/enrolFifth" method="POST" class="needs-validation" novalidate="">

                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What happens if buyer's don't choose you?</label>
                                                                            <c:choose>
                                                                                <c:when test="${product.productRisks ne null and fn:length(product.productRisks) > 0}">
                                                                                    <c:forEach items="${product.productRisks}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="productRisks" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="productRisks" type="text" class="inner form-control" required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Risk"/>
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

                                        <div class="tab-pane" id="proof">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <form id="idForm6" action="${pageContext.request.contextPath}/product/enrolSixth" method="POST" class="needs-validation" novalidate="">
                                                                <input id="productProofId" type="hidden" name="id" value="${product.id}"/>
                                                                <div data-repeater-list="outer-group" class="outer">
                                                                    <div class="outer-repeater mb-4">
                                                                        <div data-repeater-list="inner-group" class="inner form-group mb-0 row">
                                                                            <label class="col-form-label col-lg-2">What is the name of this proof?</label>
                                                                            <c:choose>
                                                                                <c:when test="${product.proofNames ne null and fn:length(product.proofNames) > 0}">
                                                                                    <c:forEach items="${product.proofNames}" var="result">
                                                                                        <div  data-repeater-item class="inner col-lg-10 ms-md-auto">
                                                                                            <div class="mb-3 row align-items-center">
                                                                                                <div class="col-md-6">
                                                                                                    <input name="proofNames" value="${result}" type="text" class="inner form-control" required=""/>
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
                                                                                                <input name="proofNames" type="text" class="inner form-control"  required=""/>
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
                                                                                <input data-repeater-create type="button" class="btn btn-success inner" value="Add Another Proof"/>
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
                                                    <form id="idForm7" action="${pageContext.request.contextPath}/product/enrolSeventh" method="POST" class="needs-validation" novalidate="">
                                                        <input id="narrationProductId" type="hidden" name="id" value="${product.id}"/>
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
                                                                                                <input id="idNarration" name="statement" type="hidden" value="${product.name}"/>
                                                                                                <input name="items" type="hidden" value=""/>
                                                                                                Our <input type="text" style="width: 200px;" value="${product.name}"/>, which is part of our
                                                                                                <input type="text" style="width: 200px;" value="${product.productCategorySelected}"/>
                                                                                                has a <br><br>
                                                                                                <select name="productFeatures" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${product.productFeatures}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                that helps our customers
                                                                                                <select name="productBenefits" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${product.productBenefits}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                . They see the value provided by our <br><br>
                                                                                                <select name="productCapabilities" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${product.productCapabilities}" var="result">
                                                                                                        <option value="${result}">${result}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                                that is very focused on  
                                                                                                <select name="productRisks" style="width: 200px;"  required="">
                                                                                                    <option value="">Select</option>
                                                                                                    <c:forEach items="${product.productRisks}" var="result">
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