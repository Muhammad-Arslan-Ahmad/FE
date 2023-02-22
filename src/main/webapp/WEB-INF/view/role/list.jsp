<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:wrapper_dashboard title="Roles" bodyheader="Roles">
    <jsp:attribute name="script">
        <script>

            function goToPage(offset) {
                $("#offset").val(offset - 1);
                $("#limit").val(10);
                $("#searchForm").submit();

            }

            function deleteItem(id) {

                var conf = ConfirmDialog("Are you sure?");
                if (conf) {
                    $.ajax({
                        type: "GET",
                        url: "${pageContext.request.contextPath}/role/delete?id=" + id,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            location.reload(true);
                        }

                    })
                }
            }
            
            function ConfirmDialog(message) {
                if (confirm(message)) {
                    return true;
                } else {
                    return false;
                }
            }


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
                                <h4 class="mb-sm-0 font-size-18">Role List</h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="mb-3">
                                <form id="searchForm" action="${pageContext.request.contextPath}/role/list" method="get" class="p-3">
                                    <div class="form-group m-0">
                                        <div class="input-group">
                                            <input name="query" id="input_query_mob" value="${queryString}" type="text" class="form-control" placeholder="Search ..." aria-label="Search Result">
                                            <input name="from" id="offset" type="hidden" />
                                            <input name="size" id="limit" type="hidden" />
                                            <button class="btn btn-primary" type="submit"><i class="mdi mdi-magnify"></i></button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-8">
                            <div class="mb-3">
                                <div class="text-sm-end">
                                    <a href="${pageContext.request.contextPath}/role/home"><button type="button" class="btn btn-success btn-rounded waves-effect waves-light mb-2 me-2" data-bs-toggle="modal" data-bs-target="#myModal"><i class="mdi mdi-plus me-1"></i>Add New Role</button></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="card">
                                <div class="card-body">
                                    
                                        <div class="table-responsive">
                                            <table class="table align-middle mb-0 table-wrap">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Role Name</th>
                                                        <th>Job Title</th>
                                                        <th>Level</th>
                                                        <th>Reporting Role</th>
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="result" items="${results}" varStatus="loop">
                                                    <input type="hidden" id="idRole" value="${result.id}" />
                                                    <tr>
                                                        <td>${result.roleName}</td>
                                                        <td>${result.jobTitle}</td>
                                                        <td>${result.roleAltitudeLevel}</td>
                                                        <td>${result.reportingRole}</td>
                                                        <td>${result.status}</td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/role/edit?id=${result.id}" class="text-dark"><i class="mdi mdi-lead-pencil font-size-18"></i></a>
                                                            <a href="${pageContext.request.contextPath}/role/view?id=${result.id}" class="text-dark"><i class="mdi mdi-view-list font-size-18"></i></a>
                                                            <a href="#" onclick="deleteItem('${result.id}')" class="text-danger"><i class="mdi mdi-delete font-size-18"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        ${paging}
                                </div>
                            </div>
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