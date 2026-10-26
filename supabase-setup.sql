-- Jalankan di Supabase Dashboard > SQL Editor > New query.
create table if not exists public.kampushub_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.kampushub_data enable row level security;

-- Policies ini membatasi setiap baris hanya untuk pemilik akun.
drop policy if exists "Users can read own data" on public.kampushub_data;
create policy "Users can read own data"
on public.kampushub_data for select to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert own data" on public.kampushub_data;
create policy "Users can insert own data"
on public.kampushub_data for insert to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update own data" on public.kampushub_data;
create policy "Users can update own data"
on public.kampushub_data for update to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

-- Izinkan operasi hanya bagi pengguna yang login; RLS tetap memfilter baris pemiliknya.
revoke all on public.kampushub_data from anon;
grant select, insert, update on public.kampushub_data to authenticated;
