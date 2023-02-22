<%-- 
    Document   : perpage
    Created on : Jan 20, 2020, 1:48:37 PM
    Author     : ISTL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div style="position:absolute;right:25px;top:8px">
    <div class="row">
        <div class="col pr-1">
            <h6 class="mt-2">Per Page</h6>
        </div>
        <div class="col pl-1">
            <select id="id_rpp" class="custom-select">
                <option value="10" <c:if test="${criteria.limit eq 10}"> selected </c:if>>10</option>
                <option value="20" <c:if test="${criteria.limit eq 20}"> selected </c:if>>20</option>
                <option value="50" <c:if test="${criteria.limit eq 50}"> selected </c:if>>50</option>
                <option value="100" <c:if test="${criteria.limit eq 100}"> selected </c:if>>100</option>
                <option>All</option>
            </select>
        </div>
    </div>
</div>
