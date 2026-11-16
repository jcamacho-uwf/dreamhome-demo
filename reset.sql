-- reset.sql
-- REHEARSAL ONLY. Wipes the demo so you can run it again from the start.
-- Dropping the tables also removes their grants and RLS policies.
-- Your two test users in Authentication -> Users are NOT deleted, so you
-- don't need to recreate them; just re-run 06_link_users.sql at the right time.
--
-- Order matters: viewing points at client and property_for_rent, so it goes first.

drop table if exists viewing;
drop table if exists client;
drop table if exists property_for_rent;
