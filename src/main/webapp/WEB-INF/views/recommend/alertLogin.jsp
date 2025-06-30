<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty alertMsg}">
    <script>
        alert('${alertMsg}');
        window.location.replace('${pageContext.request.contextPath}/user/login');
    </script>
</c:if>
