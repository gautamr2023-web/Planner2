# JEE Mains Planner (Supabase + installable app)

A static site: no build step. Sign in on any device and the plan syncs live through Supabase. It installs to the phone home screen and opens offline.

## Set up (about 10 minutes)

1. **Create the table.** (Already done for this project; only needed for a different Supabase project.) In Supabase, open SQL Editor, paste `supabase/schema.sql` and press Run. It creates `planner_state` with row-level security, so each student can only read and write their own plan, and turns on live updates.
2. **Add your keys.** (Already filled in for this project.) Open `config.js` and paste your Project URL and the anon (or publishable) key from Project Settings > API.
3. **Allow your site address for sign-in.** Authentication > URL Configuration: set Site URL to your published address (for example `https://yourname.github.io/jee-planner/`) and add the same address under Redirect URLs. Email links and confirmation mails use it.
4. **Choose how students sign up.** Authentication > Providers > Email is on by default. For quick sign-up with no confirmation mail, turn off "Confirm email". Leave it on if you want verified addresses.
5. **Publish.** Put this whole folder in a GitHub repo and turn on GitHub Pages (Settings > Pages > Deploy from branch). Open the address on the phone and the laptop.

## Install on the phone

- Android / Chrome: menu > Install app (or Add to Home screen).
- iPhone / Safari: Share > Add to Home Screen.

## How sync works

- The plan is one row per user (`planner_state.plan`). The newest edit wins.
- Edits save about a second after you stop typing. If the phone is offline, the app keeps the changes and sends them when the connection returns.
- The status line at the top shows the state. Tap it to sign in, sync now or sign out. Signing out clears the copy on that device.

## Updating the app

Replace the files and change `VERSION` in `sw.js` (for example `jee-planner-v2`) so phones pick up the new version.

## Files

- `index.html` the app
- `config.js` your Supabase URL and key
- `sw.js`, `manifest.webmanifest`, `icons/` offline support and install
- `vendor/supabase.js` Supabase client (v2.45.4), bundled so the app also works offline
- `supabase/schema.sql` table and security rules
