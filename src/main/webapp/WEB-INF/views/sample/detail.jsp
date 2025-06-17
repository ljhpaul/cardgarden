<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../common/header.jsp"%>
<html>
<head>
    <title>Sample Detail</title>
</head>
<body>
<h2>Sample Detail</h2>
<p>id: ${dto.id}</p>
<p>name: ${dto.name}</p>
<a href="${cpath}/sample/list">[목록]</a>
</body>
</html>
