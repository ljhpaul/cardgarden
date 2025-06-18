<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../common/header.jsp"%>
<html>
<head>
    <title>Sample List</title>
    <link rel="stylesheet" href="${cpath}/resources/css/sample.css">
</head>
<body>
<h2>Sample List</h2>
<a href="${pageContext.request.contextPath}/sample/addForm">[추 가]</a>
<table border="1">
    <tr>
        <th>ID</th><th>Name</th><th>상세</th><th>수정</th><th>삭제</th>
    </tr>
    <c:forEach var="row" items="${list}">
        <tr>
            <td>${row.id}</td>
            <td>${row.name}</td>
            <td><a href="${cpath}/sample/detail?id=${row.id}">상세</a></td>
            <td><a href="${cpath}/sample/editForm?id=${row.id}">수정</a></td>
            <td><a href="${cpath}/sample/delete?id=${row.id}">삭제</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
