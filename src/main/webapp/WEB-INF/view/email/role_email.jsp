<%-- 
    Document   : role_email
    Created on : Nov 17, 2022, 12:36:01 AM
    Author     : anwar
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<p>
    Subject line: <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${proofs}" var="result">
                        <option value="${result.proofImpact}">${result.proofImpact}</option>
                    </c:forEach>
                    </select> <br><br>
                    [GREETING] [CONTACT FIRST NAME], <br><br>
    The reason for my reaching out to you today is to let you know how we have worked with <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${proofs}" var="result">
                        <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                    </c:forEach>
                    </select>
                    and <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${proofs}" var="result">
                        <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                    </c:forEach>
                    </select> to solve challenges with <c:out value="${map['_expectations']}"/>.
    We helped to solve that with our <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${plays}" var="result">
                        <option value="${result.playProductCategory}">${result.playProductCategory}</option>
                    </c:forEach>
                    </select> solutions. <br><br>
    Our collaborative work with <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${proofs}" var="result">
                        <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                    </c:forEach>
                    </select> and <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${proofs}" var="result">
                        <option value="${result.proofOrganization}">${result.proofOrganization}</option>
                    </c:forEach>
                    </select> not only helped them to <select style="width: 200px;"  required="">
                    <option value="">Select</option>
                    <c:forEach items="${proofs}" var="result">
                        <option value="${result.proofImpact}">${result.proofImpact}</option>
                    </c:forEach>
                    </select>, we were ultimately able to 
                    <select style="width: 200px;"  required="">
                        <option value="">Select</option>
                        <c:forEach items="${messages}" var="result">
                            <c:forEach items="${result.messageValuePoints}" var="r">
                                <option value="${r}">${r}</option>
                            </c:foreach>
                        </c:forEach>
                    </select> and <select style="width: 200px;"  required="">
                        <option value="">Select</option>
                        <c:forEach items="${messages}" var="result">
                            <c:forEach items="${result.messageValuePoints}" var="r">
                                <option value="${r}">${r}</option>
                            </c:foreach>
                        </c:forEach>
                    </select> .
    I don't know if we can help you the same way or even if this is a challenge you face. That is why I am reaching out to understand your challenges better and discuss how we can help you and your organization.
    Are you available for a brief 15-minute call where we can discuss your unique situation, and you can see how we may be able to help? <br><br>
    Meanwhile, I’ll keep researching your organization to see if there are other areas of focus where we have solutions to help. Expect to hear from me as I learn more about your organization and provide you with those details. Do not hesitate to let me know when you determine an area of focus for us to discuss, and I will make time for us to speak.  
    <br><br>
    [LETTER_CLOSE],<br><br>
    [Email Signature]<br><br>
    [Unsubscribe note]<br><br>

</p>