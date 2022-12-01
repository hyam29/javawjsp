show tables;

create table board (
	idx int not null auto_increment,		/* 게시글의 고유번호 */
	nickName varchar(20) not null,			/* 게시글 작성자의 닉네임*/
	title varchar(100)	not null,				/* 글 제목 */
	email varchar(50),									/* 글쓴이의 메일주소 (회원가입시 필수 입력처리 되어있으나 공개하기 싫다면 지워야해서 not null  */
	homePage varchar(50),								/* 글쓴이의 홈페이지(블로그)주소 */
	content text not null,							/* 글 내용 */
	wDate datetime default now(),				/* 글 올린 날짜 (사용자 입력 X -> 화면에 보여주지 X 출력만 할 것임) */
	hostIp varchar(50) not null,				/* 글쓴이의 접속 IP */
	readNum int default 0,							/* 글 조회수 */
	good int default 0,									/* '좋아요' 클릭 횟수 누적 */
	mid varchar(20) not null,						/* 회원 아이디(내글 전체 조회 시 사용) */
	
	primary key (idx)
);

desc board;

insert into board values (default, '관리맨', '게시판 서비스를 시작합니다.', 'admin1234@gmail.com', 'http://', '이곳은 게시판입니다.', default, '192.168.50.190', default, default, 'admin');

select * from board;

/* 날짜 처리 연습 */
select now(); /* now() : 오늘날짜와 시간을 보여준다. */ 
select year(now()); /* year(now()) : '연도' 출력 */
select month(now()); /* month(now()) : '월' 출력 */
select day(now()); /* day(now()) : '일' 출력 */
select date(now()); /* date(now()) : 'yyyy-MM-dd' 출력 */
select weekday(now()); /* weekday() : 요일 (0(월) ~ 6(일)) */
select dayofweek(now()); /* dayofweek() : 요일 (1(일) ~ 7(토)) */
select hour(now()); /* hour() : 24시간제 시 */
select minute(now()); /* minute() : 분 */
select second(now()); /* second() : 초 */

select year('2022-12-1');
select idx, year(wDate) from board; /* board에 등록된 wDate에서 연도만 보여줌 */
select idx, day(wDate) as 날짜 from board; /* as 필드명 (영어로 쓰는 게 좋음) */
select idx, weekday(wDate) as 요일 from board; /* as 필드명 (영어로 쓰는 게 좋음) */

/* 날짜 연산 */
/* date_add(date, interval 값 type) */
select date_add(now(), interval 1 day); /* 오늘날짜 +1일 */
select date_add(now(), interval -1 day); /* 오늘날짜 -1일 */
select date_add(now(), interval 10 day_hour); /* 오늘날짜 +10시간 */ 
select date_add(now(), interval -10 day_hour); /* 오늘날짜 -10시간 */ 
select date_add(now(), interval -24 day_hour);

/* date_sub(date, interval 값 type) add와 똑같음! 단지 sub(뺄셈)니까 상황이 반대임 */
select date_sub(now(), interval 1 day);
select date_sub(now(), interval -1 day);

select idx, wDate from board;

/* 2자리연도(%y), 4자리연도(%Y) 숫자월(%m), 영문월(%M), 일(%d), 12시간제시간(%h), 24시간제시간(%H), 분(%i), 초(%s) */
select idx, date_format(wDate, '%Y-%M-%d') from board; /* %Y: 4자리 연도 출력, %M : 영문 월 출력 */
select idx, date_format(wDate, '%y-%m-%d') from board; /* %Y: 2자리 연도 출력, %m : 숫자 월 출력 */
select idx, date_format(wDate, '%Y-%m-%d') from board; /* %Y: 4자리 연도 출력, %m : 숫자 월 출력 */
select idx, date_format(wDate, '%H-%i-%s') from board;
select idx, date_format(wDate, '%h-%i-%s') from board;

/* 문제 */
select date_sub(now(), interval 1 month); /* 현재부터 한달 전 날짜 꺼내보기 or add -1 */

/* 하루 전 체크 */
select date_add(now(), interval -1 day);
select date_add(now(), interval -1 day), wDate from board;

/* 날짜 차이 계산 : DATEDIFF (시작날짜, 마지막날짜) (앞에서 뒤를 빼니까, 양수출력 -> 최근일 - 과거일) */
select datediff('2022-11-30', '2022-12-01');
select datediff(now(), '2022-11-30');
select idx, date_format(wDate, '%Y-%m-%d'), datediff(now(), wDate) as day_diff from board;
select idx, wDate, datediff(now(), wDate) as day_diff from board;

select *, datediff(now(), wDate) as day_diff from board; /* DB설계에서는 없지만, 프로그램에 있는 day_diff를 변수(별명) 설정해서 vo에 담으면 자유롭게 사용 가능! */
select *, datediff(now(), date_add(wDate, interval -24 day_hour)) as hour_diff from board;

/* 시간 차이 계산 */
select timestampdiff(hour, now(), '2022-11-30');
select timestampdiff(hour, '2022-11-30', now());
select timestampdiff(hour, wDate, now()) as hour_diff from board;
select *, timestampdiff(hour, wDate, now()) as hour_diff from board;

select *, datediff(now(), wDate) as day_diff, timestampdiff(hour, wDate, now()) as hour_diff from board;
