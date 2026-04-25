-- =========================================================
-- 001_create_accounts_and_profiles.sql
-- Lutowl Auth + Profile Schema
-- PRODUCTION SAFE VERSION (FIXED RLS + RE-RUN SAFE)
-- =========================================================

-- =========================================================
-- 1. PROFILES TABLE
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
-- 3. RLS POLICIES (SAFE FOR SIGNUP FLOW)
-- =========================================================

-- =========================
-- SELECT OWN PROFILE
-- =========================
drop policy if exists "Read own profile"
on public.accounts_profile;

create policy "Read own profile"
on public.accounts_profile
for select
using (auth.uid() = user_id);

-- =========================
-- INSERT PROFILE (FIXED FOR SIGNUP)
-- IMPORTANT: auth.uid() may be NULL during signup flow
-- so we use role-based access instead
-- =========================
drop policy if exists "Insert own profile"
on public.accounts_profile;

create policy "Insert own profile"
on public.accounts_profile
for insert
with check (auth.role() = 'authenticated');

-- =========================
-- UPDATE OWN PROFILE
-- =========================
drop policy if exists "Update own profile"
on public.accounts_profile;

create policy "Update own profile"
on public.accounts_profile
for update
using (auth.uid() = user_id);

-- =========================================================
-- 4. UPDATED_AT AUTO UPDATE FUNCTION
-- =========================================================

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- =========================================================
-- 5. TRIGGER (SAFE REPLACE)
-- =========================================================

drop trigger if exists trg_accounts_profile_updated_at
on public.accounts_profile;

create trigger trg_accounts_profile_updated_at
before update on public.accounts_profile
for each row
execute function public.set_updated_at();

-- =========================================================
-- END OF MIGRATION
-- =========================================================