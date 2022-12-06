show tables;

create table pds (
	idx int not null auto_increment,	/* 자료실 고유번호 */
	mid varchar(20) not null,					/* 올린이 아이디 */
	nickName varchar(20) not null,		/* 올린이 닉네임 */
	fName varchar(200) not null,			/* 업로드 시 파일명 */
	fSName varchar(200)	not null,			/* 실제 파일서버에 저장되는 파일명 */
	fSize int not null,								/* 파일의 총 사이즈(따로 계산하는 건 아님 누적만 하면 됨) */
	title varchar(100) not null,			/* 업로드 파일의 제목 */
	part varchar(20) not null,				/* 파일 분류(여행이라면 여행중, 학습이라면 학습중 분류에서만 사용 가능 -> 게시판 하나만으로 여러 작업 가능 => 멀티게시판 사용 가능) */
	pwd varchar(100) not null,				/* 비밀번호 (암호화 - SHA256암호화처리) */
	fDate datetime default now(),			/* 파일 업로드 일자 */
	downNum int default 0,						/* 파일 다운로드 횟수 */
	openSw char(6) default '공개',			/* 파일 공개(비공개) 여부 */
	content text,											/* 업로드 파일의 상세설명 */
	hostIp varchar(50) not null,			/* 업로드 PC IP */
	primary key (idx)									/* 기본키 : 자료실의 고유번호 */
);

desc pds;

select * from pds order by idx desc;