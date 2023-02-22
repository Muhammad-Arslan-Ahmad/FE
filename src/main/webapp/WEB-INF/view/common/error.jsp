<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<t:wrapper title="Error Page" bodyheader="Error Page">
    <jsp:attribute name="script">
        <script>

//            $(document).ready(function () {
//                this.getElementById("id_menu_case").className = "active";
//            });
//
//            function goBack() {
//                window.history.back();
//            }

        </script>
    </jsp:attribute>
    <jsp:body>
        <h1 style="color: red" class="text-center"><br><br>${error.errorcode}</h1>
        <h2 style="color: red" class="text-center"><br><br>${error.errorMessage}</h2>

    </jsp:body>
</t:wrapper>