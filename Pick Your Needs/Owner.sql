clear screen;
drop table Employee;
create table Employee(Eid int  , Ename varchar2(20), Ephone varchar2(20),PRIMARY KEY (Eid));

select * from Employee; 

insert into Employee values('1', 'john',  '01984455667');
insert into Employee values('2', 'jery',  '01884455667');
insert into Employee values('3', 'jam',  '01784455867');
insert into Employee values('4', 'ashu',  '01684455667');
insert into Employee values('5', 'john',  '01984455667');

select * from Employee; 