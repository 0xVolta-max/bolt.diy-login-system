# Bolt.diy Login Page

This is a Next.js project for the bolt.diy login page, using Supabase for authentication and Tailwind CSS for styling.

## Getting Started

First, install the dependencies:

```bash
npm install
```

Next, create a `.env.local` file in the root of the project and add your Supabase credentials:

```
NEXT_PUBLIC_SUPABASE_URL=YOUR_SUPABASE_URL
NEXT_PUBLIC_SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

Finally, run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Project Structure

- `src/pages/index.tsx`: The main login page.
- `src/components/LoginForm.tsx`: The login form component.
- `src/utils/supabase/client.ts`: The Supabase client.
- `src/styles/globals.css`: Global styles and Tailwind CSS configuration.
- `tailwind.config.ts`: Tailwind CSS configuration.
- `postcss.config.js`: PostCSS configuration.
- `next.config.js`: Next.js configuration.
- `tsconfig.json`: TypeScript configuration.
- `package.json`: Project dependencies.

## Extensibility

The project is structured to be easily extensible. You can add new features like "Password forgotten" or "New user account" by creating new components and adding them to the `src/pages` directory.

### Password Forgotten

To add a "Password forgotten" feature, you can create a new page in `src/pages/password-forgotten.tsx` and a new component in `src/components/PasswordForgottenForm.tsx`. The form would take an email address as input and use the `supabase.auth.resetPasswordForEmail()` method to send a password reset email to the user.

### New User Account

To add a "New user account" feature, you can create a new page in `src/pages/register.tsx` and a new component in `src/components/RegisterForm.tsx`. The form would take an email address and password as input and use the `supabase.auth.signUp()` method to create a new user.

## To-Do List

- [x] Create Next.js project
- [x] Add Tailwind CSS
- [x] Add Supabase client
- [x] Create login form
- [ ] Add "Password forgotten" feature
- [ ] Add "New user account" feature
- [ ] Add form validation
- [ ] Add loading states
- [ ] Add success and error notifications
- [ ] Add e2e tests