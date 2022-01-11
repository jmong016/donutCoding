var autoSwiper = new Swiper(".autoSwiper",
		{
			spaceBetween : 30,
			centeredSlides : true,
			loof : true,
			autoplay : {
				delay : 3000,
				disableOnInteraction : false
			},
			pagination : {
				el : ".swiper-pagination",
				clickable : true,
				renderBullet : function(index, className) {
					return '<span class="' + className + '">' + (index + 1)
							+ "</span>";
				},
			},
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev"
			}
		});

var courseSwiper = new Swiper(".courseSwiper", {
	slidesPerView : 1,
	spaceBetween : 10,
	slidesPerGroup : 1,
	breakpoints: { //반응형 조건 속성
		736: {
        	slidesPerView : 2,
        	slidesPerGroup : 2
        },
        1024: {
        	slidesPerView : 4,
        	slidesPerGroup : 4
        },
      },
	loop : true,
	loopFillGroupWithBlank : true,
	navigation : {
		nextEl : ".swiper-button-next",
		prevEl : ".swiper-button-prev"
	}
});

var reviewSwiper = new Swiper(".reviewSwiper", {
  direction: "vertical",
  slidesPerView: 1,
  spaceBetween: 10,
  mousewheel: true,
  loof : true,
  loopFillGroupWithBlank : true,
  breakpoints: { //반응형 조건 속성
		736: {
      	slidesPerView : 2
      }
  },
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
});

$('.autoPlay').on('mouseover', function() {
	autoSwiper.autoplay.stop();
});

$('.autoPlay').on('mouseout', function() {
	autoSwiper.autoplay.start();
});