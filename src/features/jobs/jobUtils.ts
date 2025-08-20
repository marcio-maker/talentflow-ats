import { Job } from '../../lib/types/job'

export const filterJobsByStatus = (jobs: Job[], status: string): Job[] => {
  if (status === 'all') return jobs
  return jobs.filter(job => job.status === status)
}

export const filterJobsByDepartment = (jobs: Job[], department: string): Job[] => {
  if (department === 'all') return jobs
  return jobs.filter(job => job.department === department)
}

export const searchJobs = (jobs: Job[], query: string): Job[] => {
  if (!query) return jobs
  
  const lowerQuery = query.toLowerCase()
  return jobs.filter(job =>
    job.title.toLowerCase().includes(lowerQuery) ||
    job.department.toLowerCase().includes(lowerQuery) ||
    job.requirements.some(req => req.toLowerCase().includes(lowerQuery))
  )
}

export const sortJobs = (jobs: Job[], sortBy: string, order: 'asc' | 'desc' = 'asc'): Job[] => {
  return [...jobs].sort((a, b) => {
    let aValue: any = a[sortBy as keyof Job]
    let bValue: any = b[sortBy as keyof Job]
    
    if (sortBy === 'createdDate' || sortBy === 'closedDate') {
      aValue = new Date(aValue || 0).getTime()
      bValue = new Date(bValue || 0).getTime()
    }
    
    if (sortBy === 'salaryRange') {
      aValue = a.salaryRange.min
      bValue = b.salaryRange.min
    }
    
    if (aValue < bValue) return order === 'asc' ? -1 : 1
    if (aValue > bValue) return order === 'asc' ? 1 : -1
    return 0
  })
}
