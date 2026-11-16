-- 02_seed.sql
-- Part 2d: DreamHome sample data (from the Connolly & Begg DreamHome instance).
-- Dates vary between editions of the textbook; these are close enough for a demo.
--
-- "on conflict ... do nothing" means re-running this file is harmless,
-- and it skips PG4 if you already added it by hand in the Table Editor.

-- Properties (6 rows)
insert into property_for_rent (property_no, street, city, type, rooms, rent) values
  ('PA14', '16 Holhead',    'Aberdeen', 'House', 6, 650),
  ('PL94', '6 Argyll St',   'London',   'Flat',  4, 400),
  ('PG4',  '6 Lawrence St', 'Glasgow',  'Flat',  3, 350),
  ('PG36', '2 Manor Rd',    'Glasgow',  'Flat',  3, 375),
  ('PG21', '18 Dale Rd',    'Glasgow',  'House', 5, 600),
  ('PG16', '5 Novar Dr',    'Glasgow',  'Flat',  4, 450)
on conflict (property_no) do nothing;

-- Clients (4 rows)
insert into client (client_no, f_name, l_name, tel_no, pref_type, max_rent) values
  ('CR76', 'John',  'Kay',     '0207-774-5632', 'Flat',  425),
  ('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat',  350),
  ('CR74', 'Mike',  'Ritchie', '01475-392178',  'House', 750),
  ('CR62', 'Mary',  'Tregear', '01224-196720',  'Flat',  600)
on conflict (client_no) do nothing;

-- Viewings (5 rows)
insert into viewing (client_no, property_no, view_date, comment) values
  ('CR56', 'PA14', '2015-05-24', 'too small'),
  ('CR76', 'PG4',  '2015-04-20', 'too remote'),
  ('CR56', 'PG4',  '2015-05-26', null),
  ('CR62', 'PA14', '2015-05-14', 'no dining room'),
  ('CR56', 'PG36', '2015-04-28', null)
on conflict (client_no, property_no) do nothing;


-- ---------------------------------------------------------------
-- Part 2d demo queries (run one at a time; highlight a query and
-- click Run to run just that one)
-- ---------------------------------------------------------------

-- Glasgow properties under 400, cheapest first
-- select street, city, rent
-- from property_for_rent
-- where city = 'Glasgow' and rent < 400
-- order by rent;

-- Who looked at which property, and what did they say?
-- select c.f_name, c.l_name, p.street, v.comment
-- from viewing v
-- join client c on c.client_no = v.client_no
-- join property_for_rent p on p.property_no = v.property_no;

-- Break a rule on purpose: this should FAIL the CHECK constraint
-- insert into client (client_no, f_name, l_name, max_rent)
-- values ('CR99', 'Test', 'Person', -50);
