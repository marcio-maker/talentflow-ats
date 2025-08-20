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
