export interface Candidate {
  id: string
  name: string
  email: string
  phone: string
  skills: string[]
  experience: string
  education: string
  status: 'Applied' | 'Interview' | 'Offer' | 'Hired' | 'Rejected'
  appliedDate: string
  interviewDate?: string
  notes?: string
}
