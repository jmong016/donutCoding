<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

</main>
</div>

<!-- footer -->
<footer class="footer containter-fluid dark-bg">
	<div class="container p-5 footer-wrapper">
		<div class="footer-left footer_info">
			
			<div class="footer_top_info">
				<span class="is_mobile_hidden devider-right"> <a href="${path }/main">
						<svg width="85" id="icon_brand_logo" class="brand_logo accent-font"
							xmlns="http://www.w3.org/2000/svg" viewBox="0 0 433 90">
					<path class="A"
								d="M79.1 31.6c-2-4.6-4.7-8.7-8.1-12.2-3.5-3.5-7.5-6.3-12.1-8.3S49.3 8 43.9 8c-5.2 0-10.2.9-14.9 2.9s-8.8 4.7-12.4 8.1c-3.6 3.5-6.4 7.5-8.4 12.1A37.14 37.14 0 0 0 5.1 
						46c0 5.2.9 10.2 2.9 14.9s4.7 8.8 8.2 12.4 7.6 6.4 12.2 8.4c4.7 2 9.6 3.1 14.9 3.1l38.3.3.3-38.5c.1-5.3-.9-10.3-2.8-15zM74 77.4l-30.7-.3c-4.2 0-8.2-.9-11.9-2.5s-7-3.9-9.8-6.7A32.99 
						32.99 0 0 1 15 58c-1.6-3.8-2.3-7.7-2.3-11.9 0-4.3.9-8.3 2.5-12s3.9-6.9 6.7-9.7c2.9-2.8 6.2-4.9 9.9-6.5 3.8-1.6 7.7-2.3 11.9-2.3 4.3 0 8.3.9 12 2.5s6.9 3.8 9.7 6.7c2.8 2.8 4.9 6.1 6.5 9.8s2.3 7.7 2.3 12L74 77.4z"></path>
					<path class="A"
								d="M76.9 83.7c-.9 0-1.8-.3-2.5-1L27.6 35.1c-1.4-1.4-1.3-3.6 0-4.9 1.4-1.4 3.6-1.3 4.9 0l46.8 47.6c1.4 1.4 1.3 3.6 0 4.9-.6.7-1.5 1-2.4 1z"></path>
					<path class="A"
								d="M43.1 47.3c-.4 0-.8-.1-1.2-.2-1.8-.7-2.8-2.7-2.1-4.5l6.3-17.3c.7-1.8 2.7-2.8 4.5-2.1s2.8 2.7 2.1 4.5L46.4 45c-.5 1.4-1.9 2.3-3.3 2.3zm12.2 
						16.2H33.5C31.6 63.5 30 62 30 60c0-1.9 1.6-3.5 3.5-3.5h21.8c1.9 0 3.5 1.6 3.5 3.5 0 2-1.5 3.5-3.5 3.5zm44.1-32.4V85H88.8V31.1h10.6zm5.6 16.5c1.4-3.2 
						3.3-6.1 5.8-8.5 2.4-2.4 5.3-4.4 8.6-5.8s6.8-2.1 10.4-2.1c3.8 0 7.3.7 10.5 2.1s6.1 3.3 8.6 5.8c2.5 2.4 4.4 5.3 5.8 8.5s2.1 6.7 2.1 10.5v27h-10.7v-27c0-2.2-.4-4.3-1.3-6.3-.8-2-2-3.7-3.5-5.2s-3.2-2.6-5.2-3.5c-2-.8-4.1-1.3-6.4-1.3-2.2 0-4.3.4-6.3 1.3-2 .8-3.7 2-5.2 3.5s-2.6 3.2-3.5 5.2c-.8 
						2-1.3 4.1-1.3 6.3v27h-10.7v-27c.2-3.7.9-7.2 2.3-10.5zm76.1-26.2c-2 .8-3.7 2-5.2 3.5s-2.6 3.2-3.5 5.2c-.8 2-1.3 4.1-1.3 6.3v5.5h21.6v10.7h-21.6V85h-10.7V36.4c0-3.8.7-7.3 
						2.1-10.5s3.3-6.1 5.8-8.5 5.4-4.4 8.6-5.8c3.3-1.4 6.8-2.1 10.4-2.1h5.3v10.7h-5.3c-2.1 0-4.2.4-6.2 1.2zm43.2-11.9V85h-10.7V9.5h10.7zM270.5 66l7.6 7.6-3.7 3.7c-2.6 
						2.6-5.5 4.5-8.8 5.9s-6.7 2-10.3 2-7-.7-10.3-2c-3.3-1.4-6.2-3.3-8.8-5.9s-4.6-5.6-5.9-8.9-1.9-6.7-1.9-10.1.6-6.8 1.9-10.1 3.2-6.2 5.9-8.9c2.6-2.6 5.6-4.6 8.9-5.9s6.7-2 
						10.1-2 6.8.7 10.1 2 6.3 3.3 8.9 5.9l3.7 3.7L248 72.9c3 1.5 6.3 2 9.7 1.5s6.4-2.1 8.9-4.6l3.9-3.8zm-26.8-19.3c-3.2 3.2-4.8 7-4.8 11.5 0 2.5.6 4.8 1.7 7.1l10.6-10.6 6.4-6.3 4.7-4.7c-3-1.5-6.3-2-9.7-1.6-3.3.5-6.3 2.1-8.9 4.6zm64.8-15.6c3.8 0 7.3.7 10.5 2.1s6.1 3.3 8.5 5.8a27.88 27.88 0 0 1 5.8 8.5c1.4 3.2 2.1 6.7 2.1 10.5v27h-26.9c-3.7 0-7.2-.7-10.4-2.1-3.3-1.4-6.2-3.3-8.6-5.8-2.5-2.5-4.4-5.4-5.8-8.6-1.4-3.3-2.1-6.8-2.1-10.4 0-3.8.7-7.3 2.1-10.5s3.3-6.1 5.8-8.5 5.4-4.4 8.6-5.8c3.3-1.5 6.8-2.2 10.4-2.2zm16.2 43.2V58c0-2.2-.4-4.3-1.3-6.3-.8-2-2-3.7-3.5-5.2s-3.2-2.6-5.2-3.5c-2-.8-4.1-1.3-6.3-1.3s-4.4.4-6.4 1.3c-2 .8-3.7 2-5.2 3.5s-2.6 3.2-3.5 5.2c-.8 2-1.3 4.1-1.3 6.3s.4 4.4 1.3 6.4c.8 2 2 3.7 3.5 5.2s3.2 2.6 5.2 3.5c2 .8 4.1 1.3 6.4 1.3h16.3zm46.2-43.2v10.7h-5.4c-2.2 0-4.3.4-6.3 1.3-2 .8-3.7 2-5.2 3.5s-2.6 3.2-3.5 5.2c-.8 2-1.3 4.1-1.3 6.3v27h-10.8V58c0-3.8.7-7.3 2.1-10.5s3.3-6.1 5.8-8.5 5.4-4.4 8.6-5.8c3.3-1.4 6.8-2.1 10.4-2.1h5.6zm5.3 16.5c1.4-3.2 3.3-6.1 5.8-8.5 2.4-2.4 5.3-4.4 8.6-5.8s6.8-2.1 10.4-2.1c3.8 0 7.3.7 10.5 2.1s6.1 3.3 8.6 5.8c2.5 2.4 4.4 5.3 5.8 8.5s2.1 6.7 2.1 10.5v27h-10.7v-27c0-2.2-.4-4.3-1.3-6.3-.8-2-2-3.7-3.5-5.2s-3.2-2.6-5.2-3.5c-2-.8-4.1-1.3-6.4-1.3-2.2 0-4.3.4-6.3 1.3-2 .8-3.7 2-5.2 3.5s-2.6 3.2-3.5 5.2c-.8 2-1.3 4.1-1.3 6.3v27h-10.7v-27c.2-3.7.9-7.2 2.3-10.5z"></path>
                    <title>인프런 브랜드 로고</title>
                </svg>
				</a>
				</span> 
				<span class="devider-right"><a href="#!">개인정보취급방침</a></span> 
				<span><a href="#!">이용약관</a></span>
			</div>

<!-- 			<div class="footer_bottom_info">
				<div class="footer_bottom_info_mobile">
					<div class="container mt-3">
						<a href="#demo" data-bs-toggle="collapse">(주)인프랩 사업자 정보 <div class="is-mobile info_label">
					<span class="is-mobile info_caret"> 
					    <i class="fas fa-angle-up"></i> 
						<i class="fas fa-angle-down"></i>
					</span>
				    </div>
						</a>
						<div id="demo" class="footer-collapse-mobile">
							<span>대표자: 이형주 </span> <span>사업자번호: 499-81-00612 <a
								href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=4998100612">사업자
									정보 확인</a>
							</span> <br> <span>통신판매업: 2018-성남분당B-0062</span> <span>개인정보보호책임자:
								구자유</span> <span>이메일: <a href="mailto:info@inflearn.com">info@inflearn.com</a></span>
							<br> <span>주소: 경기도 성남시 분당구 대왕판교로 660 유스페이스1 301-1호</span>
						</div>
					</div>
				</div> -->
				
				<div class="info-dropdown" >
					<div>
						<div>
						<span class="is-hidden-mobile">(주)인프랩</span> 
						<span class="devider-right">대표자:이젠</span>
						<span class="devider-right">사업자번호: 119-82-52525</span> 
						<span><a href="#!">사업자 정보 확인</a></span>
						</div>
						
						<div>
						<span class="devider-right">통신판매업: 2021-의정부ezen-206</span>
						<span class="devider-right">개인정보보호책임자:이젠</span>
						<span>이메일: <a href="mailto:info@inflean.com">info@inflearn.com</a></span>
						</div>
						
						<div><span>주소: 경기도 의정부시 의정부2동 신흥로 258번길 25 해태프라자 2층</span></div>
					</div>
				</div>
				
				<div class="footer_copyright accent-font">@INFLAB. ALL RIGHT RESERVED</div>
			</div>
			
			<!-- 링크 아이콘 -->
			<div class="footer-right footer-bottom">
				<span class="gray-bg"><a href="http://post.naver.com/inflearn" target="_blank"> <i
					class="text white-font">N</i></a></span> 
				<span class="gray-bg"><a href="http://blog.naver.com/inflearn" target="_blank"> <i
					class="text white-font">B</i></a></span> 
				<span class="gray-bg"><a href="http://www.instagram.com/inflearn_official" target="_blank">
					<i class="fab fa-instagram white-font"></i></a></span> 
				<span class="gray-bg"><a href="https://www.youtube.com/channel/UC0Y0T9JpgIBbyGDjvy9PbOg"
					target="_blank"> <i class="fab fa-youtube white-font"></i></a></span> 
				<span class="gray-bg"><a href="https://www.facebook.com/inflearn" target="_blank"> <i
					class="fab fa-facebook-f white-font"></i></a></span>
			</div>
		
		</div>

		
	</div>
</footer>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script src="/resources/js/scripts.js"></script>

</body>
</html>