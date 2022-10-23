create or replace view myview(viewa, viewb, viewc) as 
select s.Gid, s.Gname, s.Price_in_taka
from GroceryItems s;
select * from myview;
commit;