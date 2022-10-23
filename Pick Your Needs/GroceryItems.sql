clear screen;
drop table GroceryItems;
create table GroceryItems(Gid int, Gname varchar2(30), Price_in_taka varchar2(20),PRIMARY KEY (Gid));

select * from GroceryItems; 

insert into GroceryItems values('1', 'Onion',  '19');
insert into GroceryItems values('2', 'Horlicks',  '445');
insert into GroceryItems values('3', 'Potato',  '17');
insert into GroceryItems values('4', 'Alovera',  '20');
insert into GroceryItems values('5', 'Butter',  '199');

select * from GroceryItems; 