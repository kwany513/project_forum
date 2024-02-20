<!-- picture_write_view.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 CDN 추가 -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 이미지 파일 선택 이벤트 핸들러 추가 -->
<script>
	$(document).ready(function() {
		$("#uploadFile").change(function() {
			readURL(this);
		});
	});

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				// 이미지 미리보기
				$('#preview').attr('src', e.target.result);
			}

			reader.readAsDataURL(input.files[0]);
		}
	}
</script>

<script type="text/javascript">
	function fn_submit() {
		var form = $('#frm')[0]; // form element
		var formData = new FormData(form);

		$.ajax({
			type : "POST",
			enctype : 'multipart/form-data',
			url : "pwrite",
			data : formData,
			processData : false,
			contentType : false,
			success : function(data) {
				alert("등록 완료");
				location.href = "picture_list";
			},
			error : function() {
				alert("오류 발생");
			}
		});
	}
</script>
<style>
.header {
	height: 70px;
	border-bottom: 1px solid #eee;
	background-color: #363945;
}
</style>
</head>
<body>
	

			<div class="container mt-5">
				<h2 class="mb-4">글 작성</h2>
				<form id="frm" method="post" action="write">
					<div class="form-group row">
						<label for="pname" class="col-sm-2 col-form-label">이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="pname" id="pname"
								value="${dto.name}" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label for="ptitle" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="ptitle" id="ptitle"
								placeholder="제목을 입력하세요">
						</div>
					</div>

					<div class="form-group row">
						<label for="ppicture" class="col-sm-2 col-form-label">이미지
							첨부</label>
						<div class="col-sm-10">
							<!-- id가 uploadFile인 input 태그 -->
							<input type="file" id="uploadFile" name="uploadFile">
							<!-- 이미지 미리보기 영역 -->
							<img id="preview" src="#" alt="Image preview"
								style="max-width: 360px; max-height: 360px;">
						</div>
					</div>


					<div class="form-group row">
						<label for="pcontent" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10" style="position: relative;">
							<textarea class="form-control" name="pcontent" id="pcontent"
								rows="5" placeholder="내용을 입력하세요"></textarea>
						</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-10 offset-sm-2">
							<input type="button" onclick="fn_submit()"
								class="btn btn-primary" value="등록"> <a
								href="picture_list" class="btn btn-secondary">목록보기</a>
						</div>
					</div>
				</form>

			</div>
		<!-- 부트스트랩 JS 및 Popper.js CDN 추가 -->
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>