<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../common/header.jsp"%>
<html>
<head>
    <title>Sample Add</title>
</head>
<body>
<h2>샘플 등록</h2>
<form action="${cpath}/sample/add" method="post">
    ID: <input type="text" name="id" required><br>
    이름: <input type="text" name="name" required><br>
    <button type="submit">등록</button>
</form>
<a href="${cpath}/sample/list">[목록]</a>
</body>
</html>
