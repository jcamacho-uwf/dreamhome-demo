-- 05_viewing_fix.sql
-- Part 4b: the same kind of protection for the viewing table.
-- Run AFTER 04b (the rule below relies on client.user_id existing).

-- Door one: only logged-in users can query viewings at all
grant select on viewing to authenticated;

-- Door two: each logged-in client sees only their own viewings.
-- In English: "show a viewing row only if its client_no belongs to
-- the client record linked to whoever is logged in."
alter table viewing enable row level security;

create policy "Clients see only their own viewings"
on viewing
for select
to authenticated
using (
  client_no in (
    select client_no
    from client
    where user_id = (select auth.uid())
  )
);
