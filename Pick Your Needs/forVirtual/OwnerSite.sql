clear screen;


drop table Employee CASCADE CONSTRAINTS;
drop table GroceryItems CASCADE CONSTRAINTS;
drop table Orders CASCADE CONSTRAINTS;





--drop table Employee;
create table Employee(Eid int  , Ename varchar2(20), Ephone varchar2(20),PRIMARY KEY (Eid));

select * from Employee; 

 

--drop table GroceryItems;
create table GroceryItems(Gid int, Gname varchar2(30), Price_in_taka int,Available int, PRIMARY KEY (Gid));

select * from GroceryItems; 




--drop table Orders;
create table Orders(Oid int, Cid int, Eid int,Gid int,Quantity int, orderdate date);

select * from Orders; 


insert into Employee values('1', 'john',  '01984455667');
insert into Employee values('2', 'jery',  '01884455667');
insert into Employee values('3', 'jam',  '01784455867');
insert into Employee values('4', 'ashu',  '01684455667');
insert into Employee values('5', 'john',  '01984455667');

select * from Employee; 

insert into GroceryItems values('1', 'Onion',  '19','30');
insert into GroceryItems values('2', 'Horlicks',  '445', '7');
insert into GroceryItems values('3', 'Potato',  '17','25');
insert into GroceryItems values('4', 'Alovera',  '20', '10');
insert into GroceryItems values('5', 'Butter',  '199', '3');

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

SET SERVEROUTPUT ON;
SET VERIFY OFF;

Accept x number prompt "Requested grocery_ID:"
Accept y number prompt "Requested grocery_Quantity:"

CREATE OR REPLACE PROCEDURE UpdateAvailable(AC in GroceryItems.Available%TYPE, Rid in GroceryItems.Gid%Type)
IS
BEGIN
	UPDATE GroceryItems SET Available = AC where Gid = Rid;
	--DBMS_OUTPUT.PUT_LINE('done');
END UpdateAvailable;
/

CREATE OR REPLACE PROCEDURE DeleteRow(Rid in GroceryItems.Gid%Type)
IS
BEGIN
	DELETE FROM GroceryItems WHERE Gid=Rid;
        DBMS_OUTPUT.PUT_LINE('done');
END DeleteRow;
/
create or replace trigger UpadateTrigger
after UPDATE 
on GroceryItems
declare

begin
      DBMS_OUTPUT.PUT_LINE('Available of Quantity Updated');
end;
/

create or replace trigger DeleteTrigger
after DELETE 
on GroceryItems
declare

begin
      DBMS_OUTPUT.PUT_LINE('Product is now Unavailable');
end;
/

DECLARE 
    RgId int;
    RgQ int;
    Bill int;
    Availablecheck int;
     G_price GroceryItems.Price_in_taka%Type;
      g_Available GroceryItems.Available%Type;
BEGIN
     RgId:=&x;
     RgQ := &y;
   select Price_in_taka,Available into G_price,G_Available from GroceryItems where Gid= RgId;
           Bill := G_price * RgQ;
           Availablecheck := G_Available - RgQ;
       DBMS_OUTPUT.PUT_LINE('Total Bill=' || Bill || 'Taka');

       IF(Availablecheck>0) THEN
        UpdateAvailable(Availablecheck,RgId);
       ELSE
        DeleteRow(RgId);
     END IF;     
 
     --insert into Orders(Oid, Cid, Eid, Gid, Quantity, orderdate )  values(2,2,2,RgID,RgQ,  '01-jan-2022');

     
END;
/