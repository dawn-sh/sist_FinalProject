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
    <link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <title>Insert title here</title>
    <style type="text/css">
        .mainbox {
            width: 100%;
            /*height: 300vh;*/
            /*border: 3px solid red;*/
            /*margin: 6vh 17.5%;*/
            margin-top: 2vh;
        }

        .mainad {
            width: 100%;
            height: 40vw;
            /*border: 3px solid orange;*/
            margin-bottom: 30px;
            box-shadow: 10px 10px 10px silver;
            overflow: hidden;
        }

        .mainad img{
            width: 100%;
            height: 100%;
            overflow: hidden;
            display: none;
        }
        .dot-container {
            text-align: center;
            /*padding: 20px;*/
            /*background: #ddd;*/
        }
        .dot {
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }
        .active{
            background-color: #717171;
        }

        .maincategory {
            width: 100%;
            /*height: 20vh;*/
            /*border: 3px solid blue;*/
            padding: 10px 15% 10px 15%;
            font-family: 'Jalnan';
            display: flex;
            justify-content: space-between;
            margin-bottom: 50px;
            
        }


        div.maincategory img {
            width: 100px;
            /*margin: 0 20% 0 20%;*/
            /*margin-right: 20%;*/
            /*margin-left: 20%;*/
        }

        div.maincategory a {
            text-decoration: none;
            color: black;
            display: flex;
            justify-content: space-between;
        }

        div.newsmain {
            font-family: Jalnan;
            width: 100%;
        }

        .newsmaintitle {
            display: flex;
            width: 100%;
            float: left;
            margin-bottom: 20px;
        }

        div.newssub {
            width: 100%;

        }

        ul.newssubul {
            width: 100%;
            height: 152px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            /*margin-right: auto;*/
            /*margin-left: auto;*/
           	font-size: 15px;
           	font-family: 'arial';
           	
        }

        li.newsbox {
            /*border: 1px solid rgba(0,0,0,0.1);*/
            border: 1px solid rgba(0, 0, 0, 0.08);
            /*margin: 30px 10px 0px 10px;*/
            width: 100%;
            height: 150px;
            display: flex;
            align-items: center;
            overflow: hidden; /* 해당 범위 넘어가는 이미지 등의 내용은 숨기기 */
            cursor: pointer;
        }
        
        .newsbox img {
        	padding-left: 5%;
        	padding-bottom: 1vh;
        	max-width: 100%;
        	max-height: 18vh;
        }

        a > p {
            color: black;
            font-family: 'arial';
            display: flex;
            align-items: center;
            flex-grow: 1; /* 텍스트가 남은 공간을 차지하도록 허용 */
        }

        .newsbox a {
            font-family: Arial;
            color: black;
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .newsbox img {
            height: 150px;
            object-fit: cover; /* 필요에 따라 여백 조정 */
            margin-right: 15px; /* 필요에 따라 여백 조정 */
        }

        .newsbox p {
            width: 100%;
            text-align: center;
        }

        p.newstext1 {
            color: #f7323f;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 5px;
        }

        div.textbox {
            width: 100%;
            height: 100%;
            margin-top: 12vh;
        }

    </style>
</head>
<c:set var="root" value="<%=request.getContextPath() %>"/>
<body>
<div class="mainbox" align="center">

    <div class="mainad">
        <img src="${root}/zchuseok.jpeg" class="slide">
        <img src="${root}/seoul.png" class="slide">
        <img src="${root}/zdajeon.jpeg" class="slide">
        <img src="${root}/zjune.jpeg" class="slide">
        <img src="${root}/ztkka.jpeg" class="slide">
    </div>
    <div class="dot-container">
        <span class="dot"></span>
        <span class="dot"></span>
        <span class="dot"></span>
        <span class="dot"></span>
        <span class="dot"></span>
    </div>


    ${sessionScope.nickname}<br>
    <div class="maincategory d-inline-flex">
        <a href="/product/search-main?keyword=호텔">
            <figure><img src="${root}/hotel.png">
                <figcaption>호텔</figcaption>
            </figure>
        </a>
        <a href="/product/search-main?keyword=모텔">
            <figure><img src="${root}/bed.png">
                <figcaption>모텔</figcaption>
            </figure>
        </a>
        <a href="/product/search-main?keyword=펜션">
            <figure><img src="${root}/pension.png">
                <figcaption>펜션</figcaption>
            </figure>
        </a>
    </div>

    <div class="newsmain">
        <h3 class="newsmaintitle" style="margin-bottom: 7vh;">TREVIEW 소식</h3>
        <div class="newssub">
            <ul class="d-inline-flex newssubul">
            
            
                <li class="newsbox">
                    
                        <img src="${root}/ad.png" style="margin-bottom: 2vh; margin-left: -2%;">&nbsp;&nbsp;&nbsp;
                        <div class="textbox" style="margin-left: -8%;">
                            <p class="newstext1">TREVIEW 광고신청하기</p>
                            <p class="newstext2"><b>고정고객 확보,신규회원 유치 가능합니다.</b></p>
                        </div>

                    
                </li>
                &nbsp;&nbsp;&nbsp;
                <li class="newsbox" style="margin-right: 3%;">

                        <img src="${root}/registration.png" style="margin-top: 1vh;">&nbsp;&nbsp;&nbsp;
                        <div class="textbox" style="margin-left: -6%;" >
                            <p class="newstext1">TREVIEW 숙소등록하기</p>
                            <p class="newstext2"><b>숙소 등록하고 더 많은 고객 확보하세요!</b></p>
                        </div>

                </li>
            </ul>
        </div>
    </div>
	<script>
    $(document).ready(function() {

        // business_id 값을 가져옴
        var businessId = "${sessionScope.business_id}";

        // 숙소 등록하기 링크
        var accomInsertLink = $("ul.newssubul li:eq(1)");

        // li 클릭 이벤트
        accomInsertLink.click(function() {
            // business_id가 null이면 경고 메시지 표시
            if (!businessId) {
                alert("사업자 로그인 후 가능합니다.");
            } else {
                // business_id가 null이 아니면 페이지 이동
                window.location.href = "/accom/accom-insert";
            }
        });

    //     main 광고 slide
        var slideIndex = 0; // 슬라이드 인덱스를 전역 변수로 선언
        showSlides();

        function showSlides() {
            var i;
            var slides = document.getElementsByClassName("slide");
            var dots = document.getElementsByClassName("dot");
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) {slideIndex = 1}
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex-1].style.display = "block";
            dots[slideIndex-1].className += " active";
            setTimeout(showSlides, 2000); // 2초마다 이미지 변경
        }

        // dot 클릭 이벤트 리스너 추가
        $(".dot").click(function() {
            // 클릭된 dot의 인덱스를 구함
            var dotIndex = $(".dot").index(this);

            // 슬라이드 인덱스를 클릭된 dot에 맞게 조정
            slideIndex = dotIndex; // 클릭 이벤트에 의해 슬라이드 인덱스를 직접 설정

            // 현재 슬라이드와 dot를 즉시 업데이트
            var slides = document.getElementsByClassName("slide");
            var dots = document.getElementsByClassName("dot");
            for (var i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex].style.display = "block";
            dots[slideIndex].className += " active";

            // 슬라이드 쇼를 다시 시작하기 위해 기존의 타이머를 취소하고 새로 시작
            clearTimeout(showSlides);
            // showSlides.timeoutId = setTimeout(showSlides, 2000); // 새로운 타이머 설정
        });

    });
</script>
	
    <div></div>
</div>
</body>
</html>