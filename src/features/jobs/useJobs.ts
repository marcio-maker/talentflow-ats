import { useState, useEffect } from 'react'
import { getJobs, createJob, updateJob, deleteJob } from '../../api/jobAPI'
import { Job } from '../../lib/types/job'
import { useApp } from '../../context/AppContext'

export const useJobs = () => {
  const { setLoading, showToast } = useApp()
  const [jobs, setJobs] = useState<Job[]>([])
  const [selectedJob, setSelectedJob] = useState<Job | null>(null)

  const fetchJobs = async () => {
    try {
      setLoading(true)
      const data = await getJobs()
      setJobs(data)
    } catch (error) {
      showToast({ message: 'Failed to fetch jobs', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleCreate = async (job: Omit<Job, 'id'>) => {
    try {
      setLoading(true)
      const newJob = await createJob(job)
      setJobs([...jobs, newJob])
      showToast({ message: 'Job created successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to create job', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleUpdate = async (id: string, job: Partial<Job>) => {
    try {
      setLoading(true)
      const updatedJob = await updateJob(id, job)
      setJobs(jobs.map(j => (j.id === id ? updatedJob : j)))
      showToast({ message: 'Job updated successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to update job', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (id: string) => {
    try {
      setLoading(true)
      await deleteJob(id)
      setJobs(jobs.filter(j => j.id !== id))
      showToast({ message: 'Job deleted successfully', type: 'success' })
    } catch (error) {
      showToast({ message: 'Failed to delete job', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchJobs()
  }, [])

  return {
    jobs,
    selectedJob,
    setSelectedJob,
    handleCreate,
    handleUpdate,
    handleDelete,
    fetchJobs,
  }
}
