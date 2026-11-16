-- 04b_client_fix.sql
-- Part 4b: the fix for the client table.
-- The script types these live, one block at a time. This file is the
-- paste-in copy if you'd rather not type, or are running short on time.

-- 1. Connect each client row to a Supabase login
alter table client add column user_id uuid references auth.users;

-- 2. Door one: logged-out visitors lose access; logged-in users get it
revoke select on client from anon;
grant select on client to authenticated;

-- 3. Door two: turn on Row Level Security and write the rule
alter table client enable row level security;

create policy "Clients see only their own record"
on client
for select
to authenticated
using ( (select auth.uid()) = user_id );
