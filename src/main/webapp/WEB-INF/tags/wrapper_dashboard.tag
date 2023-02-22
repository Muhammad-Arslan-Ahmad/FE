<%@tag description="Page template" pageEncoding="UTF-8"%>
<%@attribute name="header" fragment="true" %>
<%@attribute name="menu" fragment="true" %>
<%@attribute name="title" required="false"%>
<%@attribute name="script" fragment="true" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="bodyheader" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>${title} | Salesfuse</title>

        <!-- App favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/assets/images/favicon.png">

        <link href="${pageContext.request.contextPath}/resources/assets/css/jquery-ui.css" rel="stylesheet" type="text/css" />
        <!-- preloader css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/preloader.min.css" type="text/css" />

        <!-- Bootstrap Css -->
        <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="${pageContext.request.contextPath}/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="${pageContext.request.contextPath}/resources/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        
        <link href="${pageContext.request.contextPath}/resources/assets/libs/twitter-bootstrap-wizard/prettify.css" rel="stylesheet" type="text/css" />
        
        <link href="${pageContext.request.contextPath}/resources/assets/libs/dropzone/dist/min/dropzone.min.css" rel="stylesheet" type="text/css" />
        <style>
            .ui-autocomplete { position: absolute; cursor: default;z-index:9999999;}  
            .btn:focus{
                box-shadow:none !important;
            }
        </style>

        <jsp:invoke fragment="style"/>

    </head>
    <body data-topbar="">
        <div id="layout-wrapper">
            <jsp:include page="../common/header.jsp" flush="true"/>
            <jsp:include page="../common/menu.jsp" flush="true"/>
            <jsp:doBody/>
        </div>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/jquery/dist/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/jquery/dist/jquery-ui.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/metismenu/dist/metisMenu.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/simplebar/dist/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/node-waves/dist/waves.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/feather-icons/dist/feather.min.js"></script>
        <!-- pace js -->
        <script src="${pageContext.request.contextPath}/resources/assets/libs/pace-js/pace.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/js/app.js"></script>

        
        <script src="${pageContext.request.contextPath}/resources/assets/libs/twitter-bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/twitter-bootstrap-wizard/prettify.js"></script>

        <!-- form wizard init -->
        <!--<script src="${pageContext.request.contextPath}/resources/assets/js/pages/form-wizard.init.js"></script>-->
        <script src="${pageContext.request.contextPath}/resources/assets/libs/dropzone/dist/min/dropzone.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/tinymce/tinymce.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/libs/jquery.repeater/jquery.repeater.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/js/pages/task-create.init.js"></script>
<!--        <script src="${pageContext.request.contextPath}/resources/assets/libs/pristinejs/dist/pristine.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/assets/js/pages/form-validation.init.js"></script>-->
        
        <script src="${pageContext.request.contextPath}/resources/assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>
        
        <jsp:invoke fragment="script"/>
    </body>
</html>