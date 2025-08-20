import { Candidate } from '../lib/types/candidate'
import { mockCandidates } from './mockData'

// Simulate network delay
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms))

export const getCandidates = async (): Promise<Candidate[]> => {
  await delay(500)
  return mockCandidates
}

export const getCandidateById = async (id: string): Promise<Candidate> => {
  await delay(300)
  const candidate = mockCandidates.find(c => c.id === id)
  if (!candidate) throw new Error('Candidate not found')
  return candidate
}

export const createCandidate = async (candidate: Omit<Candidate, 'id'>): Promise<Candidate> => {
  await delay(400)
  const newCandidate: Candidate = {
    ...candidate,
    id: Date.now().toString()
  }
  mockCandidates.push(newCandidate)
  return newCandidate
}

export const updateCandidate = async (id: string, candidate: Partial<Candidate>): Promise<Candidate> => {
  await delay(400)
  const index = mockCandidates.findIndex(c => c.id === id)
  if (index === -1) throw new Error('Candidate not found')
  mockCandidates[index] = { ...mockCandidates[index], ...candidate }
  return mockCandidates[index]
}

export const deleteCandidate = async (id: string): Promise<void> => {
  await delay(300)
  const index = mockCandidates.findIndex(c => c.id === id)
  if (index === -1) throw new Error('Candidate not found')
  mockCandidates.splice(index, 1)
}
