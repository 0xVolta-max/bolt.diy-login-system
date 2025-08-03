'use client'

import { useState } from 'react'
import { createClient } from '@/utils/supabase/client'

export default function LoginForm() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState<string | null>(null)

  const handleLogin = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    setError(null)

    const supabase = createClient()
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })

    if (error) {
      setError(error.message)
    }
  }

  return (
    <form
      onSubmit={handleLogin}
      className="flex flex-col w-full max-w-sm p-8 space-y-4 rounded-lg bg-surface"
    >
      <h1 className="text-2xl font-bold text-center text-text-primary">Login</h1>
      <div className="flex flex-col space-y-1">
        <label className="text-sm font-medium text-text-secondary" htmlFor="email">
          Email
        </label>
        <input
          id="email"
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="px-4 py-2 text-white rounded-lg bg-background border border-border focus:outline-none focus:ring-2 focus:ring-primary"
          required
        />
      </div>
      <div className="flex flex-col space-y-1">
        <label className="text-sm font-medium text-text-secondary" htmlFor="password">
          Password
        </label>
        <input
          id="password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="px-4 py-2 text-white rounded-lg bg-background border border-border focus:outline-none focus:ring-2 focus:ring-primary"
          required
        />
      </div>
      <button
        type="submit"
        className="px-4 py-2 font-bold text-white rounded-lg bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-primary"
      >
        Login
      </button>
      {error && <p className="text-sm text-center text-red-500">{error}</p>}
    </form>
  )
}