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
