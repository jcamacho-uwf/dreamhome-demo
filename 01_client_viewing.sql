-- 01_client_viewing.sql
-- Part 2c: create the client and viewing tables with SQL.
-- Run AFTER property_for_rent exists (viewing has a foreign key to it).

create table client (
  client_no  text primary key,
  f_name     text not null,
  l_name     text not null,
  tel_no     text,
  pref_type  text check (pref_type in ('House', 'Flat')),
  max_rent   numeric check (max_rent > 0)
);

create table viewing (
  client_no    text references client (client_no),
  property_no  text references property_for_rent (property_no),
  view_date    date not null,
  comment      text,
  primary key (client_no, property_no)
);
