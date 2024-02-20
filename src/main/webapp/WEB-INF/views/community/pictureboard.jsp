<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.codec.binary.Base64"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--      hiredate 날짜 포맷 형식 변경 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript"></script>

<title>Insert title here</title>
</head>
<style>
body {
	font-family: Arial, sans-serif;
	color: #333;
	line-height: 1.6;
}


.container {
	padding: 30px;
	width:100%;
	height: 600px;
}

.item a {
	font-weight: bold;
	font-size: 20px;
	color: #333;
	text-decoration: none;
}

.content {
	padding: 20px;
}

.row {
	display: flex;
	flex-wrap: wrap;
}



.card-img-top {
	width: 100%;
	height: 100px;
	object-fit : cover;
}

.card-title {
	font-size: 20px;
	margin-bottom: 10px;
}

.card-text {
	font-size: 14px;
	color: #777;
}

.table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	border: 1px solid #dee2e6;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f8f9fa;
}

a {
	color: #007bff;
	text-decoration: none;
}

a:hover {
	color: #0056b3;
}

.pagination {
	display: flex;
	justify-content: center;
	padding: 10px 0;
}

.pagination ul {
	display: flex;
	justify-content: center;
	list-style-type: none;
	padding: 0;
}

.pagination li {
	margin: 0 5px;
}

.pagination a {
	display: block;
	padding: 5px 10px;
	background-color: #f8f9fa;
	color: #333;
	text-decoration: none;
}

.pagination a:hover {
	background-color: #007bff;
	color: #fff;
}

.search-form {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.search-form select, .search-form input {
	margin-right: 10px;
	padding: 5px;
}

.search-form button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 5px 10px;
	cursor: pointer;
}

.search-form button:hover {
	background-color: #0056b3;
}
</style>

<body>


      </div>
		<div class="info">
			<div>
				<h3><b>행사앨범</b></h3>
			</div>
		</div>
		<div class="container">
			<div class="row row-cols-5">
				<c:forEach items="${picture_list}" var="picturedto">
					<c:set var="imageType"
						value="${fn:endsWith(picturedto.filename, '.jpg') ? 'image/jpeg' : 'image/png'}" />
					<div class="col">
						<div class="card" style="width: 200px;">
							<a class="move_link" href="picture_content_view?pid=${picturedto.pid}"> <img
								class="card-img-top"
								src="data:${imageType};base64,${Base64.encodeBase64String(picturedto.imagebyte)}"
								alt="Picture" style="width:100%; height:100px;">
							</a>
							<div class="card-body">
								<h6 class="card-title">
									<a class="move_link"
										href="picture_content_view?pid=${picturedto.pid}" style="text-decoration: none;">${picturedto.ptitle}</a>
								</h6>
								<p class="card-text">날짜: <fmt:formatDate value="${picturedto.pdate}" pattern="yy-MM-dd" />, 조회수:
									${picturedto.phit}</p>
								<p class="card-text">작성자: ${picturedto.pname}</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<a href="picture_write_view" class="btn btn-primary"
			style="position: fixed; right: 20px; bottom: 20px;">글작성</a>

		<div class="pagination">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button"><a
						href="${pageMaker.startpage - 1}">[이전]</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startpage}"
					end="${pageMaker.endpage}">
					<li class="paginate_button" ${pageMaker.pcri.ppageNum}><a
						href="${num}">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li class="paginate_button"><a href="${pageMaker.endpage + 1}">[다음]</a></li>
				</c:if>
			</ul>
		</div>
		<form id="actionForm" method="get" action="picture_list">
			<input type="hidden" name="ppageNum"
				value="${pageMaker.pcri.ppageNum}"> <input type="hidden"
				name="pamount" value="${pageMaker.pcri.pamount}">
		</form>

		<form method="get" class="search-form" id="searchForm">
			<select name="ptype">
				<option value=""
					<c:out value="${pageMaker.pcri.ptype == null ? 'selected':''}"/>>검색
					옵션</option>
				<option value="T"
					<c:out value="${pageMaker.pcri.ptype eq 'T' ? 'selected':''}"/>>제목</option>
				<option value="C"
					<c:out value="${pageMaker.pcri.ptype eq 'C' ? 'selected':''}"/>>내용</option>
				<option value="W"
					<c:out value="${pageMaker.pcri.ptype eq 'W' ? 'selected':''}"/>>작성자</option>
				<option value="TC"
					<c:out value="${pageMaker.pcri.ptype eq 'TC' ? 'selected':''}"/>>제목
					or 내용</option>
				<option value="TW"
					<c:out value="${pageMaker.pcri.ptype eq 'TW' ? 'selected':''}"/>>제목
					or 작성자</option>
				<option value="TCW"
					<c:out value="${pageMaker.pcri.ptype eq 'TCW' ? 'selected':''}"/>>제목
					or 내용 or 작성자</option>
			</select> <input type="text" name="pkeyword"
				value="${pageMaker.pcri.pkeyword}">
			<button>검색</button>
		</form>


		<!--  end of content -->


	</main>
</body>
<script>
	var actionForm = $("#actionForm");

	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();

		var pno = actionForm.find("input[name='pid']").val();
		if (pno != ' ') {
			actionForm.find("input[name='pid']").remove();
		}

		actionForm.find("input[name='ppageNum']").val($(this).attr("href"));
		actionForm.attr("action", "picture_list").submit();
	});

	$(".move_link")
			.on(
					"click",
					function(e) {
						e.preventDefault();
						var urlParams = new URLSearchParams($(this)
								.attr("href").split("?")[1]);
						var targetPno = urlParams.get("pid");
						var pno = actionForm.find("input[name='pid']").val();
						if (pno != ' ') {
							actionForm.find("input[name='pid']").remove();
						}
						actionForm
								.append("<input type='hidden' name='pid' value='"+targetPno+ "'> ");
						actionForm.attr("action", "picture_content_view")
								.submit();
					});

	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function() {
		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요");
			return false;
		}
		if (!searchForm.find("input[name='pkeyword']").val()) {
			alert("키워드를 입력하세요");
			return false;
		}

		searchForm.attr("action", "picture_list").submit();
	});
</script>
</html>