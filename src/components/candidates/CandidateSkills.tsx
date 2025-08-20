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
