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
