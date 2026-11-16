# DreamHome Supabase demo — run-of-show

Cheat sheet for the 11/16 class. Everything in order, top to bottom.

## Before class

1. **Create the Supabase project** (free plan). Keep the default setting that does **not** automatically expose new tables to the API. Part 3 depends on it.
2. **Copy two values** and paste them into `03_requests.sh` and `index.html`:
   - Project URL: Project Settings → Data API
   - Publishable key (`sb_publishable_…`): Project Settings → API Keys
   - **Never** use the secret key (`sb_secret_…`) in either file.
3. **Create two test users**: Authentication → Users → Add user → Create new user, with **Auto Confirm User** checked.

   | Client | Email | Password |
   |---|---|---|
   | CR56 Aline Stewart | aline.stewart@example.com | *(write it here)* |
   | CR76 John Kay | john.kay@example.com | *(write it here)* |

4. **Make the request script runnable**: `chmod +x 03_requests.sh`
5. **GitHub**: create a repo, push these files, then Settings → Pages → Deploy from a branch → `main` / root. Note the live URL: `https://<username>.github.io/<repo>/`
6. **Rehearse** the full run at least once, starting with `reset.sql`. Write down what each request returns.
7. **Day of class**: open the project in the dashboard. Free projects pause after 7 days without activity.

## During class

| Part | Where | What to run |
|---|---|---|
| 2b | Table Editor | Build `property_for_rent` by clicking, add PG4 (6 Lawrence St, Glasgow, Flat, 3, 350). **Backup:** `00_property_table.sql` |
| 2c | SQL Editor | `01_client_viewing.sql` |
| 2d | SQL Editor | `02_seed.sql`, then the three demo queries at the bottom of it (highlight one, click Run) |
| 3b | Terminal | `./03_requests.sh 1` → expect **permission denied** |
| 3b | SQL Editor | `grant select on property_for_rent to anon, authenticated;` |
| 3b | Terminal | `./03_requests.sh 1` → expect **`[]`** (empty list) |
| 3b | SQL Editor | the "Anyone can view listings" policy (below) |
| 3b | Terminal | `./03_requests.sh 1` → expect **6 rows** |
| 3c | Terminal | `./03_requests.sh 2` → Glasgow under 400 (PG4, PG36) |
| 4a | Terminal | `./03_requests.sh 3` → permission denied (nobody has opened it yet) |
| 4a | SQL Editor | `04_client_mistake.sql` |
| 4a | Terminal | `./03_requests.sh 3` → **every client's data, HTTP 200** |
| 4b | SQL Editor | type the fix live, or paste `04b_client_fix.sql` |
| 4b | Terminal | `./03_requests.sh 3` → blocked again |
| 4b | SQL Editor | `05_viewing_fix.sql`, then `06_link_users.sql` |
| 5 | Browser | open `index.html` locally, then push and open the GitHub Pages URL |
| 5 | Browser | log in as Aline (CR56) → only her 3 viewings appear |

### Part 3b policy (type live)

```sql
create policy "Anyone can view listings"
on property_for_rent
for select
to anon, authenticated
using (true);
```

### What Aline should see after logging in

| Date | Street | Comment |
|---|---|---|
| 2015-04-28 | 2 Manor Rd | — |
| 2015-05-24 | 16 Holhead | too small |
| 2015-05-26 | 6 Lawrence St | — |

John (CR76) should see one viewing: 6 Lawrence St, "too remote".

## Troubleshooting

| You see | It means |
|---|---|
| `permission denied for table …` | No GRANT on that table for this role (door one is closed) |
| `[]` (empty list), HTTP 200 | GRANT is there but RLS has no policy letting this user see any rows (door two) |
| `Invalid API key` / HTTP 401 | Wrong or missing publishable key in the script or page |
| Request hangs or project "paused" | Free project went to sleep. Restore it from the dashboard and wait a minute |
| Logged in, "not linked to a client record" | `06_link_users.sql` wasn't run, or the email in it doesn't match the user you created |
| Query works in SQL Editor but not via the API | Normal. The SQL Editor runs as the owner and skips RLS. Always test from outside |
| Website shows the yellow "Setup needed" banner | URL and key placeholders in `index.html` haven't been replaced |

## Rehearsing again

Run `reset.sql` in the SQL Editor. It drops all three tables, along with their grants and policies. The two test users stay, so you don't need to recreate them.

## After class

- Change both test users' passwords.
- Optional: pause or delete the project.
