<!-- picture_modify.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.content {
	margin-left: 300px;
}
</style>
</head>
<body>

	<div class="content">
		<div class="container mt-5">
			<h2 class="mb-4">글 내용 보기</h2>
			<form method="post" action="pmodify" enctype="multipart/form-data">
				<input type="hidden" name="ppageNum" value="${pageMaker.ppageNum}">
				<input type="hidden" name="pamount" value="${pageMaker.pamount}">
				<input type="hidden" name="pid" value="${pageMaker.pid}">
				<table class="table table-bordered" style="max-width: 500px;">
					<tr>
						<th scope="row">번호</th>
						<td>${pcontent_view.pid}</td>
					</tr>
					<tr>
						<th scope="row">조회수</th>
						<td>${pcontent_view.phit}</td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td><input type="text" class="form-control" name="pname"
							value="${pcontent_view.pname}" readonly="readonly"></td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td><input type="text" class="form-control" name="ptitle"
							value="${pcontent_view.ptitle}"></td>
					</tr>
					<tr>
						<th scope="row">이미지</th>
						<td><img
							src="${pageContext.request.contextPath}/display2?fileName=${pcontent_view.filename}">
							<input type="file" name="uploadFile"></td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td><textarea class="form-control" name="pcontent">${pcontent_view.pcontent}</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" class="btn btn-primary"
							value="수정" onclick="return confirm('수정하시겠습니까?');">
							&nbsp;&nbsp;<input type="submit" value="목록보기"
							formaction="picture_list" class="btn btn-secondary">
							&nbsp;&nbsp;<input type="submit" value="삭제" formaction="pdelete"
							onclick="return confirm('삭제하시겠습니까?');"
							class="btn btn-danger btn"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>

