clear screen;
drop table Customers;
create table Customers(Cid int, Cname varchar2(20), Cphone varchar2(20),PRIMARY KEY (Cid));

select * from Customers; 

insert into Customers values('1', 'jimi',  '01984455607');
insert into Customers values('2', 'tom',  '01884455007');
insert into Customers values('3', 'pit',  '01784488867');
insert into Customers values('4', 'asus',  '01684452267');
insert into Customers values('5', 'jenifer',  '01984666677');

select * from Customers; 