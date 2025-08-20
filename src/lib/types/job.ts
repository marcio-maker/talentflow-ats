export interface Job {
  id: string
  title: string
  department: string
  level: 'Intern' | 'Junior' | 'Mid' | 'Senior' | 'Lead'
  description: string
  requirements: string[]
  location: string
  type: 'Full-time' | 'Part-time' | 'Contract' | 'Remote'
  status: 'Open' | 'Closed' | 'On-hold'
  salaryRange: {
    min: number
    max: number
    currency: string
  }
  applications: number
  createdDate: string
  closedDate?: string
}
