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
