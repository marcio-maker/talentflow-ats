import { useState } from 'react'
import { Candidate } from '../../lib/types/candidate'
import CandidateCard from './CandidateCard'
import Table from '../ui/Table'
import { formatDate } from '../../lib/helpers/dateUtils'

interface CandidateListProps {
  candidates: Candidate[]
  onCandidateClick: (candidate: Candidate) => void
  viewMode?: 'grid' | 'table'
}

const CandidateList = ({ candidates, onCandidateClick, viewMode = 'grid' }: CandidateListProps) => {
  const [statusFilter, setStatusFilter] = useState<string>('all')

  const filteredCandidates = statusFilter === 'all' 
    ? candidates 
    : candidates.filter(c => c.status === statusFilter)

  const tableColumns = [
    { key: 'name', header: 'Name' },
    { key: 'email', header: 'Email' },
    { key: 'phone', header: 'Phone' },
    { 
      key: 'skills', 
      header: 'Skills',
      render: (skills: string[]) => skills.slice(0, 3).join(', ')
    },
    { key: 'status', header: 'Status' },
    { 
      key: 'appliedDate', 
      header: 'Applied Date',
      render: (date: string) => formatDate(date)
    },
  ]

  if (viewMode === 'table') {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Candidates</h2>
          <select
            value={statusFilter}
            onChange={(e) => setStatusFilter(e.target.value)}
            className="input-field w-auto"
          >
            <option value="all">All Statuses</option>
            <option value="Applied">Applied</option>
            <option value="Interview">Interview</option>
            <option value="Offer">Offer</option>
            <option value="Hired">Hired</option>
            <option value="Rejected">Rejected</option>
          </select>
        </div>
        
        <Table 
          columns={tableColumns} 
          data={filteredCandidates} 
          onRowClick={onCandidateClick}
        />
      </div>
    )
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white">Candidates</h2>
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value)}
          className="input-field w-auto"
        >
          <option value="all">All Statuses</option>
          <option value="Applied">Applied</option>
          <option value="Interview">Interview</option>
          <option value="Offer">Offer</option>
          <option value="Hired">Hired</option>
          <option value="Rejected">Rejected</option>
        </select>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredCandidates.map(candidate => (
          <CandidateCard
            key={candidate.id}
            candidate={candidate}
            onClick={() => onCandidateClick(candidate)}
          />
        ))}
      </div>
      
      {filteredCandidates.length === 0 && (
        <div className="text-center py-12">
          <p className="text-gray-500 dark:text-gray-400">No candidates found</p>
        </div>
      )}
    </div>
  )
}

export default CandidateList
