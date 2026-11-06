-- JEE Mains Planner: one row per user holding their whole plan.
create table if not exists public.planner_state (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  plan       jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.planner_state enable row level security;

drop policy if exists "planner select own" on public.planner_state;
drop policy if exists "planner insert own" on public.planner_state;
drop policy if exists "planner update own" on public.planner_state;
drop policy if exists "planner delete own" on public.planner_state;

create policy "planner select own" on public.planner_state for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "planner insert own" on public.planner_state for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "planner update own" on public.planner_state for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "planner delete own" on public.planner_state for delete to authenticated
  using ((select auth.uid()) = user_id);

-- live updates between devices
do $$
begin
  if not exists (select 1 from pg_publication_tables where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'planner_state') then
    alter publication supabase_realtime add table public.planner_state;
  end if;
end $$;
