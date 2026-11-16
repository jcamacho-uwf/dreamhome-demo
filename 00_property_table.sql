-- 00_property_table.sql
-- BACKUP ONLY. Use this if the Table Editor misbehaves during Part 2b.
-- It creates the same table you would have built by clicking, including
-- the PG4 row you would have added with "Insert row".
--
-- Tables built in the Table Editor get Row Level Security turned on
-- automatically. Tables built with SQL do not, so we turn it on here
-- to match. Part 3 depends on RLS being ON for this table.

create table property_for_rent (
  property_no  text primary key,
  street       text,
  city         text,
  type         text,
  rooms        int4,
  rent         numeric
);

alter table property_for_rent enable row level security;

insert into property_for_rent (property_no, street, city, type, rooms, rent)
values ('PG4', '6 Lawrence St', 'Glasgow', 'Flat', 3, 350);
