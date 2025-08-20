import { Job } from '../lib/types/job'
import { mockJobs } from './mockData'

// Simulate network delay
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms))

export const getJobs = async (): Promise<Job[]> => {
  await delay(500)
  return mockJobs
}

export const getJobById = async (id: string): Promise<Job> => {
  await delay(300)
  const job = mockJobs.find(j => j.id === id)
  if (!job) throw new Error('Job not found')
  return job
}

export const createJob = async (job: Omit<Job, 'id'>): Promise<Job> => {
  await delay(400)
  const newJob: Job = {
    ...job,
    id: Date.now().toString(),
    applications: 0,
    createdDate: new Date().toISOString().split('T')[0]
  }
  mockJobs.push(newJob)
  return newJob
}

export const updateJob = async (id: string, job: Partial<Job>): Promise<Job> => {
  await delay(400)
  const index = mockJobs.findIndex(j => j.id === id)
  if (index === -1) throw new Error('Job not found')
  mockJobs[index] = { ...mockJobs[index], ...job }
  return mockJobs[index]
}

export const deleteJob = async (id: string): Promise<void> => {
  await delay(300)
  const index = mockJobs.findIndex(j => j.id === id)
  if (index === -1) throw new Error('Job not found')
  mockJobs.splice(index, 1)
}
