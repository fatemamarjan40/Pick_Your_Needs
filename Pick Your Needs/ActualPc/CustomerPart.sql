clear screen;

drop table Customers CASCADE CONSTRAINTS;
drop table Orders1 CASCADE CONSTRAINTS;


create table Customers(Cid int, Cname varchar2(20), Cphone varchar2(20),PRIMARY KEY (Cid));

select * from Customers; 



create table Orders1(Oid int, Cid int,Gid int,Quantity int);

select * from Orders1; 

insert into Customers values('1', 'jimi',  '01984455607');
insert into Customers values('2', 'tom',  '01884455007');
insert into Customers values('3', 'pit',  '01784488867');
insert into Customers values('4', 'asus',  '01684452267');
insert into Customers values('5', 'jenifer',  '01984666677');

select * from Customers; 

insert into Orders1(Oid,Cid, Gid, Quantity) values(1,1,1,1);
insert into Orders1(Oid,Cid,Gid, Quantity)  values(2,2,2,2);
insert into Orders1(Oid,Cid, Gid, Quantity)  values(3,3,3,3);
insert into Orders1(Oid,Cid,Gid, Quantity)  values(4,4,4,4);
insert into Orders1(Oid,Cid,Gid, Quantity)  values(5,5,5,5);


select * from Orders1; 

select * from myview@site1;

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
                DBMS_OUTPUT.PUT_LINE('Grocery_Quantity for Order=' || gquantity);
               
            insert into Orders1(Oid,Cid,Gid, Quantity) values(6,cid,1,1);
            
	END IF;

EXCEPTION
	WHEN invalid THEN
		CustomerEntry(cid);

	
END;
/