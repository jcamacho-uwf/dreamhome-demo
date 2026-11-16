-- 04_client_mistake.sql
-- Part 4a: THE DELIBERATE MISTAKE.
-- Opens the client table to anyone holding the public (publishable) key.
-- The client table was created with SQL, so Row Level Security is OFF:
-- there is no "door two" at all.
--
-- After running this, ./03_requests.sh 3 returns every client's
-- name, phone number, and budget, with HTTP 200.

grant select on client to anon;
