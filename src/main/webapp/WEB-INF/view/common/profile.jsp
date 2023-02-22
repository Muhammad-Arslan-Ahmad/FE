<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Home" bodyheader="Home">
    <jsp:attribute name="script">
        
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

                    <div class="row">
                        <div class="col-xl-12">
                            <div class="profile-user"></div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="profile-content">
                            <div class="row align-items-end">
                                <div class="col-sm">
                                    <div class="d-flex align-items-end mt-3 mt-sm-0">
                                        <div class="flex-shrink-0">
                                            <div class="avatar-xxl me-3">
                                                <img src="{% static 'images/users/avatar-3.jpg'%}" alt="" class="img-fluid rounded-circle d-block img-thumbnail">
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div>
                                                <h5 class="font-size-16 mb-1">${user.firstName} &nbsp; ${user.lastName} </h5>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card bg-transparent shadow-none">
                                <div class="card-body">
                                    <ul class="nav nav-tabs-custom card-header-tabs border-top mt-2" id="pills-tab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link px-3 active" data-bs-toggle="tab" href="#overview" role="tab">Overview</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xl-8 col-lg-8">
                            <div class="tab-content">
                                <div class="tab-pane active" id="overview" role="tabpanel">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">About</h5>
                                        </div>

                                        <div class="card-body">
                                            <div>
                                                <div class="pb-3">
                                                    <h8 class="font-size-15">Email : ${user.email}</h8>
                                                    
                                                </div>

                                                <div class="pt-3">
                                                    <h8 class="font-size-15">Phone : ${user.phone}</h8>
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end card body -->
                                    </div>
                                    <!-- end card -->
                                </div>
                                <!-- end tab pane -->

                                
                            </div>
                            <!-- end tab content -->
                        </div>
                    </div>
                    <!-- end row -->
                    
                </div> <!-- container-fluid -->
            </div>
            <!-- End Page-content -->
            <jsp:include page="../common/footer.jsp" flush="true"/>
        </div>
    </jsp:body>
</t:wrapper_dashboard>