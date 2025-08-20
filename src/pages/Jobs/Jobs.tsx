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
