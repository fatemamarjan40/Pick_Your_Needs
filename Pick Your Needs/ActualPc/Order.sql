clear screen;

drop table Customers CASCADE CONSTRAINTS;
drop table Employee CASCADE CONSTRAINTS;
drop table GroceryItems CASCADE CONSTRAINTS;
drop table Orders CASCADE CONSTRAINTS;


create table Customers(Cid int, Cname varchar2(20), Cphone varchar2(20),PRIMARY KEY (Cid));

select * from Customers; 



--drop table Employee;
create table Employee(Eid int  , Ename varchar2(20), Ephone varchar2(20),PRIMARY KEY (Eid));

select * from Employee; 

 

--drop table GroceryItems;
create table GroceryItems(Gid int, Gname varchar2(30), Price_in_taka varchar2(20),PRIMARY KEY (Gid));

select * from GroceryItems; 




--drop table Orders;
create table Orders(Oid int, Cid int, Eid int,Gid int,Quantity int, orderdate date);

select * from Orders; 

insert into Customers values('1', 'jimi',  '01984455607');
insert into Customers values('2', 'tom',  '01884455007');
insert into Customers values('3', 'pit',  '01784488867');
insert into Customers values('4', 'asus',  '01684452267');
insert into Customers values('5', 'jenifer',  '01984666677');

select * from Customers; 

insert into Employee values('1', 'john',  '01984455667');
insert into Employee values('2', 'jery',  '01884455667');
insert into Employee values('3', 'jam',  '01784455867');
insert into Employee values('4', 'ashu',  '01684455667');
insert into Employee values('5', 'john',  '01984455667');

select * from Employee; 

insert into GroceryItems values('1', 'Onion',  '19');
insert into GroceryItems values('2', 'Horlicks',  '445');
insert into GroceryItems values('3', 'Potato',  '17');
insert into GroceryItems values('4', 'Alovera',  '20');
insert into GroceryItems values('5', 'Butter',  '199');

select * from GroceryItems; 

insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate ) values(1,1,1,1,1,  '28-feb-2022');
insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate )  values(2,2,2,2,1,  '01-jan-2022');
insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate )  values(3,3,3,3,3, '02-feb-2022');
insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate )  values(4,4,4,4,1, '03-apr-2022');
insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate )  values(5,5,5,5,2,  '03-sep-2022');

select * from Orders; 

create or replace view myview(view_ID, view_Name, view_Price) as 
select s.Gid, s.Gname, s.Price_in_taka
from GroceryItems s;
select * from myview;
commit;

SET SERVEROUTPUT ON;
SET VERIFY OFF;

Accept x number prompt "Enter the Customer Id:  "
Accept y number prompt "Enter the Grocery_view Id:  "
Accept z number prompt "Enter the Grocery Quantity:  "

create or replace package mypack as
    FUNCTION checkID(CID in Customers.Cid%TYPE)
	RETURN NUMBER;
	
	PROCEDURE CustomerEntry(CID in Customers.Cid%TYPE);
END mypack;
/

create or replace package body mypack as

FUNCTION checkID(CID in Customers.Cid%TYPE)
RETURN NUMBER
IS
C NUMBER;
BEGIN
		C := 0;
	FOR R IN (select Cid from Customers) LOOP
		IF R.Cid =CID then
			C := C + 1;
		end if;
	END LOOP;
	return C;
END checkID;

----procedure
PROCEDURE CustomerEntry(CID in Customers.Cid%TYPE)
IS
BEGIN
	insert into Customers(Cid, Cname, Cphone) values (CID,'alin','01984458607');

	--DBMS_OUTPUT.PUT_LINE('done');
END CustomerEntry;

end mypack;
/


create or replace trigger EntryTrigger
after insert 
on Customers
declare

begin
      DBMS_OUTPUT.PUT_LINE('Customer Entry Successfull');
end;
/
DECLARE
        cid int;
	gid int;
        gquantity int;
        NUM int;
	invalid EXCEPTION;

BEGIN
	cid:=&x;
        gid:=&y;
        gquantity :=&z;

	SELECT COUNT(Cid) INTO NUM FROM Customers;
	
	IF NUM<cid THEN
		RAISE invalid;
		
	ELSE
		DBMS_OUTPUT.PUT_LINE('Grocery_View_ID for Order=' || gid);
               -- DBMS_OUTPUT.PUT_LINE(gid);
                DBMS_OUTPUT.PUT_LINE('Grocery_Quantity for Order=');
               DBMS_OUTPUT.PUT_LINE(gquantity);
            insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate ) values(6,cid,1,1,1,  '09-feb-2022');
	END IF;

EXCEPTION
	WHEN invalid THEN
		CustomerEntry(cid);

	
END;
/