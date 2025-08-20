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
