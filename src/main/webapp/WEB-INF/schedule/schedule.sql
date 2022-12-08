show tables;

create table schedule (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,											/* 회원 아이디(일정검색 시 필요) */
	sDate datetime not null,											/* 일정 등록 날짜 */
	part varchar(10) not null,										/* 1.모임, 2.업무, 3.학습, 4.여행, 5.기타 : 라디오버튼 */
	content text not null													/* 일정 상세 내역 */
);

desc schedule;

insert into schedule values (default, 'hkd1234', '2022-12-08', '학습', '프로젝트 계획서 완료');
insert into schedule values (default, 'admin', '2022-12-09', '기타', '프로젝트 디자인 설계');
insert into schedule values (default, 'hkd1234', '2022-12-09', '기타', '집안일');
insert into schedule values (default, 'admin', '2022-12-20', '학습', '프로젝트 발표일');
insert into schedule values (default, 'admin', '2022-12-24', '모임', '크리스마스 친구모임');
insert into schedule values (default, 'hkd1234', '2022-12-25', '학습', '오전10시 스터디모임');
insert into schedule values (default, 'hkd1234', '2022-12-25', '모임', '크리스마스 친구모임');
insert into schedule values (default, 'hkd1234', '2022-12-25', '모임', '크리스마스 가족모임');
insert into schedule values (default, 'admin', '2022-12-25', '모임', '크리스마스 가족모임');
insert into schedule values (default, 'admin', '2022-12-26', '모임', '오전스터디');
insert into schedule values (default, 'admin', '2022-12-26', '모임', '오후스터디');
insert into schedule values (default, 'admin', '2022-12-31', '여행', '가족여행');
insert into schedule values (default, 'hkd1234', '2023-01-05', '학습', 'Spring 설정 공부');

select * from schedule order by sDate desc;
select * from schedule where mid = 'hkd1234' order by sDate desc;
select * from schedule where mid = 'hkd1234' and sDate = '2022-12-25' order by sDate desc;
/* date_format 이용해서 12월 전체 꺼내기 */
select * from schedule where mid = 'hkd1234' and date_format(sDate, '%Y-%m') = '2022-12' order by sDate desc;
/* part로 묶어서 출력 */
select * from schedule where mid = 'hkd1234' and date_format(sDate, '%Y-%m') = '2022-12' group by part order by sDate desc;
/* date_format에 맞지 않는 형식은 error!(33행) 따라서, 10보다 작은 수는 앞에 '0'을 붙여줘야 함 */
select * from schedule where mid = 'hkd1234' and date_format(sDate, '%Y-%m') = '2023-01' group by part order by sDate desc;
select * from schedule where mid = 'hkd1234' and date_format(sDate, '%Y-%m') = '2023-1' group by part order by sDate desc;
/* 동일한 날짜에 part로 묶인 항목 개수 출력 -> 하려고 했는데, 에러나서 partCnt 없애고 order by 로 묶어 알고리즘으로 처리 */
select *,count(*) from schedule where mid = 'hkd1234' and sDate = '2022-12-25' group by part order by sDate desc;
select *,count(*) as partCnt from schedule where mid = 'hkd1234' and date_format(sDate, '%Y-%m') = '2022-12' order by sDate,part desc;

select * from schedule where mid = 'hkd1234' and date_format(sDate, '%Y-%m') = '2022-12' order by sDate, part;

