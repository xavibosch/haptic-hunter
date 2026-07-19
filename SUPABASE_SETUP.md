# Supabase setup

1. Create a Supabase project.
2. Run `supabase/migrations/20260718173000_create_leaderboard.sql` in the SQL editor.
3. In Authentication → Email Templates → Magic Link, show `{{ .Token }}` so the app receives a 6-digit OTP instead of requiring a browser redirect.
4. Copy the Project URL and publishable key into `haptichunter/Info.plist`.
5. Never add a secret or `service_role` key to the app.

Leaderboard reading is public. Supabase Auth is only opened when a player taps **Participar / Join event**. Sessions are stored in the iOS Keychain. RLS restricts score writes to the authenticated user's row.
