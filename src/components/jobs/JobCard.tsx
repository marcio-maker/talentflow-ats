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
