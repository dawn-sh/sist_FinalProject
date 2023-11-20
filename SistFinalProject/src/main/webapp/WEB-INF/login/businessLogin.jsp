<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <title>Insert title here</title>
</head>
<body>
<form action="businessLogin">
		<tr>
				<td>
				<div class="b">
				<span class="businessId">사업자번호
				&nbsp;&nbsp;
				<input type="text" name="business_id" id="bNum" style="width: 190px;"
					class="form-control" ></span>
				<br>
				<span class="businessPass">비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="password" name="business_pass" style="width: 190px;"
					class="form-control" ></span>
			</div>	
				</td>
		</tr>	
</form>			
</body>
</html>