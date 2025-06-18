CREATE TABLE sample_table (
	id int	PRIMARY KEY,
	name varchar(30)
)

select * from sample_table;

insert into sample_table(id, name) values(1, '이정헌');
insert into sample_table(id, name) values(2, '이상현');
insert into sample_table(id, name) values(3, '강경민');
insert into sample_table(id, name) values(4, '유채승');
insert into sample_table(id, name) values(5, '유바다');

select * from sample_table where id = 2;

insert into sample_table(id, name) values(6, '정진');
update sample_table set name = '정진2' where id = 6;
delete from sample_table where id = 6;
select * from sample_table where id = 6;