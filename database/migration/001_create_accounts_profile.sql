-- =========================================================
-- 001_create_accounts_and_profiles.sql
-- Lutowl Auth + Profile Schema
-- =========================================================

-- =========================================================
-- 1. PROFILES TABLE
-- (auth.users is managed by Supabase automatically)
-- =========================================================

create table if not exists public.accounts_profile (
  user_id uuid primary key references auth.users(id) on delete cascade,

  username text not null,
  phone text,

  created_at timestamp default now(),
  updated_at timestamp default now()
);

-- =========================================================
-- 2. ENABLE ROW LEVEL SECURITY
-- =========================================================

alter table public.accounts_profile enable row level security;

-- =========================================================
-- 3. RLS POLICIES
-- =========================================================

-- SELECT own profile only
create policy "Read own profile"
on public.accounts_profile
for select
using (auth.uid() = user_id);

-- INSERT own profile only
create policy "Insert own profile"
on public.accounts_profile
for insert
with check (auth.uid() = user_id);

-- UPDATE own profile only
create policy "Update own profile"
on public.accounts_profile
for update
using (auth.uid() = user_id);

-- =========================================================
-- 4. OPTIONAL: UPDATED_AT AUTO UPDATE FUNCTION
-- =========================================================

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Trigger for auto-updating timestamp
create trigger trg_accounts_profile_updated_at
before update on public.accounts_profile
for each row
execute function public.set_updated_at();

-- =========================================================
-- END OF MIGRATION
-- =========================================================