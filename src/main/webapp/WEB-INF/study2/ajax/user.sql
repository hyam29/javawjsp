show tables;

create table user (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	name varchar(20) not null,
	age int default 20,
	address varchar(50)
);

desc user;

insert into user values (default, 'hkd1234', '홍길동', 22, '서울');
insert into user values (default, 'admin', '관리자', 33, '청주');
insert into user values (default, 'lkj1234', '이기자', 36, '청주');
insert into user values (default, 'ohnara', '오나라', 18, '서울');
insert into user values (default, 'namu1234', '소나무', 39, '서울');

select * from user;
select * from user order by idx desc;