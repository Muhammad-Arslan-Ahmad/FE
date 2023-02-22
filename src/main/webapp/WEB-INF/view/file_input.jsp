<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forum </title>
        <s:url var="url_css" value="/static/css/style.css"/>
        <s:url var="url_common_css" value="/static/css/common.css"/>
        <s:url var="url_boot_css" value="/static/css/bootstrap.min.css"/>
        <s:url var="url_data_css" value="/static/css/jquery.dataTables.css"/>
        <s:url var="url_data_min_css" value="/static/css/jquery.dataTables.min.css"/>
        <s:url var="url_jquery" value="/static/js/jquery-3.2.1.min.js"/>
        <s:url var="url_ui_jquery" value="/static/js/jquery-ui.js"/>
        <s:url var="url_dataTable" value="/static/js/jquery.dataTables.min.js"/>
        <link href="${url_css}" rel="stylesheet" type="text/css"/>
        <link href="${url_common_css}" rel="stylesheet" type="text/css"/>
        <link href="${url_boot_css}" rel="stylesheet" type="text/css"/>
        <link href="${url_data_css}" rel="stylesheet" type="text/css"/>
        <link href="${url_data_min_css}" rel="stylesheet" type="text/css"/>
        <script src="${url_jquery}" ></script>
        <script src="${url_ui_jquery}" ></script>
        <script src="${url_dataTable}" ></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#smallChar').change(function () {
                    $("#smallCharBox").toggle();
                });
                $('#capitalChar').change(function () {
                    $("#capitalCharBox").toggle();
                });
                $('#specialChar').change(function () {
                    $("#specialCharBox").toggle();
                });
                $('#digitChar').change(function () {
                    $("#digitCharBox").toggle();
                });
            });

        </script>
    </head>
    <s:url var="url_bg" value="/static/images/bg.jpg"/>
    <body background="${url_bg}" style="background-repeat: no-repeat;background-size: cover">
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <table class="table table-bordered">
                        <tr>
                            <td>
                                <%-- Header --%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%-- Menu --%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%-- Page Content Area--%>
                                <h3>Password Policy</h3>
                                <c:if test="${param.act eq 'empty'}">
                                    <p class="success">Empty data not accepted</p>
                                </c:if>
                                <c:if test="${param.act eq 'sv'}">
                                    <p class="success">Successfully Updated</p>
                                </c:if>
                                <c:if test="${param.act eq 'fa'}">
                                    <p class="success">Update Failed</p>
                                </c:if>
                                <form:form method="POST" action="${pageContext.request.contextPath}/user/policy"  modelAttribute="policy">
                                    <div style="clear:both">
                                        <div style="float:left">
                                            <label>Small Character: </label>
                                            <input type="checkbox" name="small" id="smallChar">
                                        </div>
                                        <div id="smallCharBox" style="display:none;">
                                            <label>&nbsp;&nbsp;Minimum Length for Small Character: </label>
                                            <input type="number" name="smallCharacter">
                                        </div>
                                    </div>
                                    <div style="clear:both">
                                        <div style="float:left">
                                            <label>Capital Character: </label>
                                            <input type="checkbox" name="capital" id="capitalChar">
                                        </div>
                                        <div id="capitalCharBox" style="display:none;">
                                            <label>&nbsp;&nbsp;Minimum Length for Capital Character: </label>
                                            <input type="number" name="capitalCharacter" >
                                        </div>
                                    </div>
                                    <div style="clear:both">
                                        <div style="float:left">
                                            <label>Special Character: </label>
                                            <input type="checkbox" name="special" id="specialChar">
                                        </div>
                                        <div id="specialCharBox" style="display:none;">
                                            <label>&nbsp;&nbsp;Minimum Length for Special Character: </label>
                                            <input type="number" name="specialCharacter">
                                        </div>
                                    </div>
                                    <div style="clear:both">
                                        <div style="float:left">
                                            <label>Digit: </label>
                                            <input type="checkbox" name="digitNumber" id="digitChar">
                                        </div>
                                        <div id="digitCharBox" style="display:none;">
                                            <label>&nbsp;&nbsp;Minimum Length for Digit: </label>
                                            <input type="number" name="digit">
                                        </div>
                                    </div>
                                    <div style="clear:both">
                                        <div>
                                            <label>Minimum Length for Password: </label>
                                            <input type="number" name="length">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success">Save</button>
                                </form:form>
                            </td>
                        </tr>

                        <tr>
                            <td height="25px">
                                <%-- Footer --%>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
