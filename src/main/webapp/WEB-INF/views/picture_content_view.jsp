<!-- picture_content_view.jsp -->
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
<title>글 내용 보기</title>

<style>
.header{
height : 70px;
border-bottom: 1px solid #eee;
background-color : #363945;

}
.content {
	margin-left: 300px;
}

.card {
	width: 700px;
}

.reply-icon {
	position: relative;
	margin-left: 40px; /* 기존의 두 배로 변경 */
}

.reply-icon::before {
	content: "";
	position: absolute;
	border-left: 10px solid #ccc;
	height: 20px;
	left: -30px;
	top: 10px;
}

.reply-icon::after {
	content: "";
	position: absolute;
	border-top: 10px solid #ccc;
	width: 20px;
	left: -20px;
	top: 20px;
}
</style>
<script>
	function showRprForm(formId) {
		var form = document.getElementById(formId);
		if (form.style.display === "none") {
			form.style.display = "block";
		} else {
			form.style.display = "none";
		}
	}

	$(document).ready(
			function() {
				var profile = "${dto.getProfileimage()}";
				console.log("프로필사진명은 ==>" + profile);
				$("#profile-image").html(
						"<img src='./display?fileName=" + profile + "'>");

			});
</script>
</head>
<body>
	<jsp:include page="nav2.jsp" />
	<main>
	<div class="header">

 <nav id="main_nav" class="navbar navbar-expand-lg bg-dark border-bottom border-body" style="width:100%; height:70px;">
      <div class="container-fluid">
        <a class="navbar-brand" href="main" style="color: white;margin-left:50px;">메인</a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           
            <li class="nav-item" style="margin-left:50px;">
              <a class="nav-link" href="myinfo" style="color: white">마이페이지</a>
            </li>
            <li class="nav-item dropdown" style="margin-left:50px;">
              <a
                class="nav-link dropdown-toggle"
                style="color: white"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
                font-size="1.25rem"
              >
                내 업무
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a class="dropdown-item" href="approval" style="color: black"
                    >전자결재</a
                  >
                </li>
                <li>
                  <a class="dropdown-item" href="receive" style="color: black"
                    >메신저</a
                  >
                </li>
                <li><hr class="dropdown-divider" /></li>
                <li>
                  <a class="dropdown-item" href="vacationRequest" style="color: black"
                    >자원요청</a
                  >
                </li>
              </ul>
            </li>
           
          </ul>
          <form class="d-flex" role="search">
            <input
              class="form-control me-2"
              type="search"
              placeholder="사원명"
              aria-label="Search"
            />
            <button
              class="btn btn-outline-success"
              type="submit"
              style="color: white"
            >
              Search
            </button>
          </form>
        </div>
      </div>
    </nav>



      </div>
	
	<div class="content">
		<div class="container mt-5">
			<h2 class="mb-4">글 내용 보기</h2>
			<form>
				<input type="hidden" name="ppageNum" value="${pageMaker.ppageNum}">
				<input type="hidden" name="pamount" value="${pageMaker.pamount}">
				<input type="hidden" id="pid" name="pid" value="${pageMaker.pid}">
				<!-- pid를 id로도 추가 -->
				<div class="card" style="width: 700px">
					<div class="card-body">
						<h5 class="card-title">${pcontent_view.ptitle}</h5>
						<h6 class="card-subtitle mb-2 text-muted">작성자:
							${pcontent_view.pname}</h6>
						<img class="card-img-top"
							src="${pageContext.request.contextPath}/display2?fileName=${pcontent_view.filename}"
							style="width: 500px; height: 500px;" alt="Card image cap">
						<p class="card-text">${pcontent_view.pcontent}</p>
					</div>
					<div class="card-footer text-muted">번호: ${pcontent_view.pid}
						/ 조회수: ${pcontent_view.phit}</div>
				</div>
				<div class="mt-3">
					<input type="submit" value="수정하기"
						formaction="picture_modify?ppageNum=${pageMaker.ppageNum}&pamount=${pageMaker.pamount}&pid=${pageMaker.pid}"
						class="btn btn-primary"> <input type="submit" value="목록보기"
						formaction="picture_list" class="btn btn-secondary">
				</div>
			</form>
		</div>

		<!-- 댓글 기능 -->

		<!-- 댓글 목록 -->
		<c:forEach var="reply" items="${prlist}" varStatus="status">
			<div class="card mt-4">
				<div class="card-body">
					<h6 class="card-subtitle mb-2 text-muted">
						작성자:
						<c:out value="${reply.prwriter}" />
					</h6>
					<p class="card-text">
						<c:out value="${reply.prcontent}" />
					</p>
					<p class="card-text">
						<small class="text-muted">작성일: <c:out
								value="${reply.pregdate}" /></small>
					</p>
					<form action="${pageContext.request.contextPath}/prdelete"
						method="post" onsubmit="return confirm('정말 댓글을 삭제하시겠습니까?')">
						<input type="hidden" name="pid" value="${pid}"> <input
							type="hidden" name="prid" value="${reply.prid}"> <input
							type="submit" value="삭제" class="btn btn-danger btn-sm">
					</form>
					<button onclick="showRprForm('rprForm${status.index}')"
						class="btn btn-primary btn-sm">대댓글 작성하기</button>
				</div>
			</div>

			<!-- 대댓글 목록 -->
			<c:forEach var="reply2" items="${reply.rprlist}">
				<div class="card mt-2 reply-icon">
					<div class="card-body">
						<h6 class="card-subtitle mb-2 text-muted">
							작성자:
							<c:out value="${reply2.rprwriter}" />
						</h6>
						<p class="card-text">
							<c:out value="${reply2.rprcontent}" />
						</p>
						<p class="card-text">
							<small class="text-muted">작성일: <c:out
									value="${reply2.rpregdate}" /></small>
						</p>
						<form action="${pageContext.request.contextPath}/rprdelete"
							method="post" onsubmit="return confirm('정말 대댓글을 삭제하시겠습니까?')">
							<input type="hidden" name="pid" value="${pid}"> <input
								type="hidden" name="parentPrid" value="${reply.prid}"> <input
								type="hidden" name="rprid" value="${reply2.rprid}"> <input
								type="submit" value="삭제" class="btn btn-danger btn-sm">
						</form>
					</div>
				</div>
			</c:forEach>


			<!-- 대댓글 작성 -->
			<form id="rprForm${status.index}" style="display: none; width: 700px"
				action="${pageContext.request.contextPath}/rprwrite" method="post"
				class="mt-3">
				<div class="form-group">
					<label for="rprwriter${status.index}">작성자</label> <input
						type="text" id="rprwriter${status.index}" name="rprwriter"
						value="${dto.name}" readonly="readonly" class="form-control">
				</div>
				<div class="form-group">
					<label for="rprcontent${status.index}">내용</label>
					<textarea id="rprcontent${status.index}" name="rprcontent"
						class="form-control" rows="3"></textarea>
				</div>
				<input type="hidden" name="pid" value="${pid}"> <input
					type="hidden" name="parentPrid" value="${reply.prid}"> <input
					type="submit" value="대댓글 작성" class="btn btn-primary">
			</form>
			<hr>
		</c:forEach>


		<!-- 댓글 작성 -->
		<div class="card mt-4">
			<div class="card-header">댓글 작성</div>
			<div class="card-body">
				<form action="${pageContext.request.contextPath}/prwrite"
					method="post">
					<div class="form-group">
						<label for="prwriter">작성자</label> <input type="text" id="prwriter"
							name="prwriter" value="${dto.name}" readonly="readonly"
							class="form-control">
					</div>
					<div class="form-group">
						<label for="prcontent">내용</label>
						<textarea id="prcontent" name="prcontent" class="form-control"
							rows="3"></textarea>
					</div>
					<input type="hidden" name="pid" value="${pid}"> <input
						type="submit" value="댓글 작성" class="btn btn-primary">
				</form>
			</div>
		</div>
		<!-- 댓글 기능 끝 -->
	</div>
	</main>
</body>
</html>