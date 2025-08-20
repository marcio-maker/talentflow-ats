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
