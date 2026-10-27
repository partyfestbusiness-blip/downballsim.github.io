create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  username text not null default 'Player',
  coins integer not null default 0 check (coins >= 0),
  sprint integer not null default 0 check (sprint between 0 and 5),
  movement integer not null default 0 check (movement between 0 and 5),
  updated_at timestamptz not null default now()
);

alter table public.profiles add column if not exists username text not null default 'Player';
alter table public.profiles add column if not exists coins integer not null default 0;
alter table public.profiles add column if not exists sprint integer not null default 0;
alter table public.profiles add column if not exists movement integer not null default 0;
alter table public.profiles add column if not exists updated_at timestamptz not null default now();

alter table public.profiles enable row level security;
grant usage on schema public to authenticated;
grant select, insert, update on public.profiles to authenticated;

drop policy if exists "Users can read own profile" on public.profiles;
drop policy if exists "Users can insert own profile" on public.profiles;
drop policy if exists "Users can update own profile" on public.profiles;
create policy "Users can read own profile" on public.profiles
  for select to authenticated using (auth.uid() = user_id);
create policy "Users can insert own profile" on public.profiles
  for insert to authenticated with check (auth.uid() = user_id);
create policy "Users can update own profile" on public.profiles
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

create table if not exists public.public_rooms (
  room_code text primary key,
  mode text not null default 'online1' check (mode in ('online1','online2','online4')),
  host_name text not null default 'Guest',
  players_count integer not null default 1 check (players_count between 1 and 4),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.public_rooms enable row level security;
grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.public_rooms to anon, authenticated;

drop policy if exists "Anyone can view public room listings" on public.public_rooms;
drop policy if exists "Anyone can create public room listings" on public.public_rooms;
drop policy if exists "Anyone can update public room listings" on public.public_rooms;
drop policy if exists "Anyone can delete public room listings" on public.public_rooms;
create policy "Anyone can view public room listings" on public.public_rooms
  for select to anon, authenticated using (true);
create policy "Anyone can create public room listings" on public.public_rooms
  for insert to anon, authenticated with check (true);
create policy "Anyone can update public room listings" on public.public_rooms
  for update to anon, authenticated using (true) with check (true);
create policy "Anyone can delete public room listings" on public.public_rooms
  for delete to anon, authenticated using (true);

notify pgrst, 'reload schema';
