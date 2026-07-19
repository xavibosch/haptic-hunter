create table if not exists public.leaderboard_entries (
  id uuid primary key default gen_random_uuid(),
  event_id text not null check (event_id ~ '^daily-[0-9]{4}-[0-9]{2}-[0-9]{2}$'),
  user_id uuid not null references auth.users(id) on delete cascade,
  display_name text not null check (char_length(display_name) between 1 and 24),
  score integer not null check (score between 0 and 1000000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (event_id, user_id)
);

create index if not exists leaderboard_entries_event_score_idx
  on public.leaderboard_entries (event_id, score desc, created_at asc);

alter table public.leaderboard_entries enable row level security;

drop policy if exists "leaderboards are public" on public.leaderboard_entries;
create policy "leaderboards are public"
  on public.leaderboard_entries
  for select
  to anon, authenticated
  using (true);

drop policy if exists "players insert their own score" on public.leaderboard_entries;
create policy "players insert their own score"
  on public.leaderboard_entries
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "players update their own score" on public.leaderboard_entries;
create policy "players update their own score"
  on public.leaderboard_entries
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create or replace function public.keep_best_leaderboard_score()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.score := greatest(old.score, new.score);
  new.created_at := case when new.score > old.score then now() else old.created_at end;
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists keep_best_leaderboard_score on public.leaderboard_entries;
create trigger keep_best_leaderboard_score
before update on public.leaderboard_entries
for each row execute function public.keep_best_leaderboard_score();

revoke all on table public.leaderboard_entries from anon, authenticated;
grant select on table public.leaderboard_entries to anon;
grant select, insert, update on table public.leaderboard_entries to authenticated;

revoke all on function public.keep_best_leaderboard_score() from public, anon, authenticated;
