<%@tag description="Page template" pageEncoding="UTF-8"%>
<%@attribute name="header" fragment="true" %>
<%@attribute name="menu" fragment="true" %>
<%@attribute name="title" required="false"%>
<%@attribute name="script" fragment="true" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="bodyheader" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>${title} | Salesfuse </title>
        
        <!-- App favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/images/favicon.png">
        
        <!-- preloader css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/preloader.min.css" type="text/css" />
        
        <!-- Bootstrap Css -->
        <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="${pageContext.request.contextPath}/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        
        <jsp:invoke fragment="style"/>

    </head>
    <body data-topbar="">
        <div class="auth-page">
            <div class="container-fluid p-0">
                <div class="auth-full-page-content row g-0">
                    <div class="col-md-4 offset-md-4">
                        <jsp:doBody/>
                    </div>
                    
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/jquery/dist/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/metismenu/dist/metisMenu.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/simplebar/dist/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/node-waves/dist/waves.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/feather-icons/dist/feather.min.js"></script>
        
        <script src="${pageContext.request.contextPath}/resources/assets/libs/pace-js/pace.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/js/pages/feather-icon.init.js"></script>
        <jsp:invoke fragment="script"/>
    </body>
</html>