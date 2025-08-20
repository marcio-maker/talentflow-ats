import { ReactNode } from 'react'

interface CardProps {
  title?: string
  children: ReactNode
  className?: string
  value?: string | number
  onClick?: () => void        // <- ADICIONADO
}

const Card = ({ title, children, className = '', value, onClick }: CardProps) => {
  if (value !== undefined) {
    return (
      <div
        className={`bg-white dark:bg-gray-800 rounded-lg shadow p-6 ${className}`}
        onClick={onClick}    // <- ADICIONADO
      >
        <h3 className="text-lg font-medium text-gray-900 dark:text-white">{title}</h3>
        <p className="mt-2 text-3xl font-bold text-primary-600 dark:text-primary-400">{value}</p>
      </div>
    )
  }

  return (
    <div
      className={`bg-white dark:bg-gray-800 rounded-lg shadow ${className}`}
      onClick={onClick}      // <- ADICIONADO
    >
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