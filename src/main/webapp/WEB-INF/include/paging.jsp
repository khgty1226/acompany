<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<!-- paging -->
			<nav class="paging" aria-label="Page navigation example">
			
				<ul class="pagination page_ul">
					
					<c:if test="${searchVO.firstPage gt 10 }">
					<li class="first">
						<a class="page-link-a" href="#" 
						data-curPage=${searchVO.firstPage-1 } data-rowSizePerPage=${searchVO.rowSizePerPage } ></a>
					</li>
					</c:if>
					
					<c:if test="${searchVO.curPage ne 1 }">
						<li class="prev">
						<a class="page-link-a" href="#" 
							data-curPage=${searchVO.curPage-1 } data-rowSizePerPage=${searchVO.rowSizePerPage }></a></li>
					</c:if>
					
					<c:forEach begin="${searchVO.firstPage }" end="${searchVO.lastPage }" step="1" var="i">
						<c:if test="${searchVO.curPage ne i}">
							<li class="page-item"><a class="page-link-a" href="#"
								data-curPage=${i } data-rowSizePerPage=${searchVO.rowSizePerPage } >${i }</a></li>
						</c:if>
						<c:if test="${searchVO.curPage eq i }">
							<li class="page-item"><strong>${i }</strong></li>
						</c:if>
					</c:forEach>
					
					<c:if test="${searchVO.curPage ne searchVO.totalPageCount }">
						<li class="next"><a class="page-link-a" href="#"
							data-curPage=${searchVO.curPage+1  } data-rowSizePerPage=${searchVO.rowSizePerPage }></a></li>
					</c:if>
					
					<c:if test="${searchVO.lastPage ne searchVO.totalPageCount }">
						<li class="last"><a class="page-link-a" href="#" 
							data-curPage=${searchVO.lastPage+1 } data-rowSizePerPage=${searchVO.rowSizePerPage }></a></li>
					</c:if>
				</ul>
			</nav>