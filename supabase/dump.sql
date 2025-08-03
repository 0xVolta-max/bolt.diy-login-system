-- Supabase Auth SQL Setup for bolt.diy
--
-- IMPORTANT:
-- Supabase's built-in `auth` schema provides secure, pre-built functions for all standard user management tasks.
-- It is strongly recommended to use the Supabase client library (e.g., `supabase.auth.signInWithPassword()`, `supabase.auth.signUp()`, etc.)
-- to interact with these functions rather than creating custom SQL functions. This ensures security, scalability, and maintainability.
--
-- This file provides the necessary setup for a `profiles` table in a custom `bolt_diy` schema to store user-specific, non-sensitive data
-- that is linked to the `auth.users` table.

-- 0. Create the custom schema
CREATE SCHEMA IF NOT EXISTS bolt_diy;

-- 1. Create the `profiles` table in the `bolt_diy` schema
-- This table will store public user data.
CREATE TABLE bolt_diy.profiles (
  id UUID NOT NULL PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT UNIQUE,
  full_name TEXT,
  avatar_url TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Set up Row Level Security (RLS) policies
-- RLS ensures that users can only access and modify their own data.
ALTER TABLE bolt_diy.profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view all public profiles
CREATE POLICY "Public profiles are viewable by everyone."
  ON bolt_diy.profiles FOR SELECT
  USING ( true );

-- Policy: Users can insert their own profile
CREATE POLICY "Users can insert their own profile."
  ON bolt_diy.profiles FOR INSERT
  WITH CHECK ( auth.uid() = id );

-- Policy: Users can update their own profile
CREATE POLICY "Users can update their own profile."
  ON bolt_diy.profiles FOR UPDATE
  USING ( auth.uid() = id );

-- 3. Create a trigger to automatically create a profile on new user sign-up
-- This function will be called every time a new user is created in `auth.users`.
CREATE OR REPLACE FUNCTION bolt_diy.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO bolt_diy.profiles (id, username)
  VALUES (new.id, new.email);
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create the trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE bolt_diy.handle_new_user();

-- 4. Function Usage from Frontend (Example)
-- The following actions should be performed from your Next.js app using the Supabase client library, not directly in SQL.
-- When querying the profiles table, you must specify the schema.

/*
// Sign up a new user
await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'password123',
});

// Sign in a user
await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'password123',
});

// Sign out a user
await supabase.auth.signOut();

// Send a password reset email
await supabase.auth.resetPasswordForEmail('user@example.com');

// Update user password (when logged in)
await supabase.auth.updateUser({
  password: 'new_password'
});

// Update user profile data
await supabase.from('profiles').schema('bolt_diy').update({
  username: 'new_username',
  full_name: 'New Name'
}).eq('id', user.id);
*/