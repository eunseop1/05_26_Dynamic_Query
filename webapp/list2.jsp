<%@page import="kr.human.service.EmpService"%>
<%@page import="kr.human.vo.EmpVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	//넘어온 데이터를 받아보자
	String deptno = request.getParameter("deptno");
	List<EmpVO> list = EmpService.getInstance().selectList(deptno);
	
	request.setAttribute("list", list);
	request.setAttribute("deptno", deptno);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 목록 보기</title>
<link href="${pageContext.request.servletContext.contextPath }/webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.servletContext.contextPath }/webjars/jquery/3.6.0/jquery.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.servletContext.contextPath }/webjars/bootstrap/5.1.3/js/bootstrap.min.js" ></script>
<script type="text/javascript">
	$(function(){
		$("#deptno").change(function(){
			var value = $("#deptno").val();
			//alert(value);
			location.href="?deptno=" + value
		});
	});
</script>
</head>
<body>
	<select name="deptno" id="deptno">
		<option value="">전체보기</option>
		<option value="10" ${deptno == "10"? " selected " : "" }>10번 부서</option>
		<option value="20" ${deptno == "20"? " selected " : "" }>20번 부서</option>
		<option value="30" ${deptno == "30"? " selected " : "" }>30번 부서</option>
		<option value="40" ${deptno == "40"? " selected " : "" }>40번 부서</option>
	</select>
	<br /><hr />
	
	<c:if test="${empty list }">
		<h2>데이터 없다</h2>
	</c:if>
	<c:if test="${not empty list }">
		<c:forEach var="vo" items="${list }">
			${vo.empno }. ${vo.ename }(${vo.deptno }) <br />
		</c:forEach>
	</c:if>
	
	
</body>
</html>