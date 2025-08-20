import { Candidate } from '../../lib/types/candidate'

export const filterCandidatesByStatus = (candidates: Candidate[], status: string): Candidate[] => {
  if (status === 'all') return candidates
  return candidates.filter(candidate => candidate.status === status)
}

export const searchCandidates = (candidates: Candidate[], query: string): Candidate[] => {
  if (!query) return candidates
  
  const lowerQuery = query.toLowerCase()
  return candidates.filter(candidate =>
    candidate.name.toLowerCase().includes(lowerQuery) ||
    candidate.email.toLowerCase().includes(lowerQuery) ||
    candidate.skills.some(skill => skill.toLowerCase().includes(lowerQuery))
  )
}

export const sortCandidates = (candidates: Candidate[], sortBy: string, order: 'asc' | 'desc' = 'asc'): Candidate[] => {
  return [...candidates].sort((a, b) => {
    let aValue: any = a[sortBy as keyof Candidate]
    let bValue: any = b[sortBy as keyof Candidate]
    
    if (sortBy === 'appliedDate' || sortBy === 'interviewDate') {
      aValue = new Date(aValue || 0).getTime()
      bValue = new Date(bValue || 0).getTime()
    }
    
    if (aValue < bValue) return order === 'asc' ? -1 : 1
    if (aValue > bValue) return order === 'asc' ? 1 : -1
    return 0
  })
}
