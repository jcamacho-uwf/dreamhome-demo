-- 06_link_users.sql
-- Part 4b: connect the two test logins to client rows.
--
-- BEFORE CLASS: create these two users in Authentication -> Users -> Add user,
-- with "Auto Confirm User" checked. If you use different emails, change them here.
--
-- Run AFTER 04b (which adds the user_id column).
-- This runs in the SQL Editor, which can read Supabase's auth.users table.

update client
set user_id = (select id from auth.users where email = 'aline.stewart@example.com')
where client_no = 'CR56';

update client
set user_id = (select id from auth.users where email = 'john.kay@example.com')
where client_no = 'CR76';

-- Check: both rows should show a long ID in user_id (not null)
select client_no, f_name, l_name, user_id
from client
where client_no in ('CR56', 'CR76');
