<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="User Creation" bodyheader="User Creation">
    <jsp:attribute name="script">
        <script>
            $(function () {

                $("#basic-pills-wizard").bootstrapWizard(
                        {
                            tabClass: "nav nav-pills nav-justified",
                            onNext: function (tab, navigation, index) {
                                if (${tab != 3}) {

                                    if (index == 1) {

                                        if (!$("#idFirstName").val()) {
                                            alert("Please Enter First Name");
                                            $("#idFirstName").focus();
                                            return false;
                                        }
                                        if (!$("#idLastName").val()) {
                                            alert("Please Enter Last Name");
                                            $("#idLastName").focus();
                                            return false;
                                        }
                                        if (!$("#idEmail").val()) {
                                            alert("Please Enter Email");
                                            $("#idEmail").focus();
                                            return false;
                                        }
                                        if ($("#idEmail").val()) {
                                            var validRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                                            if(!validRegex.test($("#idEmail").val()))
                                            {
                                                alert("Invalid email address");
                                                $("#idEmail").focus();
                                                return false;
                                            }
                                        }
                                        if (!$("#idUserName").val()) {
                                            alert("Please Enter User Name");
                                            $("#idUserName").focus();
                                            return false;
                                        }
                                        if (!$("#idPassword").val()) {
                                            alert("Please Enter Password");
                                            $("#idPassword").focus();
                                            return false;
                                        }

                                        if (!$("#idConfirmPassword").val()) {
                                            alert("Please Enter Confirm Password");
                                            $("#idConfirmPassword").focus();
                                            return false;
                                        }

                                        var orig = $("#idPassword").val();
                                        var conf = $("#idConfirmPassword").val();
                                        if (orig != conf) {
                                            alert("Confirm password doesn't match");
                                            $("#idConfirmPassword").focus();
                                            return false;
                                        }
                                    }
                                    
                                    if (index == 2) {
                                        if (!$("#idCompanyName").val()) {
                                            alert("Please Enter Company Name");
                                            $("#idCompanyName").focus();
                                            return false;
                                        }
                                        if ($("#idCompanyEmail").val()) {
                                            var validRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                                            if(!validRegex.test($("#idCompanyEmail").val()))
                                            {
                                                alert("Invalid email address");
                                                $("#idCompanyEmail").focus();
                                                return false;
                                            }
                                        }
                                    }
                                }
                            }
                        });

                $('#idForm').on('keyup keypress keydown', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
                    }
                });

                $('#idForm input[type=file]').on('change', function (e) {
                    e.preventDefault();
                    var fileList = $("#idFile")[0].files;
                    var totalFile = fileList.length;

                    var formData = new FormData();
                    for (var i = 0; i < totalFile; i++) {
                        formData.append('file', fileList[i]);
                    }
                    $.post({
                        url: '${pageContext.request.contextPath}/user/upload',
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (res) {
                            $("#idImageInput").val(res);
                            $("#idProfileImg").attr("src", "data:image/png;base64," + res);
                        }
                    });

                });

            });
            
            function submitForm() {
                $("#idForm").submit();
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
                                <!--<h4 class="mb-sm-0 font-size-18">Proofs</h4>-->
                            </div>
                        </div>
                    </div>
                    <!-- end page title --> 

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title mb-0">Creation Salesfuse User</h4>
                                </div>
                                <div class="card-body">
                                    <div id="basic-pills-wizard" class="twitter-bs-wizard">
                                        <ul class="twitter-bs-wizard-nav">
                                            <li class="nav-item">
                                                <a href="#user-info" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="User Info">
                                                        1
                                                    </div>
                                                </a>
                                                User Info
                                            </li>
                                            <li class="nav-item">
                                                <a href="#company-info" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="Company Info">
                                                        2
                                                    </div>
                                                </a>
                                                Company Info
                                            </li>

                                            <li class="nav-item">
                                                <a href="#image" class="nav-link" data-toggle="tab">
                                                    <div class="step-icon" data-bs-toggle="tooltip" data-bs-placement="top" title="User Photo">
                                                        3
                                                    </div>
                                                </a>
                                                User Photo
                                            </li>
                                        </ul>
                                        <!-- wizard-nav -->
                                        <form id="idForm" action="${pageContext.request.contextPath}/user/create" method="POST">
                                            <div class="tab-content twitter-bs-wizard-tab-content">
                                                <div class="tab-pane" id="user-info">
                                                    <div class="text-center mb-4">
                                                        <p class="card-title-desc">Fill the information below</p>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idFirstName" name="firstName" value="${user.firstName}" type="text" class="form-control" placeholder="Enter First Name" tabindex="1">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter First Name
                                                                    </div> 
                                                                    <label for="input-username">First Name</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="users"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idEmail" name="email" value="${user.email}" type="email" class="form-control" placeholder="Enter Email" tabindex="4">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Email
                                                                    </div> 
                                                                    <label for="input-email">Email</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="mail"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-4">
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idLastName" name="lastName" value="${user.lastName}" type="text" class="form-control" placeholder="Enter Last Name" tabindex="2">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Last Name
                                                                    </div> 
                                                                    <label for="input-username">Last Name</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="users"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idPassword" name="password" type="password" class="form-control" placeholder="Enter Password" tabindex="5">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Password
                                                                    </div> 
                                                                    <label for="input-password">Password</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="lock"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-4">
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idUserName" name="userName" value="${user.userName}" type="text" class="form-control" id="input-username" placeholder="Enter User Name" tabindex="3">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Username
                                                                    </div> 
                                                                    <label for="input-username">Username</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="users"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idConfirmPassword" type="password" class="form-control" placeholder="Enter Password" tabindex="6">
                                                                    <div class="invalid-feedback">
                                                                        Please Confirm Password
                                                                    </div> 
                                                                    <label for="input-password">Confirm Password</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="lock"></i>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                        <li class="next"><a id="idStepOneNext" href="javascript: void(0);" class="btn btn-primary">Next<i
                                                                    class="bx bx-chevron-right ms-1"></i></a></li>
                                                    </ul>
                                                </div>
                                                <div class="tab-pane" id="company-info">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idCompanyName" name="companyName" value="${user.companyName}" type="text" class="form-control" placeholder="Enter Company Name" tabindex="7">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Company Name
                                                                    </div> 
                                                                    <label for="input-username">Company Name</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="briefcase"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input name="companyPhone" value="${user.companyPhone}" type="text" class="form-control" placeholder="Enter Company Phone" tabindex="10">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Company Phone Number
                                                                    </div> 
                                                                    <label for="input-email">Company Phone Number</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="phone-call"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-4">
                                                            <div class="col-lg-10">
                                                                <div class="form-floating form-floating-custom mb-4">
                                                                    <input id="idCompanyEmail" name="companyEmail" value="${user.companyEmail}" type="email" class="form-control" placeholder="Enter Email"  tabindex="8">
                                                                    <div class="invalid-feedback">
                                                                        Please Enter Company Email
                                                                    </div> 
                                                                    <label for="input-username">Email</label>
                                                                    <div class="form-floating-icon">
                                                                        <i data-feather="mail"></i>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-4">
                                                            <div class="col-lg-10">
                                                                <div class="col-lg-10">
                                                                    <div class="form-floating form-floating-custom mb-4">
                                                                        <input name="companyWeb" value="${user.companyWeb}" type="text" class="form-control" id="input-password" placeholder="Enter Web Address" tabindex="9">
                                                                        <div class="invalid-feedback">
                                                                            Please Enter Company Web Address
                                                                        </div> 
                                                                        <label for="input-password">Web Address</label>
                                                                        <div class="form-floating-icon">
                                                                            <i data-feather="globe"></i>
                                                                        </div>
                                                                    </div>
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

                                                <div class="tab-pane" id="image">
                                                    <div class="row">
                                                        <div class="col-4"></div>
                                                        <div class="col-4">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div class="col">
                                                                        <div class="mb-3">
                                                                            <input type="hidden" name="profileImg" id="idImageInput"/>
                                                                            <img id="idProfileImg" class="mg-fluid square-switch d-block img-thumbnail" src="">
                                                                        </div>
                                                                        <div class="mydropzone">
                                                                            <div class="fallback">
                                                                                <input id="idFile" name="file" type="file">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-4"></div>
                                                    </div>

                                                    <ul class="pager wizard twitter-bs-wizard-pager-link">
                                                        <li class="previous"><a href="javascript: void(0);" class="btn btn-primary" ><i
                                                                    class="bx bx-chevron-left me-1"></i> Previous</a></li>
                                                        <li class="float-end"><a href="javascript: void(0);" class="btn btn-primary" data-bs-toggle="modal"
                                                                                 data-bs-target=".confirmModal">Save User</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </form>                                                       
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
                                    onclick="submitForm();">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:wrapper_dashboard>