import { useState } from 'react'
import { Job } from '../../lib/types/job'
import JobCard from './JobCard'
import Table from '../ui/Table'
import { formatCurrency } from '../../lib/helpers/stringUtils'
import { formatDate } from '../../lib/helpers/dateUtils'

interface JobListProps {
  jobs: Job[]
  onJobClick: (job: Job) => void
  viewMode?: 'grid' | 'table'
}

const JobList = ({ jobs, onJobClick, viewMode = 'grid' }: JobListProps) => {
  const [statusFilter, setStatusFilter] = useState<string>('all')
  const [departmentFilter, setDepartmentFilter] = useState<string>('all')

  const departments = Array.from(new Set(jobs.map(job => job.department)))

  const filteredJobs = jobs.filter(job => {
    const statusMatch = statusFilter === 'all' || job.status === statusFilter
    const departmentMatch = departmentFilter === 'all' || job.department === departmentFilter
    return statusMatch && departmentMatch
  })

  const tableColumns = [
    { key: 'title', header: 'Title' },
    { key: 'department', header: 'Department' },
    { key: 'level', header: 'Level' },
    { key: 'location', header: 'Location' },
    { 
      key: 'salaryRange', 
      header: 'Salary Range',
      render: (range: any) => `${formatCurrency(range.min)} - ${formatCurrency(range.max)}`
    },
    { key: 'applications', header: 'Applications' },
    { key: 'status', header: 'Status' },
    { 
      key: 'createdDate', 
      header: 'Posted Date',
      render: (date: string) => formatDate(date)
    },
  ]

  if (viewMode === 'table') {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Jobs</h2>
          <div className="flex space-x-2">
            <select
              value={departmentFilter}
              onChange={(e) => setDepartmentFilter(e.target.value)}
              className="input-field w-auto"
            >
              <option value="all">All Departments</option>
              {departments.map(dept => (
                <option key={dept} value={dept}>{dept}</option>
              ))}
            </select>
            <select
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
              className="input-field w-auto"
            >
              <option value="all">All Statuses</option>
              <option value="Open">Open</option>
              <option value="Closed">Closed</option>
              <option value="On-hold">On-hold</option>
            </select>
          </div>
        </div>
        
        <Table 
          columns={tableColumns} 
          data={filteredJobs} 
          onRowClick={onJobClick}
        />
      </div>
    )
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Jobs</h2>
        <div className="flex space-x-2">
          <select
            value={departmentFilter}
            onChange={(e) => setDepartmentFilter(e.target.value)}
            className="input-field w-auto"
          >
            <option value="all">All Departments</option>
            {departments.map(dept => (
              <option key={dept} value={dept}>{dept}</option>
            ))}
          </select>
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="input-field w-auto"
          >
            <option value="all">All Statuses</option>
            <option value="Open">Open</option>
            <option value="Closed">Closed</option>
            <option value="On-hold">On-hold</option>
          </select>
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredJobs.map(job => (
          <JobCard
            key={job.id}
            job={job}
            onClick={() => onJobClick(job)}
          />
        ))}
      </div>
      
      {filteredJobs.length === 0 && (
        <div className="text-center py-12">
          <p className="text-gray-500 dark:text-gray-400">No jobs found</p>
        </div>
      )}
    </div>
  )
}

export default JobList
