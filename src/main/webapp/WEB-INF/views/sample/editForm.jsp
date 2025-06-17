<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../common/header.jsp"%>
<html>
<head>
    <title>Sample Edit</title>
</head>
<body>
<h2>샘플 수정</h2>
<form action="${cpath}/sample/edit" method="post">
    <input type="hidden" name="id" value="${dto.id}">
    이름: <input type="text" name="name" value="${dto.name}" required><br>
    <button type="submit">수정</button>
</form>
<a href="${cpath}/sample/list">[목록]</a>
</body>
</html>
