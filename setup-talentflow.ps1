# Script de configuração do TalentFlow ATS
Write-Host "Criando estrutura do projeto TalentFlow ATS..." -ForegroundColor Green

# Criar estrutura de pastas
$folders = @(
    "src/api",
    "src/assets/styles",
    "src/assets/images",
    "src/components/ui",
    "src/components/candidates",
    "src/components/jobs",
    "src/components/charts",
    "src/components/layout",
    "src/context",
    "src/features/candidates",
    "src/features/jobs",
    "src/features/dashboard",
    "src/hooks",
    "src/lib/constants",
    "src/lib/helpers",
    "src/lib/types",
    "src/pages/Auth",
    "src/pages/Candidates",
    "src/pages/Dashboard",
    "src/pages/Jobs",
    "src/pages/Settings"
)

foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Write-Host "Pasta criada: $folder" -ForegroundColor Yellow
    }
}

# 1. Criar package.json
$packageJson = @'
{
  "name": "talentflow-ats",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.8.1",
    "recharts": "^2.5.0"
  },
  "devDependencies": {
    "@types/react": "^18.0.28",
    "@types/react-dom": "^18.0.11",
    "@typescript-eslint/eslint-plugin": "^5.57.1",
    "@typescript-eslint/parser": "^5.57.1",
    "@vitejs/plugin-react": "^3.1.0",
    "autoprefixer": "^10.4.14",
    "eslint": "^8.38.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.3.4",
    "postcss": "^8.4.21",
    "tailwindcss": "^3.2.7",
    "typescript": "^4.9.5",
    "vite": "^4.2.0"
  }
}
'@
Set-Content -Path "package.json" -Value $packageJson
Write-Host "package.json criado" -ForegroundColor Green

# 2. Criar index.html
$indexHtml = @'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TalentFlow ATS</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
'@
Set-Content -Path "index.html" -Value $indexHtml
Write-Host "index.html criado" -ForegroundColor Green

# 3. Criar vite.config.ts
$viteConfig = @'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
  },
})
'@
Set-Content -Path "vite.config.ts" -Value $viteConfig
Write-Host "vite.config.ts criado" -ForegroundColor Green

# 4. Criar tsconfig.json
$tsconfig = @'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
'@
Set-Content -Path "tsconfig.json" -Value $tsconfig
Write-Host "tsconfig.json criado" -ForegroundColor Green

# 5. Criar tsconfig.node.json
$tsconfigNode = @'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
'@
Set-Content -Path "tsconfig.node.json" -Value $tsconfigNode
Write-Host "tsconfig.node.json criado" -ForegroundColor Green

# 6. Criar tailwind.config.js
$tailwindConfig = @'
/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class',
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          200: '#bae6fd',
          300: '#7dd3fc',
          400: '#38bdf8',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
        },
      },
    },
  },
  plugins: [],
}
'@
Set-Content -Path "tailwind.config.js" -Value $tailwindConfig
Write-Host "tailwind.config.js criado" -ForegroundColor Green

# 7. Criar postcss.config.js
$postcssConfig = @'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
'@
Set-Content -Path "postcss.config.js" -Value $postcssConfig
Write-Host "postcss.config.js criado" -ForegroundColor Green

# 8. Criar src/main.tsx
$mainTsx = @'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './assets/styles/globals.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
'@
Set-Content -Path "src/main.tsx" -Value $mainTsx
Write-Host "src/main.tsx criado" -ForegroundColor Green

# 9. Criar src/App.tsx
$appTsx = @'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import { AppProvider } from './context/AppContext'
import { AuthProvider } from './context/AuthContext'
import { ThemeContextProvider } from './context/ThemeContext'
import ProtectedRoute from './components/layout/ProtectedRoute'
import Dashboard from './pages/Dashboard/Dashboard'
import Login from './pages/Auth/Login'
import Register from './pages/Auth/Register'
import Candidates from './pages/Candidates/Candidates'
import CandidateDetail from './pages/Candidates/CandidateDetail'
import Jobs from './pages/Jobs/Jobs'
import JobDetail from './pages/Jobs/JobDetail'
import Settings from './pages/Settings/Settings'
import Header from './components/layout/Header'
import Sidebar from './components/layout/Sidebar'

function App() {
  return (
    <AppProvider>
      <ThemeContextProvider>
        <AuthProvider>
          <Router>
            <div className="flex min-h-screen bg-gray-50 dark:bg-gray-900">
              <Sidebar />
              <div className="flex-1 flex flex-col overflow-hidden">
                <Header />
                <main className="flex-1 overflow-x-hidden overflow-y-auto p-4">
                  <Routes>
                    <Route path="/login" element={<Login />} />
                    <Route path="/register" element={<Register />} />
                    <Route element={<ProtectedRoute />}>
                      <Route path="/" element={<Dashboard />} />
                      <Route path="/candidates" element={<Candidates />} />
                      <Route path="/candidates/:id" element={<CandidateDetail />} />
                      <Route path="/jobs" element={<Jobs />} />
                      <Route path="/jobs/:id" element={<JobDetail />} />
                      <Route path="/settings" element={<Settings />} />
                    </Route>
                  </Routes>
                </main>
              </div>
            </div>
          </Router>
        </AuthProvider>
      </ThemeContextProvider>
    </AppProvider>
  )
}

export default App
'@
Set-Content -Path "src/App.tsx" -Value $appTsx
Write-Host "src/App.tsx criado" -ForegroundColor Green

# 10. Criar src/context/AppContext.tsx
$appContext = @'
import { createContext, useContext, useState, ReactNode } from 'react'

interface AppContextType {
  loading: boolean
  setLoading: (value: boolean) => void
  toast: ToastProps | null
  showToast: (props: ToastProps) => void
}

interface ToastProps {
  message: string
  type: 'success' | 'error' | 'warning' | 'info'
  duration?: number
}

const AppContext = createContext<AppContextType | undefined>(undefined)

export const AppProvider = ({ children }: { children: ReactNode }) => {
  const [loading, setLoading] = useState(false)
  const [toast, setToast] = useState<ToastProps | null>(null)

  const showToast = (props: ToastProps) => {
    setToast(props)
    setTimeout(() => setToast(null), props.duration || 3000)
  }

  return (
    <AppContext.Provider value={{ loading, setLoading, toast, showToast }}>
      {children}
    </AppContext.Provider>
  )
}

export const useApp = () => {
  const context = useContext(AppContext)
  if (!context) throw new Error('useApp must be used within AppProvider')
  return context
}
'@
Set-Content -Path "src/context/AppContext.tsx" -Value $appContext
Write-Host "src/context/AppContext.tsx criado" -ForegroundColor Green

# 11. Criar src/context/AuthContext.tsx
$authContext = @'
import { createContext, useContext, useState, ReactNode, useEffect } from 'react'

interface User {
  id: string
  name: string
  email: string
}

interface AuthContextType {
  user: User | null
  login: (email: string, password: string) => Promise<boolean>
  register: (name: string, email: string, password: string) => Promise<boolean>
  logout: () => void
  isAuthenticated: boolean
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null)

  useEffect(() => {
    // Check if user is logged in on initial load
    const savedUser = localStorage.getItem('user')
    if (savedUser) {
      setUser(JSON.parse(savedUser))
    }
  }, [])

  const login = async (email: string, password: string): Promise<boolean> => {
    // Mock authentication - replace with real API call
    if (email === 'admin@example.com' && password === 'password') {
      const userData = { id: '1', name: 'Admin', email }
      setUser(userData)
      localStorage.setItem('user', JSON.stringify(userData))
      return true
    }
    return false
  }

  const register = async (name: string, email: string, password: string): Promise<boolean> => {
    // Mock registration - replace with real API call
    const userData = { id: Date.now().toString(), name, email }
    setUser(userData)
    localStorage.setItem('user', JSON.stringify(userData))
    return true
  }

  const logout = () => {
    setUser(null)
    localStorage.removeItem('user')
  }

  return (
    <AuthContext.Provider value={{
      user,
      login,
      register,
      logout,
      isAuthenticated: !!user
    }}>
      {children}
    </AuthContext.Provider>
  )
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) throw new Error('useAuth must be used within AuthProvider')
  return context
}
'@
Set-Content -Path "src/context/AuthContext.tsx" -Value $authContext
Write-Host "src/context/AuthContext.tsx criado" -ForegroundColor Green

# 12. Criar src/context/ThemeContext.tsx
$themeContext = @'
import { createContext, useContext, useState, ReactNode, useEffect } from 'react'

interface ThemeContextType {
  isDark: boolean
  toggleTheme: () => void
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined)

export const ThemeContextProvider = ({ children }: { children: ReactNode }) => {
  const [isDark, setIsDark] = useState(false)

  useEffect(() => {
    // Check for saved theme preference
    const savedTheme = localStorage.getItem('theme')
    if (savedTheme) {
      setIsDark(savedTheme === 'dark')
    } else {
      // Check for system preference
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
      setIsDark(prefersDark)
    }
  }, [])

  useEffect(() => {
    // Apply theme to document
    if (isDark) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
    localStorage.setItem('theme', isDark ? 'dark' : 'light')
  }, [isDark])

  const toggleTheme = () => {
    setIsDark(!isDark)
  }

  return (
    <ThemeContext.Provider value={{ isDark, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}

export const useTheme = () => {
  const context = useContext(ThemeContext)
  if (!context) throw new Error('useTheme must be used within ThemeContextProvider')
  return context
}
'@
Set-Content -Path "src/context/ThemeContext.tsx" -Value $themeContext
Write-Host "src/context/ThemeContext.tsx criado" -ForegroundColor Green

# 13. Criar src/assets/styles/globals.css
$globalsCss = @'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-gray-50 text-gray-900 dark:bg-gray-900 dark:text-gray-100;
    font-feature-settings: 'rlig' 1, 'calt' 1;
  }
}

@layer components {
  .btn-primary {
    @apply bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 rounded-lg transition-colors;
  }
  
  .input-field {
    @apply w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500 dark:border-gray-600 dark:bg-gray-800;
  }
}

.toast {
  @apply fixed top-4 right-4 z-50 p-4 rounded-lg shadow-lg text-white font-medium;
}

.toast-success {
  @apply toast bg-green-600;
}

.toast-error {
  @apply toast bg-red-600;
}

.toast-warning {
  @apply toast bg-yellow-600;
}

.toast-info {
  @apply toast bg-blue-600;
}
'@
Set-Content -Path "src/assets/styles/globals.css" -Value $globalsCss
Write-Host "src/assets/styles/globals.css criado" -ForegroundColor Green

# 14. Criar src/lib/types/candidate.ts
$candidateTypes = @'
export interface Candidate {
  id: string
  name: string
  email: string
  phone: string
  skills: string[]
  experience: string
  education: string
  status: 'Applied' | 'Interview' | 'Offer' | 'Hired' | 'Rejected'
  appliedDate: string
  interviewDate?: string
  notes?: string
}
'@
Set-Content -Path "src/lib/types/candidate.ts" -Value $candidateTypes
Write-Host "src/lib/types/candidate.ts criado" -ForegroundColor Green

# 15. Criar src/lib/types/job.ts
$jobTypes = @'
export interface Job {
  id: string
  title: string
  department: string
  level: 'Intern' | 'Junior' | 'Mid' | 'Senior' | 'Lead'
  description: string
  requirements: string[]
  location: string
  type: 'Full-time' | 'Part-time' | 'Contract' | 'Remote'
  status: 'Open' | 'Closed' | 'On-hold'
  salaryRange: {
    min: number
    max: number
    currency: string
  }
  applications: number
  createdDate: string
  closedDate?: string
}
'@
Set-Content -Path "src/lib/types/job.ts" -Value $jobTypes
Write-Host "src/lib/types/job.ts criado" -ForegroundColor Green

# 16. Criar src/lib/types/index.ts
$typesIndex = @'
export * from './candidate'
export * from './job'
'@
Set-Content -Path "src/lib/types/index.ts" -Value $typesIndex
Write-Host "src/lib/types/index.ts criado" -ForegroundColor Green

# 17. Criar src/lib/constants/routes.ts
$routesConstants = @'
export const ROUTES = {
  HOME: '/',
  LOGIN: '/login',
  REGISTER: '/register',
  DASHBOARD: '/',
  CANDIDATES: '/candidates',
  JOBS: '/jobs',
  SETTINGS: '/settings',
}
'@
Set-Content -Path "src/lib/constants/routes.ts" -Value $routesConstants
Write-Host "src/lib/constants/routes.ts criado" -ForegroundColor Green

# 18. Criar src/lib/constants/theme.ts
$themeConstants = @'
export const THEME = {
  LIGHT: 'light',
  DARK: 'dark',
}
'@
Set-Content -Path "src/lib/constants/theme.ts" -Value $themeConstants
Write-Host "src/lib/constants/theme.ts criado" -ForegroundColor Green

# 19. Criar src/lib/helpers/dateUtils.ts
$dateUtils = @'
export const formatDate = (dateString: string): string => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

export const formatDateTime = (dateString: string): string => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

export const getDaysAgo = (dateString: string): string => {
  const date = new Date(dateString)
  const now = new Date()
  const diffTime = Math.abs(now.getTime() - date.getTime())
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
  
  if (diffDays === 1) return '1 day ago'
  if (diffDays < 7) return `${diffDays} days ago`
  if (diffDays < 30) return `${Math.ceil(diffDays / 7)} weeks ago`
  return formatDate(dateString)
}
'@
Set-Content -Path "src/lib/helpers/dateUtils.ts" -Value $dateUtils
Write-Host "src/lib/helpers/dateUtils.ts criado" -ForegroundColor Green

# 20. Criar src/lib/helpers/stringUtils.ts
$stringUtils = @'
export const capitalize = (str: string): string => {
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
}

export const truncate = (str: string, length: number): string => {
  if (str.length <= length) return str
  return str.slice(0, length) + '...'
}

export const formatCurrency = (amount: number, currency: string = 'USD'): string => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency,
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(amount)
}
'@
Set-Content -Path "src/lib/helpers/stringUtils.ts" -Value $stringUtils
Write-Host "src/lib/helpers/stringUtils.ts criado" -ForegroundColor Green

# 21. Criar src/api/apiClient.ts
$apiClient = @'
const BASE_URL = 'http://localhost:3001/api'

export const apiClient = {
  get: async (endpoint: string) => {
    const response = await fetch(`${BASE_URL}${endpoint}`)
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return response.json()
  },

  post: async (endpoint: string, data: any) => {
    const response = await fetch(`${BASE_URL}${endpoint}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    })
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return response.json()
  },

  put: async (endpoint: string, data: any) => {
    const response = await fetch(`${BASE_URL}${endpoint}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    })
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return response.json()
  },

  delete: async (endpoint: string) => {
    const response = await fetch(`${BASE_URL}${endpoint}`, {
      method: 'DELETE',
    })
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return response.json()
  },
}

export default apiClient
'@
Set-Content -Path "src/api/apiClient.ts" -Value $apiClient
Write-Host "src/api/apiClient.ts criado" -ForegroundColor Green

# 22. Criar src/api/mockData.ts
$mockData = @'
import { Candidate } from '../lib/types/candidate'
import { Job } from '../lib/types/job'

export const mockCandidates: Candidate[] = [
  {
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+1 (555) 123-4567',
    skills: ['React', 'TypeScript', 'Node.js', 'CSS'],
    experience: '5 years',
    education: 'BS in Computer Science',
    status: 'Interview',
    appliedDate: '2023-03-15',
    interviewDate: '2023-03-20',
    notes: 'Strong React skills, good communication'
  },
  {
    id: '2',
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    phone: '+1 (555) 987-6543',
    skills: ['Angular', 'Java', 'Spring Boot', 'SQL'],
    experience: '7 years',
    education: 'MS in Software Engineering',
    status: 'Applied',
    appliedDate: '2023-03-18',
    notes: 'Extensive backend experience'
  },
  {
    id: '3',
    name: 'Mike Johnson',
    email: 'mike.johnson@example.com',
    phone: '+1 (555) 456-7890',
    skills: ['Vue.js', 'JavaScript', 'HTML', 'CSS'],
    experience: '3 years',
    education: 'BS in Web Development',
    status: 'Hired',
    appliedDate: '2023-02-10',
    interviewDate: '2023-02-15',
    notes: 'Great cultural fit, quick learner'
  },
  {
    id: '4',
    name: 'Sarah Wilson',
    email: 'sarah.wilson@example.com',
    phone: '+1 (555) 234-5678',
    skills: ['Python', 'Django', 'PostgreSQL', 'Docker'],
    experience: '4 years',
    education: 'BS in Computer Engineering',
    status: 'Offer',
    appliedDate: '2023-03-12',
    interviewDate: '2023-03-17',
    notes: 'Strong problem-solving skills'
  },
  {
    id: '5',
    name: 'David Brown',
    email: 'david.brown@example.com',
    phone: '+1 (555) 876-5432',
    skills: ['React Native', 'Firebase', 'Redux', 'Jest'],
    experience: '2 years',
    education: 'BS in Mobile Development',
    status: 'Rejected',
    appliedDate: '2023-03-05',
    interviewDate: '2023-03-10',
    notes: 'Lacked required testing experience'
  }
]

export const mockJobs: Job[] = [
  {
    id: '1',
    title: 'Senior Frontend Developer',
    department: 'Engineering',
    level: 'Senior',
    description: 'We are looking for a skilled Frontend Developer to join our team...',
    requirements: ['React', 'TypeScript', '5+ years experience', 'CSS expertise'],
    location: 'Remote',
    type: 'Full-time',
    status: 'Open',
    salaryRange: {
      min: 90000,
      max: 130000,
      currency: 'USD'
    },
    applications: 24,
    createdDate: '2023-02-01'
  },
  {
    id: '2',
    title: 'Backend Engineer',
    department: 'Engineering',
    level: 'Mid',
    description: 'Join our backend team to build scalable APIs and services...',
    requirements: ['Node.js', 'Python', '3+ years experience', 'Database knowledge'],
    location: 'San Francisco, CA',
    type: 'Full-time',
    status: 'Open',
    salaryRange: {
      min: 85000,
      max: 120000,
      currency: 'USD'
    },
    applications: 18,
    createdDate: '2023-02-15'
  },
  {
    id: '3',
    title: 'UX Designer',
    department: 'Design',
    level: 'Senior',
    description: 'Create beautiful and intuitive user experiences for our products...',
    requirements: ['Figma', 'User research', '5+ years experience', 'Prototyping'],
    location: 'New York, NY',
    type: 'Full-time',
    status: 'On-hold',
    salaryRange: {
      min: 80000,
      max: 110000,
      currency: 'USD'
    },
    applications: 15,
    createdDate: '2023-01-20'
  },
  {
    id: '4',
    title: 'DevOps Engineer',
    department: 'Operations',
    level: 'Senior',
    description: 'Manage our cloud infrastructure and CI/CD pipelines...',
    requirements: ['AWS', 'Docker', 'Kubernetes', '4+ years experience'],
    location: 'Remote',
    type: 'Full-time',
    status: 'Open',
    salaryRange: {
      min: 100000,
      max: 140000,
      currency: 'USD'
    },
    applications: 12,
    createdDate: '2023-03-01'
  },
  {
    id: '5',
    title: 'Product Manager',
    department: 'Product',
    level: 'Lead',
    description: 'Lead product development and work with cross-functional teams...',
    requirements: ['Product strategy', 'Agile methodology', '6+ years experience'],
    location: 'Austin, TX',
    type: 'Full-time',
    status: 'Closed',
    salaryRange: {
      min: 110000,
      max: 150000,
      currency: 'USD'
    },
    applications: 32,
    createdDate: '2023-01-10',
    closedDate: '2023-02-28'
  }
]
'@
Set-Content -Path "src/api/mockData.ts" -Value $mockData
Write-Host "src/api/mockData.ts criado" -ForegroundColor Green

# 23. Criar src/api/candidateAPI.ts
$candidateApi = @'
import { Candidate } from '../lib/types/candidate'
import { mockCandidates } from './mockData'

// Simulate network delay
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms))

export const getCandidates = async (): Promise<Candidate[]> => {
  await delay(500)
  return mockCandidates
}

export const getCandidateById = async (id: string): Promise<Candidate> => {
  await delay(300)
  const candidate = mockCandidates.find(c => c.id === id)
  if (!candidate) throw new Error('Candidate not found')
  return candidate
}

export const createCandidate = async (candidate: Omit<Candidate, 'id'>): Promise<Candidate> => {
  await delay(400)
  const newCandidate: Candidate = {
    ...candidate,
    id: Date.now().toString()
  }
  mockCandidates.push(newCandidate)
  return newCandidate
}

export const updateCandidate = async (id: string, candidate: Partial<Candidate>): Promise<Candidate> => {
  await delay(400)
  const index = mockCandidates.findIndex(c => c.id === id)
  if (index === -1) throw new Error('Candidate not found')
  mockCandidates[index] = { ...mockCandidates[index], ...candidate }
  return mockCandidates[index]
}

export const deleteCandidate = async (id: string): Promise<void> => {
  await delay(300)
  const index = mockCandidates.findIndex(c => c.id === id)
  if (index === -1) throw new Error('Candidate not found')
  mockCandidates.splice(index, 1)
}
'@
Set-Content -Path "src/api/candidateAPI.ts" -Value $candidateApi
Write-Host "src/api/candidateAPI.ts criado" -ForegroundColor Green

# 24. Criar src/api/jobAPI.ts
$jobApi = @'
import { Job } from '../lib/types/job'
import { mockJobs } from './mockData'

// Simulate network delay
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms))

export const getJobs = async (): Promise<Job[]> => {
  await delay(500)
  return mockJobs
}

export const getJobById = async (id: string): Promise<Job> => {
  await delay(300)
  const job = mockJobs.find(j => j.id === id)
  if (!job) throw new Error('Job not found')
  return job
}

export const createJob = async (job: Omit<Job, 'id'>): Promise<Job> => {
  await delay(400)
  const newJob: Job = {
    ...job,
    id: Date.now().toString(),
    applications: 0,
    createdDate: new Date().toISOString().split('T')[0]
  }
  mockJobs.push(newJob)
  return newJob
}

export const updateJob = async (id: string, job: Partial<Job>): Promise<Job> => {
  await delay(400)
  const index = mockJobs.findIndex(j => j.id === id)
  if (index === -1) throw new Error('Job not found')
  mockJobs[index] = { ...mockJobs[index], ...job }
  return mockJobs[index]
}

export const deleteJob = async (id: string): Promise<void> => {
  await delay(300)
  const index = mockJobs.findIndex(j => j.id === id)
  if (index === -1) throw new Error('Job not found')
  mockJobs.splice(index, 1)
}
'@
Set-Content -Path "src/api/jobAPI.ts" -Value $jobApi
Write-Host "src/api/jobAPI.ts criado" -ForegroundColor Green

# 25. Criar src/components/ui/Button.tsx
$buttonComponent = @'
import { ButtonHTMLAttributes } from 'react'

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  isLoading?: boolean
  variant?: 'primary' | 'secondary' | 'outline' | 'danger'
}

const Button = ({ 
  children, 
  isLoading, 
  variant = 'primary', 
  className = '', 
  disabled,
  ...props 
}: ButtonProps) => {
  const baseClasses = 'font-medium py-2 px-4 rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed'
  
  const variants = {
    primary: 'bg-primary-600 hover:bg-primary-700 text-white focus:ring-primary-500',
    secondary: 'bg-gray-200 hover:bg-gray-300 text-gray-900 focus:ring-gray-500 dark:bg-gray-700 dark:hover:bg-gray-600 dark:text-white',
    outline: 'border border-primary-600 text-primary-600 hover:bg-primary-50 focus:ring-primary-500 dark:border-primary-500 dark:text-primary-500 dark:hover:bg-gray-800',
    danger: 'bg-red-600 hover:bg-red-700 text-white focus:ring-red-500'
  }

  return (
    <button
      className={`${baseClasses} ${variants[variant]} ${className}`}
      disabled={disabled || isLoading}
      {...props}
    >
      {isLoading ? (
        <div className="flex items-center justify-center">
          <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div>
          <span className="ml-2">Loading...</span>
        </div>
      ) : (
        children
      )}
    </button>
  )
}

export default Button
'@
Set-Content -Path "src/components/ui/Button.tsx" -Value $buttonComponent
Write-Host "src/components/ui/Button.tsx criado" -ForegroundColor Green

# 26. Criar src/components/ui/Card.tsx
$cardComponent = @'
import { ReactNode } from 'react'

interface CardProps {
  title?: string
  children: ReactNode
  className?: string
  value?: string | number
}

const Card = ({ title, children, className = '', value }: CardProps) => {
  if (value !== undefined) {
    return (
      <div className={`bg-white dark:bg-gray-800 rounded-lg shadow p-6 ${className}`}>
        <h3 className="text-lg font-medium text-gray-900 dark:text-white">{title}</h3>
        <p className="mt-2 text-3xl font-bold text-primary-600 dark:text-primary-400">{value}</p>
      </div>
    )
  }

  return (
    <div className={`bg-white dark:bg-gray-800 rounded-lg shadow ${className}`}>
      {title && (
        <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
          <h3 className="text-lg font-medium text-gray-900 dark:text-white">{title}</h3>
        </div>
      )}
      <div className="p-6">{children}</div>
    </div>
  )
}

export default Card
'@
Set-Content -Path "src/components/ui/Card.tsx" -Value $cardComponent
Write-Host "src/components/ui/Card.tsx criado" -ForegroundColor Green

# 27. Criar src/components/ui/Input.tsx
$inputComponent = @'
import { InputHTMLAttributes } from 'react'

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label: string
  error?: string
}

const Input = ({ label, error, className = '', ...props }: InputProps) => {
  return (
    <div className="w-full">
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
        {label}
      </label>
      <input
        className={`input-field ${error ? 'border-red-500 focus:ring-red-500 focus:border-red-500' : ''} ${className}`}
        {...props}
      />
      {error && <p className="mt-1 text-sm text-red-600 dark:text-red-400">{error}</p>}
    </div>
  )
}

export default Input
'@
Set-Content -Path "src/components/ui/Input.tsx" -Value $inputComponent
Write-Host "src/components/ui/Input.tsx criado" -ForegroundColor Green

# 28. Criar src/components/ui/Select.tsx
$selectComponent = @'
import { SelectHTMLAttributes } from 'react'

interface Option {
  value: string
  label: string
}

interface SelectProps extends SelectHTMLAttributes<HTMLSelectElement> {
  label: string
  options: Option[]
  error?: string
}

const Select = ({ label, options, error, className = '', ...props }: SelectProps) => {
  return (
    <div className="w-full">
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
        {label}
      </label>
      <select
        className={`input-field ${error ? 'border-red-500 focus:ring-red-500 focus:border-red-500' : ''} ${className}`}
        {...props}
      >
        {options.map(option => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
      {error && <p className="mt-1 text-sm text-red-600 dark:text-red-400">{error}</p>}
    </div>
  )
}

export default Select
'@
Set-Content -Path "src/components/ui/Select.tsx" -Value $selectComponent
Write-Host "src/components/ui/Select.tsx criado" -ForegroundColor Green

# 29. Criar src/components/ui/Table.tsx
$tableComponent = @'
import { ReactNode } from 'react'

interface Column {
  key: string
  header: string
  render?: (value: any, row: any) => ReactNode
}

interface TableProps {
  columns: Column[]
  data: any[]
  onRowClick?: (row: any) => void
  className?: string
}

const Table = ({ columns, data, onRowClick, className = '' }: TableProps) => {
  return (
    <div className={`overflow-x-auto rounded-lg shadow ${className}`}>
      <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
        <thead className="bg-gray-50 dark:bg-gray-800">
          <tr>
            {columns.map(column => (
              <th
                key={column.key}
                className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider"
              >
                {column.header}
              </th>
            ))}
          </tr>
        </thead>
        <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
          {data.map((row, index) => (
            <tr
              key={index}
              onClick={() => onRowClick?.(row)}
              className={onRowClick ? 'cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700' : ''}
            >
              {columns.map(column => (
                <td key={column.key} className="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-100">
                  {column.render ? column.render(row[column.key], row) : row[column.key]}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

export default Table
'@
Set-Content -Path "src/components/ui/Table.tsx" -Value $tableComponent
Write-Host "src/components/ui/Table.tsx criado" -ForegroundColor Green

# 30. Criar src/components/ui/index.ts
$uiIndex = @'
export { default as Button } from './Button'
export { default as Card } from './Card'
export { default as Input } from './Input'
export { default as Select } from './Select'
export { default as Table } from './Table'
'@
Set-Content -Path "src/components/ui/index.ts" -Value $uiIndex
Write-Host "src/components/ui/index.ts criado" -ForegroundColor Green

# 31. Criar src/components/candidates/CandidateCard.tsx
$candidateCard = @'
import { Candidate } from '../../lib/types/candidate'
import { getDaysAgo } from '../../lib/helpers/dateUtils'
import Card from '../ui/Card'

interface CandidateCardProps {
  candidate: Candidate
  onClick?: () => void
}

const CandidateCard = ({ candidate, onClick }: CandidateCardProps) => {
  const statusColors = {
    Applied: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200',
    Interview: 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
    Offer: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
    Hired: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
    Rejected: 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200',
  }

  return (
    <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={onClick}>
      <div className="flex items-start justify-between">
        <div>
          <h3 className="text-lg font-medium text-gray-900 dark:text-white">{candidate.name}</h3>
          <p className="text-sm text-gray-600 dark:text-gray-400">{candidate.email}</p>
          <p className="text-sm text-gray-600 dark:text-gray-400">{candidate.phone}</p>
        </div>
        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${statusColors[candidate.status]}`}>
          {candidate.status}
        </span>
      </div>
      
      <div className="mt-4">
        <div className="flex flex-wrap gap-1">
          {candidate.skills.slice(0, 4).map(skill => (
            <span key={skill} className="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200">
              {skill}
            </span>
          ))}
          {candidate.skills.length > 4 && (
            <span className="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200">
              +{candidate.skills.length - 4} more
            </span>
          )}
        </div>
      </div>
      
      <div className="mt-4 flex items-center justify-between">
        <span className="text-sm text-gray-500 dark:text-gray-400">
          Applied {getDaysAgo(candidate.appliedDate)}
        </span>
        {candidate.interviewDate && (
          <span className="text-sm text-gray-500 dark:text-gray-400">
            Interview: {getDaysAgo(candidate.interviewDate)}
          </span>
        )}
      </div>
    </Card>
  )
}

export default CandidateCard
'@
Set-Content -Path "src/components/candidates/CandidateCard.tsx" -Value $candidateCard
Write-Host "src/components/candidates/CandidateCard.tsx criado" -ForegroundColor Green

# 32. Criar src/components/candidates/CandidateForm.tsx
$candidateForm = @'
import { useState } from 'react'
import { Candidate } from '../../lib/types/candidate'
import Button from '../ui/Button'
import Input from '../ui/Input'
import Select from '../ui/Select'

interface CandidateFormProps {
  initialData?: Candidate
  onSubmit: (candidate: Candidate) => void
  isLoading?: boolean
  onCancel?: () => void
}

const CandidateForm = ({ initialData, onSubmit, isLoading, onCancel }: CandidateFormProps) => {
  const [formData, setFormData] = useState<Candidate>(
    initialData || {
      id: '',
      name: '',
      email: '',
      phone: '',
      skills: [],
      experience: '',
      education: '',
      status: 'Applied',
      appliedDate: new Date().toISOString().split('T')[0],
      notes: ''
    }
  )

  const [skillsInput, setSkillsInput] = useState(initialData?.skills.join(', ') || '')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    const skillsArray = skillsInput.split(',').map(skill => skill.trim()).filter(Boolean)
    onSubmit({ ...formData, skills: skillsArray })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <Input
        label="Full Name"
        value={formData.name}
        onChange={(e) => setFormData({ ...formData, name: e.target.value })}
        required
      />
      
      <Input
        label="Email"
        type="email"
        value={formData.email}
        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
        required
      />
      
      <Input
        label="Phone"
        value={formData.phone}
        onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
      />
      
      <Input
        label="Skills (comma-separated)"
        value={skillsInput}
        onChange={(e) => setSkillsInput(e.target.value)}
        placeholder="React, TypeScript, Node.js"
      />
      
      <Input
        label="Experience"
        value={formData.experience}
        onChange={(e) => setFormData({ ...formData, experience: e.target.value })}
        placeholder="5 years"
      />
      
      <Input
        label="Education"
        value={formData.education}
        onChange={(e) => setFormData({ ...formData, education: e.target.value })}
        placeholder="BS in Computer Science"
      />
      
      <Select
        label="Status"
        value={formData.status}
        onChange={(e) => setFormData({ ...formData, status: e.target.value as any })}
        options={[
          { value: 'Applied', label: 'Applied' },
          { value: 'Interview', label: 'Interview' },
          { value: 'Offer', label: 'Offer' },
          { value: 'Hired', label: 'Hired' },
          { value: 'Rejected', label: 'Rejected' },
        ]}
      />
      
      <Input
        label="Applied Date"
        type="date"
        value={formData.appliedDate}
        onChange={(e) => setFormData({ ...formData, appliedDate: e.target.value })}
      />
      
      {formData.status === 'Interview' && (
        <Input
          label="Interview Date"
          type="date"
          value={formData.interviewDate || ''}
          onChange={(e) => setFormData({ ...formData, interviewDate: e.target.value })}
        />
      )}
      
      <div className="flex space-x-3">
        <Button type="submit" isLoading={isLoading}>
          {initialData ? 'Update Candidate' : 'Add Candidate'}
        </Button>
        {onCancel && (
          <Button type="button" variant="outline" onClick={onCancel}>
            Cancel
          </Button>
        )}
      </div>
    </form>
  )
}

export default CandidateForm
'@
Set-Content -Path "src/components/candidates/CandidateForm.tsx" -Value $candidateForm
Write-Host "src/components/candidates/CandidateForm.tsx criado" -ForegroundColor Green

# 33. Criar src/components/candidates/CandidateList.tsx
$candidateList = @'
import { useState } from 'react'
import { Candidate } from '../../lib/types/candidate'
import CandidateCard from './CandidateCard'
import Table from '../ui/Table'
import { formatDate } from '../../lib/helpers/dateUtils'

interface CandidateListProps {
  candidates: Candidate[]
  onCandidateClick: (candidate: Candidate) => void
  viewMode?: 'grid' | 'table'
}

const CandidateList = ({ candidates, onCandidateClick, viewMode = 'grid' }: CandidateListProps) => {
  const [statusFilter, setStatusFilter] = useState<string>('all')

  const filteredCandidates = statusFilter === 'all' 
    ? candidates 
    : candidates.filter(c => c.status === statusFilter)

  const tableColumns = [
    { key: 'name', header: 'Name' },
    { key: 'email', header: 'Email' },
    { key: 'phone', header: 'Phone' },
    { 
      key: 'skills', 
      header: 'Skills',
      render: (skills: string[]) => skills.slice(0, 3).join(', ')
    },
    { key: 'status', header: 'Status' },
    { 
      key: 'appliedDate', 
      header: 'Applied Date',
      render: (date: string) => formatDate(date)
    },
  ]

  if (viewMode === 'table') {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Candidates</h2>
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="input-field w-auto"
          >
            <option value="all">All Statuses</option>
            <option value="Applied">Applied</option>
            <option value="Interview">Interview</option>
            <option value="Offer">Offer</option>
            <option value="Hired">Hired</option>
            <option value="Rejected">Rejected</option>
          </select>
        </div>
        
        <Table 
          columns={tableColumns} 
          data={filteredCandidates} 
          onRowClick={onCandidateClick}
        />
      </div>
    )
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Candidates</h2>
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value)}
          className="input-field w-auto"
        >
          <option value="all">All Statuses</option>
          <option value="Applied">Applied</option>
          <option value="Interview">Interview</option>
          <option value="Offer">Offer</option>
          <option value="Hired">Hired</option>
          <option value="Rejected">Rejected</option>
        </select>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredCandidates.map(candidate => (
          <CandidateCard
            key={candidate.id}
            candidate={candidate}
            onClick={() => onCandidateClick(candidate)}
          />
        ))}
      </div>
      
      {filteredCandidates.length === 0 && (
        <div className="text-center py-12">
          <p className="text-gray-500 dark:text-gray-400">No candidates found</p>
        </div>
      )}
    </div>
  )
}

export default CandidateList
'@
Set-Content -Path "src/components/candidates/CandidateList.tsx" -Value $candidateList
Write-Host "src/components/candidates/CandidateList.tsx criado" -ForegroundColor Green

# 34. Criar src/components/candidates/CandidateSkills.tsx
$candidateSkills = @'
import { Candidate } from '../../lib/types/candidate'

interface CandidateSkillsProps {
  candidate: Candidate
}

const CandidateSkills = ({ candidate }: CandidateSkillsProps) => {
  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
      <h3 className="text-lg font-medium text-gray-900 dark:text-white mb-4">Skills & Qualifications</h3>
      
      <div className="space-y-4">
        <div>
          <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Skills</h4>
          <div className="flex flex-wrap gap-2">
            {candidate.skills.map(skill => (
              <span
                key={skill}
                className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-200"
              >
                {skill}
              </span>
            ))}
          </div>
        </div>
        
        <div>
          <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Experience</h4>
          <p className="text-gray-600 dark:text-gray-400">{candidate.experience}</p>
        </div>
        
        <div>
          <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Education</h4>
          <p className="text-gray-600 dark:text-gray-400">{candidate.education}</p>
        </div>
        
        {candidate.notes && (
          <div>
            <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Notes</h4>
            <p className="text-gray-600 dark:text-gray-400">{candidate.notes}</p>
          </div>
        )}
      </div>
    </div>
  )
}

export default CandidateSkills
'@
Set-Content -Path "src/components/candidates/CandidateSkills.tsx" -Value $candidateSkills
Write-Host "src/components/candidates/CandidateSkills.tsx criado" -ForegroundColor Green

# 35. Criar src/components/candidates/index.ts
$candidatesIndex = @'
export { default as CandidateCard } from './CandidateCard'
export { default as CandidateForm } from './CandidateForm'
export { default as CandidateList } from './CandidateList'
export { default as CandidateSkills } from './CandidateSkills'
'@
Set-Content -Path "src/components/candidates/index.ts" -Value $candidatesIndex
Write-Host "src/components/candidates/index.ts criado" -ForegroundColor Green

# 36. Criar src/components/jobs/JobCard.tsx
$jobCard = @'
import { Job } from '../../lib/types/job'
import { formatCurrency } from '../../lib/helpers/stringUtils'
import { getDaysAgo } from '../../lib/helpers/dateUtils'
import Card from '../ui/Card'

interface JobCardProps {
  job: Job
  onClick?: () => void
}

const JobCard = ({ job, onClick }: JobCardProps) => {
  const statusColors = {
    Open: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
    Closed: 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200',
    'On-hold': 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
  }

  const levelColors = {
    Intern: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200',
    Junior: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
    Mid: 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
    Senior: 'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-200',
    Lead: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
  }

  return (
    <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={onClick}>
      <div className="flex items-start justify-between">
        <div>
          <h3 className="text-lg font-medium text-gray-900 dark:text-white">{job.title}</h3>
          <p className="text-sm text-gray-600 dark:text-gray-400">{job.department} • {job.location}</p>
        </div>
        <div className="flex flex-col items-end space-y-2">
          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${statusColors[job.status]}`}>
            {job.status}
          </span>
          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${levelColors[job.level]}`}>
            {job.level}
          </span>
        </div>
      </div>
      
      <div className="mt-4">
        <p className="text-sm text-gray-600 dark:text-gray-400 line-clamp-2">{job.description}</p>
      </div>
      
      <div className="mt-4">
        <div className="flex flex-wrap gap-1">
          {job.requirements.slice(0, 3).map((req, index) => (
            <span key={index} className="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200">
              {req}
            </span>
          ))}
          {job.requirements.length > 3 && (
            <span className="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200">
              +{job.requirements.length - 3} more
            </span>
          )}
        </div>
      </div>
      
      <div className="mt-4 flex items-center justify-between">
        <span className="text-sm font-medium text-gray-900 dark:text-white">
          {formatCurrency(job.salaryRange.min)} - {formatCurrency(job.salaryRange.max)}
        </span>
        <div className="text-right">
          <span className="text-sm font-medium text-gray-900 dark:text-white">{job.applications} applications</span>
          <p className="text-sm text-gray-500 dark:text-gray-400">Posted {getDaysAgo(job.createdDate)}</p>
        </div>
      </div>
    </Card>
  )
}

export default JobCard
'@
Set-Content -Path "src/components/jobs/JobCard.tsx" -Value $jobCard
Write-Host "src/components/jobs/JobCard.tsx criado" -ForegroundColor Green

# 37. Criar src/components/jobs/JobForm.tsx
$jobForm = @'
import { useState } from 'react'
import { Job } from '../../lib/types/job'
import Button from '../ui/Button'
import Input from '../ui/Input'
import Select from '../ui/Select'

interface JobFormProps {
  initialData?: Job
  onSubmit: (job: Job) => void
  isLoading?: boolean
  onCancel?: () => void
}

const JobForm = ({ initialData, onSubmit, isLoading, onCancel }: JobFormProps) => {
  const [formData, setFormData] = useState<Job>(
    initialData || {
      id: '',
      title: '',
      department: '',
      level: 'Mid',
      description: '',
      requirements: [],
      location: '',
      type: 'Full-time',
      status: 'Open',
      salaryRange: {
        min: 0,
        max: 0,
        currency: 'USD'
      },
      applications: 0,
      createdDate: new Date().toISOString().split('T')[0],
    }
  )

  const [requirementsInput, setRequirementsInput] = useState(initialData?.requirements.join(', ') || '')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    const requirementsArray = requirementsInput.split(',').map(req => req.trim()).filter(Boolean)
    onSubmit({ ...formData, requirements: requirementsArray })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <Input
        label="Job Title"
        value={formData.title}
        onChange={(e) => setFormData({ ...formData, title: e.target.value })}
        required
      />
      
      <Input
        label="Department"
        value={formData.department}
        onChange={(e) => setFormData({ ...formData, department: e.target.value })}
        required
      />
      
      <Select
        label="Level"
        value={formData.level}
        onChange={(e) => setFormData({ ...formData, level: e.target.value as any })}
        options={[
          { value: 'Intern', label: 'Intern' },
          { value: 'Junior', label: 'Junior' },
          { value: 'Mid', label: 'Mid' },
          { value: 'Senior', label: 'Senior' },
          { value: 'Lead', label: 'Lead' },
        ]}
      />
      
      <div>
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
          Description
        </label>
        <textarea
          value={formData.description}
          onChange={(e) => setFormData({ ...formData, description: e.target.value })}
          className="input-field h-32"
          required
        />
      </div>
      
      <Input
        label="Requirements (comma-separated)"
        value={requirementsInput}
        onChange={(e) => setRequirementsInput(e.target.value)}
        placeholder="React, TypeScript, 5+ years experience"
      />
      
      <Input
        label="Location"
        value={formData.location}
        onChange={(e) => setFormData({ ...formData, location: e.target.value })}
        required
      />
      
      <Select
        label="Employment Type"
        value={formData.type}
        onChange={(e) => setFormData({ ...formData, type: e.target.value as any })}
        options={[
          { value: 'Full-time', label: 'Full-time' },
          { value: 'Part-time', label: 'Part-time' },
          { value: 'Contract', label: 'Contract' },
          { value: 'Remote', label: 'Remote' },
        ]}
      />
      
      <Select
        label="Status"
        value={formData.status}
        onChange={(e) => setFormData({ ...formData, status: e.target.value as any })}
        options={[
          { value: 'Open', label: 'Open' },
          { value: 'Closed', label: 'Closed' },
          { value: 'On-hold', label: 'On-hold' },
        ]}
      />
      
      <div className="grid grid-cols-2 gap-4">
        <Input
          label="Minimum Salary"
          type="number"
          value={formData.salaryRange.min}
          onChange={(e) => setFormData({ 
            ...formData, 
            salaryRange: { ...formData.salaryRange, min: parseInt(e.target.value) }
          })}
          required
        />
        
        <Input
          label="Maximum Salary"
          type="number"
          value={formData.salaryRange.max}
          onChange={(e) => setFormData({ 
            ...formData, 
            salaryRange: { ...formData.salaryRange, max: parseInt(e.target.value) }
          })}
          required
        />
      </div>
      
      <Input
        label="Currency"
        value={formData.salaryRange.currency}
        onChange={(e) => setFormData({ 
          ...formData, 
          salaryRange: { ...formData.salaryRange, currency: e.target.value }
        })}
        required
      />
      
      <div className="flex space-x-3">
        <Button type="submit" isLoading={isLoading}>
          {initialData ? 'Update Job' : 'Create Job'}
        </Button>
        {onCancel && (
          <Button type="button" variant="outline" onClick={onCancel}>
            Cancel
          </Button>
        )}
      </div>
    </form>
  )
}

export default JobForm
'@
Set-Content -Path "src/components/jobs/JobForm.tsx" -Value $jobForm
Write-Host "src/components/jobs/JobForm.tsx criado" -ForegroundColor Green

# 38. Criar src/components/jobs/JobList.tsx
$jobList = @'
import { useState } from 'react'
import { Job } from '../../lib/types/job'
import JobCard from './JobCard'
import Table from '../ui/Table'
import { formatCurrency } from '../../lib/helpers/stringUtils'
import { formatDate } from '../../lib/helpers/dateUtils'

interface JobListProps {
  jobs: Job[]
  onJobClick: (job: Job) => void
  viewMode?: 'grid' | 'table'
}

const JobList = ({ jobs, onJobClick, viewMode = 'grid' }: JobListProps) => {
  const [statusFilter, setStatusFilter] = useState<string>('all')
  const [departmentFilter, setDepartmentFilter] = useState<string>('all')

  const departments = Array.from(new Set(jobs.map(job => job.department)))

  const filteredJobs = jobs.filter(job => {
    const statusMatch = statusFilter === 'all' || job.status === statusFilter
    const departmentMatch = departmentFilter === 'all' || job.department === departmentFilter
    return statusMatch && departmentMatch
  })

  const tableColumns = [
    { key: 'title', header: 'Title' },
    { key: 'department', header: 'Department' },
    { key: 'level', header: 'Level' },
    { key: 'location', header: 'Location' },
    { 
      key: 'salaryRange', 
      header: 'Salary Range',
      render: (range: any) => `${formatCurrency(range.min)} - ${formatCurrency(range.max)}`
    },
    { key: 'applications', header: 'Applications' },
    { key: 'status', header: 'Status' },
    { 
      key: 'createdDate', 
      header: 'Posted Date',
      render: (date: string) => formatDate(date)
    },
  ]

  if (viewMode === 'table') {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Jobs</h2>
          <div className="flex space-x-2">
            <select
              value={departmentFilter}
              onChange={(e) => setDepartmentFilter(e.target.value)}
              className="input-field w-auto"
            >
              <option value="all">All Departments</option>
              {departments.map(dept => (
                <option key={dept} value={dept}>{dept}</option>
              ))}
            </select>
            <select
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
              className="input-field w-auto"
            >
              <option value="all">All Statuses</option>
              <option value="Open">Open</option>
              <option value="Closed">Closed</option>
              <option value="On-hold">On-hold</option>
            </select>
          </div>
        </div>
        
        <Table 
          columns={tableColumns} 
          data={filteredJobs} 
          onRowClick={onJobClick}
        />
      </div>
    )
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Jobs</h2>
        <div className="flex space-x-2">
          <select
            value={departmentFilter}
            onChange={(e) => setDepartmentFilter(e.target.value)}
            className="input-field w-auto"
          >
            <option value="all">All Departments</option>
            {departments.map(dept => (
              <option key={dept} value={dept}>{dept}</option>
            ))}
          </select>
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="input-field w-auto"
          >
            <option value="all">All Statuses</option>
            <option value="Open">Open</option>
            <option value="Closed">Closed</option>
            <option value="On-hold">On-hold</option>
          </select>
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredJobs.map(job => (
          <JobCard
            key={job.id}
            job={job}
            onClick={() => onJobClick(job)}
          />
        ))}
      </div>
      
      {filteredJobs.length === 0 && (
        <div className="text-center py-12">
          <p className="text-gray-500 dark:text-gray-400">No jobs found</p>
        </div>
      )}
    </div>
  )
}

export default JobList
'@
Set-Content -Path "src/components/jobs/JobList.tsx" -Value $jobList
Write-Host "src/components/jobs/JobList.tsx criado" -ForegroundColor Green

# 39. Criar src/components/jobs/index.ts
$jobsIndex = @'
export { default as JobCard } from './JobCard'
export { default as JobForm } from './JobForm'
export { default as JobList } from './JobList'
'@
Set-Content -Path "src/components/jobs/index.ts" -Value $jobsIndex
Write-Host "src/components/jobs/index.ts criado" -ForegroundColor Green

# 40. Criar src/components/charts/BarChart.tsx
$barChart = @'
import { BarChart as RechartsBarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import Card from '../ui/Card'

interface BarChartProps {
  data: any[]
  title: string
  dataKey: string
  valueKey: string
}

const BarChart = ({ 
  data, 
  title, 
  dataKey = 'name', 
  valueKey = 'value' 
}: BarChartProps) => {
  return (
    <Card title={title}>
      <div className="h-80">
        <ResponsiveContainer width="100%" height="100%">
          <RechartsBarChart data={data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey={dataKey} />
            <YAxis />
            <Tooltip />
            <Bar dataKey={valueKey} fill="#0ea5e9" />
          </RechartsBarChart>
        </ResponsiveContainer>
      </div>
    </Card>
  )
}

export default BarChart
'@
Set-Content -Path "src/components/charts/BarChart.tsx" -Value $barChart
Write-Host "src/components/charts/BarChart.tsx criado" -ForegroundColor Green

# 41. Criar src/components/charts/PieChart.tsx
$pieChart = @'
import { PieChart as RechartsPieChart, Pie, Cell, Tooltip, ResponsiveContainer, Legend } from 'recharts'
import Card from '../ui/Card'

interface PieChartProps {
  data: any[]
  title: string
  dataKey: string
  valueKey: string
}

const COLORS = ['#0ea5e9', '#8b5cf6', '#ec4899', '#f59e0b', '#10b981']

const PieChart = ({ 
  data, 
  title, 
  dataKey = 'name', 
  valueKey = 'value' 
}: PieChartProps) => {
  return (
    <Card title={title}>
      <div className="h-80">
        <ResponsiveContainer width="100%" height="100%">
          <RechartsPieChart>
            <Pie
              data={data}
              cx="50%"
              cy="50%"
              labelLine={false}
              label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
              outerRadius={80}
              fill="#8884d8"
              dataKey={valueKey}
            >
              {data.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
              ))}
            </Pie>
            <Tooltip />
            <Legend />
          </RechartsPieChart>
        </ResponsiveContainer>
      </div>
    </Card>
  )
}

export default PieChart
'@
Set-Content -Path "src/components/charts/PieChart.tsx" -Value $pieChart
Write-Host "src/components/charts/PieChart.tsx criado" -ForegroundColor Green

# 42. Criar src/components/charts/Sparkline.tsx
$sparkline = @'
import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts'

interface SparklineProps {
  data: any[]
  dataKey: string
  valueKey: string
  color?: string
  height?: number
}

const Sparkline = ({ 
  data, 
  dataKey, 
  valueKey, 
  color = '#0ea5e9',
  height = 40 
}: SparklineProps) => {
  return (
    <ResponsiveContainer width="100%" height={height}>
      <LineChart data={data}>
        <Line
          type="monotone"
          dataKey={valueKey}
          stroke={color}
          strokeWidth={2}
          dot={false}
        />
        <XAxis dataKey={dataKey} hide />
        <YAxis hide />
        <Tooltip />
      </LineChart>
    </ResponsiveContainer>
  )
}

export default Sparkline
'@
Set-Content -Path "src/components/charts/Sparkline.tsx" -Value $sparkline
Write-Host "src/components/charts/Sparkline.tsx criado" -ForegroundColor Green

# 43. Criar src/components/layout/Header.tsx
$headerComponent = @'
import { useAuth } from '../../context/AuthContext'
import { useTheme } from '../../context/ThemeContext'
import Button from '../ui/Button'

const Header = () => {
  const { user, logout } = useAuth()
  const { isDark, toggleTheme } = useTheme()

  return (
    <header className="bg-white dark:bg-gray-800 shadow-sm border-b border-gray-200 dark:border-gray-700">
      <div className="flex items-center justify-between px-6 py-4">
        <div className="flex items-center">
          <h1 className="text-xl font-semibold text-gray-900 dark:text-white">
            TalentFlow ATS
          </h1>
        </div>
        
        <div className="flex items-center space-x-4">
          <button
            onClick={toggleTheme}
            className="p-2 rounded-lg bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600"
          >
            {isDark ? '☀️' : '🌙'}
          </button>
          
          <div className="flex items-center space-x-3">
            <div className="text-right">
              <p className="text-sm font-medium text-gray-900 dark:text-white">{user?.name}</p>
              <p className="text-xs text-gray-600 dark:text-gray-400">{user?.email}</p>
            </div>
            <div className="w-10 h-10 bg-primary-600 rounded-full flex items-center justify-center text-white font-medium">
              {user?.name?.charAt(0).toUpperCase()}
            </div>
            <Button variant="outline" onClick={logout} className="text-sm">
              Logout
            </Button>
          </div>
        </div>
      </div>
    </header>
  )
}

export default Header
'@
Set-Content -Path "src/components/layout/Header.tsx" -Value $headerComponent
Write-Host "src/components/layout/Header.tsx criado" -ForegroundColor Green

# 44. Criar src/components/layout/Sidebar.tsx
$sidebarComponent = @'
import { NavLink } from 'react-router-dom'
import { ROUTES } from '../../lib/constants/routes'

const Sidebar = () => {
  const navigation = [
    { name: 'Dashboard', href: ROUTES.DASHBOARD, icon: '📊' },
    { name: 'Candidates', href: ROUTES.CANDIDATES, icon: '👥' },
    { name: 'Jobs', href: ROUTES.JOBS, icon: '💼' },
    { name: 'Settings', href: ROUTES.SETTINGS, icon: '⚙️' },
  ]

  return (
    <div className="w-64 bg-white dark:bg-gray-800 shadow-sm border-r border-gray-200 dark:border-gray-700">
      <nav className="mt-8">
        <div className="px-4 space-y-2">
          {navigation.map((item) => (
            <NavLink
              key={item.name}
              to={item.href}
              className={({ isActive }) =>
                `flex items-center px-4 py-3 text-gray-700 dark:text-gray-200 rounded-lg transition-colors ${
                  isActive
                    ? 'bg-primary-100 text-primary-700 dark:bg-primary-900 dark:text-primary-200'
                    : 'hover:bg-gray-100 dark:hover:bg-gray-700'
                }`
              }
            >
              <span className="mr-3 text-lg">{item.icon}</span>
              <span className="font-medium">{item.name}</span>
            </NavLink>
          ))}
        </div>
      </nav>
    </div>
  )
}

export default Sidebar
'@
Set-Content -Path "src/components/layout/Sidebar.tsx" -Value $sidebarComponent
Write-Host "src/components/layout/Sidebar.tsx criado" -ForegroundColor Green

# 45. Criar src/components/layout/ProtectedRoute.tsx
$protectedRoute = @'
import { Navigate, Outlet } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import { ROUTES } from '../../lib/constants/routes'

const ProtectedRoute = () => {
  const { isAuthenticated } = useAuth()

  return isAuthenticated ? <Outlet /> : <Navigate to={ROUTES.LOGIN} replace />
}

export default ProtectedRoute
'@
Set-Content -Path "src/components/layout/ProtectedRoute.tsx" -Value $protectedRoute
Write-Host "src/components/layout/ProtectedRoute.tsx criado" -ForegroundColor Green

# 46. Criar src/components/layout/ThemeToggle.tsx
$themeToggle = @'
import { useTheme } from '../../context/ThemeContext'

const ThemeToggle = () => {
  const { isDark, toggleTheme } = useTheme()

  return (
    <button
      onClick={toggleTheme}
      className="p-2 rounded-lg bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600 transition-colors"
      aria-label="Toggle theme"
    >
      {isDark ? '☀️' : '🌙'}
    </button>
  )
}

export default ThemeToggle
'@
Set-Content -Path "src/components/layout/ThemeToggle.tsx" -Value $themeToggle
Write-Host "src/components/layout/ThemeToggle.tsx criado" -ForegroundColor Green

# 47. Criar src/features/candidates/useCandidates.ts
$useCandidates = @'
import { useState, useEffect } from 'react'
import { getCandidates, createCandidate, updateCandidate, deleteCandidate } from '../../api/candidateAPI'
import { Candidate } from '../../lib/types/candidate'
import { useApp } from '../../context/AppContext'

export const useCandidates = () => {
  const { setLoading, showToast } = useApp()
  const [candidates, setCandidates] = useState<Candidate[]>([])
  const [selectedCandidate, setSelectedCandidate] = useState<Candidate | null>(null)

  const fetchCandidates = async () => {
    try {
      setLoading(true)
      const data = await getCandidates()
      setCandidates(data)
    } catch (error) {
      showToast({ message: 'Failed to fetch candidates', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleCreate = async (candidate: Omit<Candidate, 'id'>) => {
    try {
      setLoading(true)
      const newCandidate = await createCandidate(candidate)
      setCandidates([...candidates, newCandidate])
      showToast({ message: 'Candidate created successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to create candidate', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleUpdate = async (id: string, candidate: Partial<Candidate>) => {
    try {
      setLoading(true)
      const updatedCandidate = await updateCandidate(id, candidate)
      setCandidates(candidates.map(c => (c.id === id ? updatedCandidate : c)))
      showToast({ message: 'Candidate updated successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to update candidate', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (id: string) => {
    try {
      setLoading(true)
      await deleteCandidate(id)
      setCandidates(candidates.filter(c => c.id !== id))
      showToast({ message: 'Candidate deleted successfully', type: 'success' })
    } catch (error) {
      showToast({ message: 'Failed to delete candidate', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchCandidates()
  }, [])

  return {
    candidates,
    selectedCandidate,
    setSelectedCandidate,
    handleCreate,
    handleUpdate,
    handleDelete,
    fetchCandidates,
  }
}
'@
Set-Content -Path "src/features/candidates/useCandidates.ts" -Value $useCandidates
Write-Host "src/features/candidates/useCandidates.ts criado" -ForegroundColor Green

# 48. Criar src/features/candidates/candidateUtils.ts
$candidateUtils = @'
import { Candidate } from '../../lib/types/candidate'

export const filterCandidatesByStatus = (candidates: Candidate[], status: string): Candidate[] => {
  if (status === 'all') return candidates
  return candidates.filter(candidate => candidate.status === status)
}

export const searchCandidates = (candidates: Candidate[], query: string): Candidate[] => {
  if (!query) return candidates
  
  const lowerQuery = query.toLowerCase()
  return candidates.filter(candidate =>
    candidate.name.toLowerCase().includes(lowerQuery) ||
    candidate.email.toLowerCase().includes(lowerQuery) ||
    candidate.skills.some(skill => skill.toLowerCase().includes(lowerQuery))
  )
}

export const sortCandidates = (candidates: Candidate[], sortBy: string, order: 'asc' | 'desc' = 'asc'): Candidate[] => {
  return [...candidates].sort((a, b) => {
    let aValue: any = a[sortBy as keyof Candidate]
    let bValue: any = b[sortBy as keyof Candidate]
    
    if (sortBy === 'appliedDate' || sortBy === 'interviewDate') {
      aValue = new Date(aValue || 0).getTime()
      bValue = new Date(bValue || 0).getTime()
    }
    
    if (aValue < bValue) return order === 'asc' ? -1 : 1
    if (aValue > bValue) return order === 'asc' ? 1 : -1
    return 0
  })
}
'@
Set-Content -Path "src/features/candidates/candidateUtils.ts" -Value $candidateUtils
Write-Host "src/features/candidates/candidateUtils.ts criado" -ForegroundColor Green

# 49. Criar src/features/jobs/useJobs.ts
$useJobs = @'
import { useState, useEffect } from 'react'
import { getJobs, createJob, updateJob, deleteJob } from '../../api/jobAPI'
import { Job } from '../../lib/types/job'
import { useApp } from '../../context/AppContext'

export const useJobs = () => {
  const { setLoading, showToast } = useApp()
  const [jobs, setJobs] = useState<Job[]>([])
  const [selectedJob, setSelectedJob] = useState<Job | null>(null)

  const fetchJobs = async () => {
    try {
      setLoading(true)
      const data = await getJobs()
      setJobs(data)
    } catch (error) {
      showToast({ message: 'Failed to fetch jobs', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleCreate = async (job: Omit<Job, 'id'>) => {
    try {
      setLoading(true)
      const newJob = await createJob(job)
      setJobs([...jobs, newJob])
      showToast({ message: 'Job created successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to create job', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleUpdate = async (id: string, job: Partial<Job>) => {
    try {
      setLoading(true)
      const updatedJob = await updateJob(id, job)
      setJobs(jobs.map(j => (j.id === id ? updatedJob : j)))
      showToast({ message: 'Job updated successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to update job', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (id: string) => {
    try {
      setLoading(true)
      await deleteJob(id)
      setJobs(jobs.filter(j => j.id !== id))
      showToast({ message: 'Job deleted successfully', type: 'success' })
    } catch (error) {
      showToast({ message: 'Failed to delete job', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchJobs()
  }, [])

  return {
    jobs,
    selectedJob,
    setSelectedJob,
    handleCreate,
    handleUpdate,
    handleDelete,
    fetchJobs,
  }
}
'@
Set-Content -Path "src/features/jobs/useJobs.ts" -Value $useJobs
Write-Host "src/features/jobs/useJobs.ts criado" -ForegroundColor Green

# 50. Criar src/features/jobs/jobUtils.ts
$jobUtils = @'
import { Job } from '../../lib/types/job'

export const filterJobsByStatus = (jobs: Job[], status: string): Job[] => {
  if (status === 'all') return jobs
  return jobs.filter(job => job.status === status)
}

export const filterJobsByDepartment = (jobs: Job[], department: string): Job[] => {
  if (department === 'all') return jobs
  return jobs.filter(job => job.department === department)
}

export const searchJobs = (jobs: Job[], query: string): Job[] => {
  if (!query) return jobs
  
  const lowerQuery = query.toLowerCase()
  return jobs.filter(job =>
    job.title.toLowerCase().includes(lowerQuery) ||
    job.department.toLowerCase().includes(lowerQuery) ||
    job.requirements.some(req => req.toLowerCase().includes(lowerQuery))
  )
}

export const sortJobs = (jobs: Job[], sortBy: string, order: 'asc' | 'desc' = 'asc'): Job[] => {
  return [...jobs].sort((a, b) => {
    let aValue: any = a[sortBy as keyof Job]
    let bValue: any = b[sortBy as keyof Job]
    
    if (sortBy === 'createdDate' || sortBy === 'closedDate') {
      aValue = new Date(aValue || 0).getTime()
      bValue = new Date(bValue || 0).getTime()
    }
    
    if (sortBy === 'salaryRange') {
      aValue = a.salaryRange.min
      bValue = b.salaryRange.min
    }
    
    if (aValue < bValue) return order === 'asc' ? -1 : 1
    if (aValue > bValue) return order === 'asc' ? 1 : -1
    return 0
  })
}
'@
Set-Content -Path "src/features/jobs/jobUtils.ts" -Value $jobUtils
Write-Host "src/features/jobs/jobUtils.ts criado" -ForegroundColor Green

# 51. Criar src/features/dashboard/useDashboardStats.ts
$useDashboardStats = @'
import { useState, useCallback } from 'react'
import { getCandidates } from '../../api/candidateAPI'
import { getJobs } from '../../api/jobAPI'
import { useApp } from '../../context/AppContext'

interface DashboardStats {
  totalCandidates: number
  openJobs: number
  hiredThisMonth: number
  interviewScheduled: number
  applicationTrends: any[]
  statusDistribution: any[]
}

export const useDashboardStats = () => {
  const { setLoading, showToast } = useApp()
  const [stats, setStats] = useState<DashboardStats>({
    totalCandidates: 0,
    openJobs: 0,
    hiredThisMonth: 0,
    interviewScheduled: 0,
    applicationTrends: [],
    statusDistribution: []
  })

  const fetchStats = useCallback(async () => {
    try {
      setLoading(true)
      const [candidates, jobs] = await Promise.all([getCandidates(), getJobs()])
      
      // Calculate basic stats
      const totalCandidates = candidates.length
      const openJobs = jobs.filter(job => job.status === 'Open').length
      
      const thisMonth = new Date().getMonth()
      const hiredThisMonth = candidates.filter(candidate => 
        candidate.status === 'Hired' && 
        new Date(candidate.appliedDate).getMonth() === thisMonth
      ).length
      
      const interviewScheduled = candidates.filter(candidate => 
        candidate.status === 'Interview' && candidate.interviewDate
      ).length
      
      // Generate application trends (last 6 months)
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      const currentMonth = new Date().getMonth()
      const applicationTrends = Array.from({ length: 6 }, (_, i) => {
        const monthIndex = (currentMonth - 5 + i + 12) % 12
        const month = months[monthIndex]
        const count = candidates.filter(candidate => 
          new Date(candidate.appliedDate).getMonth() === monthIndex
        ).length
        return { name: month, value: count }
      })
      
      // Generate status distribution
      const statusDistribution = [
        { name: 'Applied', value: candidates.filter(c => c.status === 'Applied').length },
        { name: 'Interview', value: candidates.filter(c => c.status === 'Interview').length },
        { name: 'Offer', value: candidates.filter(c => c.status === 'Offer').length },
        { name: 'Hired', value: candidates.filter(c => c.status === 'Hired').length },
        { name: 'Rejected', value: candidates.filter(c => c.status === 'Rejected').length },
      ]
      
      setStats({
        totalCandidates,
        openJobs,
        hiredThisMonth,
        interviewScheduled,
        applicationTrends,
        statusDistribution
      })
    } catch (error) {
      showToast({ message: 'Failed to load dashboard stats', type: 'error' })
    } finally {
      setLoading(false)
    }
  }, [setLoading, showToast])

  return {
    stats,
    fetchStats
  }
}
'@
Set-Content -Path "src/features/dashboard/useDashboardStats.ts" -Value $useDashboardStats
Write-Host "src/features/dashboard/useDashboardStats.ts criado" -ForegroundColor Green

# 52. Criar src/hooks/useAuth.ts
$useAuth = @'
import { useAuth } from '../context/AuthContext'

export { useAuth }
'@
Set-Content -Path "src/hooks/useAuth.ts" -Value $useAuth
Write-Host "src/hooks/useAuth.ts criado" -ForegroundColor Green

# 53. Criar src/hooks/useForm.ts
$useForm = @'
import { useState } from 'react'

export const useForm = <T extends Record<string, any>>(initialValues: T) => {
  const [values, setValues] = useState<T>(initialValues)
  const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({})

  const handleChange = (field: keyof T, value: any) => {
    setValues(prev => ({ ...prev, [field]: value }))
    // Clear error when field changes
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: undefined }))
    }
  }

  const reset = () => {
    setValues(initialValues)
    setErrors({})
  }

  return {
    values,
    errors,
    setErrors,
    handleChange,
    reset,
    setValues
  }
}
'@
Set-Content -Path "src/hooks/useForm.ts" -Value $useForm
Write-Host "src/hooks/useForm.ts criado" -ForegroundColor Green

# 54. Criar src/hooks/useToast.ts
$useToast = @'
import { useApp } from '../context/AppContext'

export const useToast = () => {
  const { showToast } = useApp()
  
  return {
    success: (message: string, duration?: number) => 
      showToast({ message, type: 'success', duration }),
    error: (message: string, duration?: number) => 
      showToast({ message, type: 'error', duration }),
    warning: (message: string, duration?: number) => 
      showToast({ message, type: 'warning', duration }),
    info: (message: string, duration?: number) => 
      showToast({ message, type: 'info', duration })
  }
}
'@
Set-Content -Path "src/hooks/useToast.ts" -Value $useToast
Write-Host "src/hooks/useToast.ts criado" -ForegroundColor Green

# 55. Criar src/pages/Auth/Login.tsx
$loginPage = @'
import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import { useToast } from '../../hooks/useToast'
import Button from '../../components/ui/Button'
import Input from '../../components/ui/Input'
import { ROUTES } from '../../lib/constants/routes'

const Login = () => {
  const [email, setEmail] = useState('admin@example.com')
  const [password, setPassword] = useState('password')
  const [isLoading, setIsLoading] = useState(false)
  
  const { login } = useAuth()
  const toast = useToast()
  const navigate = useNavigate()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)
    
    try {
      const success = await login(email, password)
      if (success) {
        toast.success('Logged in successfully')
        navigate(ROUTES.DASHBOARD)
      } else {
        toast.error('Invalid email or password')
      }
    } catch (error) {
      toast.error('An error occurred during login')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 dark:bg-gray-900 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900 dark:text-white">
            Sign in to TalentFlow
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600 dark:text-gray-400">
            Or{' '}
            <Link
              to={ROUTES.REGISTER}
              className="font-medium text-primary-600 hover:text-primary-500 dark:text-primary-400"
            >
              create a new account
            </Link>
          </p>
        </div>
        
        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-4">
            <Input
              label="Email address"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
            
            <Input
              label="Password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          <div>
            <Button type="submit" isLoading={isLoading} className="w-full">
              Sign in
            </Button>
          </div>
          
          <div className="text-center">
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Demo credentials: admin@example.com / password
            </p>
          </div>
        </form>
      </div>
    </div>
  )
}

export default Login
'@
Set-Content -Path "src/pages/Auth/Login.tsx" -Value $loginPage
Write-Host "src/pages/Auth/Login.tsx criado" -ForegroundColor Green

# 56. Criar src/pages/Auth/Register.tsx
$registerPage = @'
import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import { useToast } from '../../hooks/useToast'
import Button from '../../components/ui/Button'
import Input from '../../components/ui/Input'
import { ROUTES } from '../../lib/constants/routes'

const Register = () => {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  
  const { register } = useAuth()
  const toast = useToast()
  const navigate = useNavigate()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    
    if (password !== confirmPassword) {
      toast.error('Passwords do not match')
      return
    }
    
    setIsLoading(true)
    
    try {
      const success = await register(name, email, password)
      if (success) {
        toast.success('Account created successfully')
        navigate(ROUTES.DASHBOARD)
      } else {
        toast.error('Failed to create account')
      }
    } catch (error) {
      toast.error('An error occurred during registration')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 dark:bg-gray-900 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900 dark:text-white">
            Create your account
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600 dark:text-gray-400">
            Or{' '}
            <Link
              to={ROUTES.LOGIN}
              className="font-medium text-primary-600 hover:text-primary-500 dark:text-primary-400"
            >
              sign in to your existing account
            </Link>
          </p>
        </div>
        
        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-4">
            <Input
              label="Full name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
            />
            
            <Input
              label="Email address"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
            
            <Input
              label="Password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
            
            <Input
              label="Confirm password"
              type="password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              required
            />
          </div>

          <div>
            <Button type="submit" isLoading={isLoading} className="w-full">
              Create account
            </Button>
          </div>
        </form>
      </div>
    </div>
  )
}

export default Register
'@
Set-Content -Path "src/pages/Auth/Register.tsx" -Value $registerPage
Write-Host "src/pages/Auth/Register.tsx criado" -ForegroundColor Green

# 57. Criar src/pages/Candidates/Candidates.tsx
$candidatesPage = @'
import { useState } from 'react'
import { useCandidates } from '../../features/candidates/useCandidates'
import { Candidate } from '../../lib/types/candidate'
import CandidateList from '../../components/candidates/CandidateList'
import CandidateForm from '../../components/candidates/CandidateForm'
import Button from '../../components/ui/Button'
import Card from '../../components/ui/Card'
import { useToast } from '../../hooks/useToast'

const Candidates = () => {
  const { candidates, handleCreate, handleUpdate, handleDelete } = useCandidates()
  const [isFormOpen, setIsFormOpen] = useState(false)
  const [editingCandidate, setEditingCandidate] = useState<Candidate | null>(null)
  const [viewMode, setViewMode] = useState<'grid' | 'table'>('grid')
  const toast = useToast()

  const handleCandidateClick = (candidate: Candidate) => {
    setEditingCandidate(candidate)
    setIsFormOpen(true)
  }

  const handleFormSubmit = async (candidateData: Candidate) => {
    const isEdit = !!editingCandidate
    const success = isEdit
      ? await handleUpdate(editingCandidate.id, candidateData)
      : await handleCreate(candidateData)
    
    if (success) {
      setIsFormOpen(false)
      setEditingCandidate(null)
      toast.success(`Candidate ${isEdit ? 'updated' : 'created'} successfully`)
    }
  }

  const handleDeleteCandidate = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this candidate?')) {
      await handleDelete(id)
    }
  }

  if (isFormOpen) {
    return (
      <div className="max-w-4xl mx-auto">
        <div className="flex items-center justify-between mb-6">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            {editingCandidate ? 'Edit Candidate' : 'Add New Candidate'}
          </h1>
          <Button variant="outline" onClick={() => {
            setIsFormOpen(false)
            setEditingCandidate(null)
          }}>
            Cancel
          </Button>
        </div>
        
        <Card>
          <CandidateForm
            initialData={editingCandidate || undefined}
            onSubmit={handleFormSubmit}
            onCancel={() => {
              setIsFormOpen(false)
              setEditingCandidate(null)
            }}
          />
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Candidates</h1>
        <div className="flex space-x-3">
          <select
            value={viewMode}
            onChange={(e) => setViewMode(e.target.value as 'grid' | 'table')}
            className="input-field w-auto"
          >
            <option value="grid">Grid View</option>
            <option value="table">Table View</option>
          </select>
          <Button onClick={() => setIsFormOpen(true)}>
            Add Candidate
          </Button>
        </div>
      </div>

      <CandidateList
        candidates={candidates}
        onCandidateClick={handleCandidateClick}
        viewMode={viewMode}
      />
    </div>
  )
}

export default Candidates
'@
Set-Content -Path "src/pages/Candidates/Candidates.tsx" -Value $candidatesPage
Write-Host "src/pages/Candidates/Candidates.tsx criado" -ForegroundColor Green

# 58. Criar src/pages/Candidates/CandidateDetail.tsx
$candidateDetail = @'
import { useParams, useNavigate } from 'react-router-dom'
import { useEffect, useState } from 'react'
import { getCandidateById } from '../../api/candidateAPI'
import { Candidate } from '../../lib/types/candidate'
import { useApp } from '../../context/AppContext'
import { useToast } from '../../hooks/useToast'
import CandidateSkills from '../../components/candidates/CandidateSkills'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import { formatDate } from '../../lib/helpers/dateUtils'

const CandidateDetail = () => {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { setLoading } = useApp()
  const toast = useToast()
  const [candidate, setCandidate] = useState<Candidate | null>(null)

  useEffect(() => {
    const loadCandidate = async () => {
      if (!id) return
      
      try {
        setLoading(true)
        const data = await getCandidateById(id)
        setCandidate(data)
      } catch (error) {
        toast.error('Failed to load candidate details')
        navigate('/candidates')
      } finally {
        setLoading(false)
      }
    }

    loadCandidate()
  }, [id, setLoading, toast, navigate])

  if (!candidate) {
    return <div>Loading...</div>
  }

  const statusColors = {
    Applied: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200',
    Interview: 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
    Offer: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
    Hired: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
    Rejected: 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200',
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <Button variant="outline" onClick={() => navigate('/candidates')}>
            ← Back to Candidates
          </Button>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white mt-4">
            {candidate.name}
          </h1>
        </div>
        <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${statusColors[candidate.status]}`}>
          {candidate.status}
        </span>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 space-y-6">
          <Card title="Contact Information">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Email</label>
                <p className="text-gray-900 dark:text-white">{candidate.email}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Phone</label>
                <p className="text-gray-900 dark:text-white">{candidate.phone}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Applied Date</label>
                <p className="text-gray-900 dark:text-white">{formatDate(candidate.appliedDate)}</p>
              </div>
              {candidate.interviewDate && (
                <div>
                  <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Interview Date</label>
                  <p className="text-gray-900 dark:text-white">{formatDate(candidate.interviewDate)}</p>
                </div>
              )}
            </div>
          </Card>

          <CandidateSkills candidate={candidate} />
        </div>

        <div className="space-y-6">
          <Card title="Timeline">
            <div className="space-y-4">
              <div className="flex items-start">
                <div className="flex-shrink-0">
                  <div className="w-3 h-3 bg-primary-600 rounded-full mt-1"></div>
                </div>
                <div className="ml-3">
                  <p className="text-sm font-medium text-gray-900 dark:text-white">Applied</p>
                  <p className="text-sm text-gray-500 dark:text-gray-400">{formatDate(candidate.appliedDate)}</p>
                </div>
              </div>
              
              {candidate.interviewDate && (
                <div className="flex items-start">
                  <div className="flex-shrink-0">
                    <div className="w-3 h-3 bg-yellow-600 rounded-full mt-1"></div>
                  </div>
                  <div className="ml-3">
                    <p className="text-sm font-medium text-gray-900 dark:text-white">Interview Scheduled</p>
                    <p className="text-sm text-gray-500 dark:text-gray-400">{formatDate(candidate.interviewDate)}</p>
                  </div>
                </div>
              )}
              
              <div className="flex items-start">
                <div className="flex-shrink-0">
                  <div className="w-3 h-3 bg-gray-400 rounded-full mt-1"></div>
                </div>
                <div className="ml-3">
                  <p className="text-sm font-medium text-gray-900 dark:text-white">Current Status</p>
                  <p className="text-sm text-gray-500 dark:text-gray-400">{candidate.status}</p>
                </div>
              </div>
            </div>
          </Card>

          <Card title="Actions">
            <div className="space-y-3">
              <Button className="w-full">Schedule Interview</Button>
              <Button variant="outline" className="w-full">Send Email</Button>
              <Button variant="danger" className="w-full">Reject Candidate</Button>
            </div>
          </Card>
        </div>
      </div>
    </div>
  )
}

export default CandidateDetail
'@
Set-Content -Path "src/pages/Candidates/CandidateDetail.tsx" -Value $candidateDetail
Write-Host "src/pages/Candidates/CandidateDetail.tsx criado" -ForegroundColor Green

# 59. Criar src/pages/Dashboard/Dashboard.tsx
$dashboardPage = @'
import { useEffect } from 'react'
import { useApp } from '../../context/AppContext'
import { useDashboardStats } from '../../features/dashboard/useDashboardStats'
import BarChart from '../../components/charts/BarChart'
import PieChart from '../../components/charts/PieChart'
import Card from '../../components/ui/Card'

const Dashboard = () => {
  const { loading, setLoading } = useApp()
  const { stats, fetchStats } = useDashboardStats()

  useEffect(() => {
    const loadData = async () => {
      setLoading(true)
      await fetchStats()
      setLoading(false)
    }
    loadData()
  }, [fetchStats, setLoading])

  if (loading) return <div>Loading dashboard...</div>

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Dashboard</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card title="Total Candidates" value={stats.totalCandidates.toString()} />
        <Card title="Open Jobs" value={stats.openJobs.toString()} />
        <Card title="Hired This Month" value={stats.hiredThisMonth.toString()} />
        <Card title="Interviews Scheduled" value={stats.interviewScheduled.toString()} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <BarChart 
          data={stats.applicationTrends} 
          title="Application Trends (Last 6 Months)"
          dataKey="name"
          valueKey="value"
        />
        <PieChart 
          data={stats.statusDistribution} 
          title="Candidate Status Distribution"
          dataKey="name"
          valueKey="value"
        />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card title="Recent Activity">
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">New application received</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">John Doe applied for Senior Frontend Developer</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">2h ago</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Interview scheduled</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Jane Smith interview with Tech Team</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">1d ago</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Offer sent</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Mike Johnson received offer for Backend Engineer</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">3d ago</span>
            </div>
          </div>
        </Card>

        <Card title="Upcoming Interviews">
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Sarah Wilson</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Senior Frontend Developer • 10:00 AM</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">Today</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">David Brown</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">UX Designer • 2:30 PM</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">Tomorrow</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Emily Chen</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Product Manager • 11:00 AM</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">Jun 12</span>
            </div>
          </div>
        </Card>
      </div>
    </div>
  )
}

export default Dashboard
'@
Set-Content -Path "src/pages/Dashboard/Dashboard.tsx" -Value $dashboardPage
Write-Host "src/pages/Dashboard/Dashboard.tsx criado" -ForegroundColor Green

# 60. Criar src/pages/Jobs/Jobs.tsx
$jobsPage = @'
import { useState } from 'react'
import { useJobs } from '../../features/jobs/useJobs'
import { Job } from '../../lib/types/job'
import JobList from '../../components/jobs/JobList'
import JobForm from '../../components/jobs/JobForm'
import Button from '../../components/ui/Button'
import Card from '../../components/ui/Card'
import { useToast } from '../../hooks/useToast'

const Jobs = () => {
  const { jobs, handleCreate, handleUpdate, handleDelete } = useJobs()
  const [isFormOpen, setIsFormOpen] = useState(false)
  const [editingJob, setEditingJob] = useState<Job | null>(null)
  const [viewMode, setViewMode] = useState<'grid' | 'table'>('grid')
  const toast = useToast()

  const handleJobClick = (job: Job) => {
    setEditingJob(job)
    setIsFormOpen(true)
  }

  const handleFormSubmit = async (jobData: Job) => {
    const isEdit = !!editingJob
    const success = isEdit
      ? await handleUpdate(editingJob.id, jobData)
      : await handleCreate(jobData)
    
    if (success) {
      setIsFormOpen(false)
      setEditingJob(null)
      toast.success(`Job ${isEdit ? 'updated' : 'created'} successfully`)
    }
  }

  const handleDeleteJob = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this job?')) {
      await handleDelete(id)
    }
  }

  if (isFormOpen) {
    return (
      <div className="max-w-4xl mx-auto">
        <div className="flex items-center justify-between mb-6">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            {editingJob ? 'Edit Job' : 'Create New Job'}
          </h1>
          <Button variant="outline" onClick={() => {
            setIsFormOpen(false)
            setEditingJob(null)
          }}>
            Cancel
          </Button>
        </div>
        
        <Card>
          <JobForm
            initialData={editingJob || undefined}
            onSubmit={handleFormSubmit}
            onCancel={() => {
              setIsFormOpen(false)
              setEditingJob(null)
            }}
          />
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Jobs</h1>
        <div className="flex space-x-3">
          <select
            value={viewMode}
            onChange={(e) => setViewMode(e.target.value as 'grid' | 'table')}
            className="input-field w-auto"
          >
            <option value="grid">Grid View</option>
            <option value="table">Table View</option>
          </select>
          <Button onClick={() => setIsFormOpen(true)}>
            Create Job
          </Button>
        </div>
      </div>

      <JobList
        jobs={jobs}
        onJobClick={handleJobClick}
        viewMode={viewMode}
      />
    </div>
  )
}

export default Jobs
'@
Set-Content -Path "src/pages/Jobs/Jobs.tsx" -Value $jobsPage
Write-Host "src/pages/Jobs/Jobs.tsx criado" -ForegroundColor Green

# 61. Criar src/pages/Jobs/JobDetail.tsx
$jobDetail = @'
import { useParams, useNavigate } from 'react-router-dom'
import { useEffect, useState } from 'react'
import { getJobById } from '../../api/jobAPI'
import { Job } from '../../lib/types/job'
import { useApp } from '../../context/AppContext'
import { useToast } from '../../hooks/useToast'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import { formatCurrency } from '../../lib/helpers/stringUtils'
import { formatDate } from '../../lib/helpers/dateUtils'

const JobDetail = () => {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { setLoading } = useApp()
  const toast = useToast()
  const [job, setJob] = useState<Job | null>(null)

  useEffect(() => {
    const loadJob = async () => {
      if (!id) return
      
      try {
        setLoading(true)
        const data = await getJobById(id)
        setJob(data)
      } catch (error) {
        toast.error('Failed to load job details')
        navigate('/jobs')
      } finally {
        setLoading(false)
      }
    }

    loadJob()
  }, [id, setLoading, toast, navigate])

  if (!job) {
    return <div>Loading...</div>
  }

  const statusColors = {
    Open: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
    Closed: 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200',
    'On-hold': 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
  }

  const levelColors = {
    Intern: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200',
    Junior: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
    Mid: 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
    Senior: 'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-200',
    Lead: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <Button variant="outline" onClick={() => navigate('/jobs')}>
            ← Back to Jobs
          </Button>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white mt-4">
            {job.title}
          </h1>
        </div>
        <div className="flex space-x-2">
          <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${statusColors[job.status]}`}>
            {job.status}
          </span>
          <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${levelColors[job.level]}`}>
            {job.level}
          </span>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 space-y-6">
          <Card title="Job Details">
            <div className="prose dark:prose-invert max-w-none">
              <p className="text-gray-600 dark:text-gray-400">{job.description}</p>
            </div>
          </Card>

          <Card title="Requirements">
            <ul className="space-y-2">
              {job.requirements.map((requirement, index) => (
                <li key={index} className="flex items-start">
                  <span className="text-primary-600 dark:text-primary-400 mr-2">•</span>
                  <span className="text-gray-600 dark:text-gray-400">{requirement}</span>
                </li>
              ))}
            </ul>
          </Card>
        </div>

        <div className="space-y-6">
          <Card title="Job Information">
            <div className="space-y-4">
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Department</label>
                <p className="text-gray-900 dark:text-white">{job.department}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Location</label>
                <p className="text-gray-900 dark:text-white">{job.location}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Employment Type</label>
                <p className="text-gray-900 dark:text-white">{job.type}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Salary Range</label>
                <p className="text-gray-900 dark:text-white">
                  {formatCurrency(job.salaryRange.min)} - {formatCurrency(job.salaryRange.max)}
                </p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Applications</label>
                <p className="text-gray-900 dark:text-white">{job.applications}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Posted Date</label>
                <p className="text-gray-900 dark:text-white">{formatDate(job.createdDate)}</p>
              </div>
              {job.closedDate && (
                <div>
                  <label className="text-sm font-medium text-gray-700 dark:text-gray-300">Closed Date</label>
                  <p className="text-gray-900 dark:text-white">{formatDate(job.closedDate)}</p>
                </div>
              )}
            </div>
          </Card>

          <Card title="Actions">
            <div className="space-y-3">
              <Button className="w-full">View Applications</Button>
              <Button variant="outline" className="w-full">Edit Job</Button>
              <Button variant="danger" className="w-full">Close Job</Button>
            </div>
          </Card>
        </div>
      </div>
    </div>
  )
}

export default JobDetail
'@
Set-Content -Path "src/pages/Jobs/JobDetail.tsx" -Value $jobDetail
Write-Host "src/pages/Jobs/JobDetail.tsx criado" -ForegroundColor Green

# 62. Criar src/pages/Settings/Settings.tsx
$settingsPage = @'
import { useState } from 'react'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import Input from '../../components/ui/Input'
import Select from '../../components/ui/Select'
import { useTheme } from '../../context/ThemeContext'
import { useToast } from '../../hooks/useToast'

const Settings = () => {
  const { isDark, toggleTheme } = useTheme()
  const toast = useToast()
  const [settings, setSettings] = useState({
    notifications: true,
    emailUpdates: false,
    autoSave: true,
    language: 'en',
    timezone: 'UTC-5',
  })

  const handleSave = () => {
    toast.success('Settings saved successfully')
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Settings</h1>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 space-y-6">
          <Card title="Profile Settings">
            <div className="space-y-4">
              <Input
                label="Full Name"
                value="Admin User"
                onChange={() => {}}
              />
              <Input
                label="Email"
                type="email"
                value="admin@example.com"
                onChange={() => {}}
              />
              <Input
                label="Password"
                type="password"
                value="password"
                onChange={() => {}}
                placeholder="Enter new password"
              />
            </div>
          </Card>

          <Card title="Notification Preferences">
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-medium text-gray-900 dark:text-white">Email Notifications</p>
                  <p className="text-sm text-gray-600 dark:text-gray-400">Receive email updates for important activities</p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={settings.notifications}
                    onChange={(e) => setSettings({ ...settings, notifications: e.target.checked })}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-primary-600"></div>
                </label>
              </div>

              <div className="flex items-center justify-between">
                <div>
                  <p className="font-medium text-gray-900 dark:text-white">Weekly Reports</p>
                  <p className="text-sm text-gray-600 dark:text-gray-400">Get weekly recruitment reports</p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={settings.emailUpdates}
                    onChange={(e) => setSettings({ ...settings, emailUpdates: e.target.checked })}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-primary-600"></div>
                </label>
              </div>

              <div className="flex items-center justify-between">
                <div>
                  <p className="font-medium text-gray-900 dark:text-white">Auto-save Changes</p>
                  <p className="text-sm text-gray-600 dark:text-gray-400">Automatically save form changes</p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={settings.autoSave}
                    onChange={(e) => setSettings({ ...settings, autoSave: e.target.checked })}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-primary-600"></div>
                </label>
              </div>
            </div>
          </Card>
        </div>

        <div className="space-y-6">
          <Card title="Appearance">
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <p className="font-medium text-gray-900 dark:text-white">Dark Mode</p>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    checked={isDark}
                    onChange={toggleTheme}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-primary-600"></div>
                </label>
              </div>

              <Select
                label="Language"
                value={settings.language}
                onChange={(e) => setSettings({ ...settings, language: e.target.value })}
                options={[
                  { value: 'en', label: 'English' },
                  { value: 'es', label: 'Spanish' },
                  { value: 'fr', label: 'French' },
                  { value: 'de', label: 'German' },
                ]}
              />

              <Select
                label="Timezone"
                value={settings.timezone}
                onChange={(e) => setSettings({ ...settings, timezone: e.target.value })}
                options={[
                  { value: 'UTC-5', label: 'EST (UTC-5)' },
                  { value: 'UTC-8', label: 'PST (UTC-8)' },
                  { value: 'UTC+0', label: 'GMT (UTC+0)' },
                  { value: 'UTC+1', label: 'CET (UTC+1)' },
                ]}
              />
            </div>
          </Card>

          <Card title="Danger Zone">
            <div className="space-y-4">
              <Button variant="outline" className="w-full">
                Export Data
              </Button>
              <Button variant="danger" className="w-full">
                Delete Account
              </Button>
            </div>
          </Card>

          <Button onClick={handleSave} className="w-full">
            Save Settings
          </Button>
        </div>
      </div>
    </div>
  )
}

export default Settings
'@
Set-Content -Path "src/pages/Settings/Settings.tsx" -Value $settingsPage
Write-Host "src/pages/Settings/Settings.tsx criado" -ForegroundColor Green

# 63. Criar src/vite-env.d.ts
$viteEnv = @'
/// <reference types="vite/client" />
'@
Set-Content -Path "src/vite-env.d.ts" -Value $viteEnv
Write-Host "src/vite-env.d.ts criado" -ForegroundColor Green

# 64. Criar .gitignore
$gitignore = @'
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
'@
Set-Content -Path ".gitignore" -Value $gitignore
Write-Host ".gitignore criado" -ForegroundColor Green

# 65. Criar README.md
$readme = @'
# TalentFlow ATS

A modern Applicant Tracking System built with React, TypeScript, and Tailwind CSS.

## Features

- 📊 Dashboard with recruitment analytics
- 👥 Candidate management
- 💼 Job posting and management
- 🎨 Dark/Light theme support
- 📱 Responsive design
- 🔍 Advanced filtering and search
- 📈 Data visualization with charts

## Getting Started

### Prerequisites

- Node.js 16+ 
- npm or yarn

### Installation

1. Install dependencies:
\`\`\`bash
npm install
\`\`\`

2. Start the development server:
\`\`\`bash
npm run dev
\`\`\`

3. Open [http://localhost:3000](http://localhost:3000) in your browser.

### Build for Production

\`\`\`bash
npm run build
\`\`\`

### Preview Production Build

\`\`\`bash
npm run preview
\`\`\`

## Demo Credentials

- Email: admin@example.com
- Password: password

## Tech Stack

- **Frontend**: React 18, TypeScript
- **Styling**: Tailwind CSS
- **Charts**: Recharts
- **Routing**: React Router
- **Build Tool**: Vite

## Project Structure

\`\`\`
src/
├── api/           # API functions and mock data
├── assets/        # Static assets
├── components/    # Reusable UI components
├── context/       # React context providers
├── features/      # Feature-specific hooks and utilities
├── hooks/         # Custom React hooks
├── lib/           # Utilities, constants, and types
├── pages/         # Page components
└── main.tsx       # Application entry point
\`\`\`

## License

This project is licensed under the MIT License.
'@
Set-Content -Path "README.md" -Value $readme
Write-Host "README.md criado" -ForegroundColor Green

# 66. Criar .eslintrc.cjs
$eslintrc = @'
module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    'eslint:recommended',
    '@typescript-eslint/eslint-recommended',
    '@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
  ],
  ignorePatterns: ['dist', '.eslintrc.cjs'],
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh'],
  rules: {
    'react-refresh/only-export-components': [
      'warn',
      { allowConstantExport: true },
    ],
  },
}
'@
Set-Content -Path ".eslintrc.cjs" -Value $eslintrc

Write-Host ".eslintrc.cjs criado" -ForegroundColor Green

# Instalar dependências
Write-Host "Instalando dependências..." -ForegroundColor Green
npm install

Write-Host "✅ Projeto TalentFlow ATS criado com sucesso!" -ForegroundColor Green
Write-Host "Para iniciar o projeto, execute: npm run dev" -ForegroundColor Yellow