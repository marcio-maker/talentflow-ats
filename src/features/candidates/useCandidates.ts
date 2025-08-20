import { useState, useEffect } from 'react'
import { getCandidates, createCandidate, updateCandidate, deleteCandidate } from '../../api/candidateAPI'
import { Candidate } from '../../lib/types/candidate'
import { useApp } from '../../context/AppContext'

export const useCandidates = () => {
  const { setLoading, showToast } = useApp()
  const [candidates, setCandidates] = useState<Candidate[]>([])
  const [selectedCandidate, setSelectedCandidate] = useState<Candidate | null>(null)

  const fetchCandidates = async () => {
    try {
      setLoading(true)
      const data = await getCandidates()
      setCandidates(data)
    } catch (error) {
      showToast({ message: 'Failed to fetch candidates', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleCreate = async (candidate: Omit<Candidate, 'id'>) => {
    try {
      setLoading(true)
      const newCandidate = await createCandidate(candidate)
      setCandidates([...candidates, newCandidate])
      showToast({ message: 'Candidate created successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to create candidate', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleUpdate = async (id: string, candidate: Partial<Candidate>) => {
    try {
      setLoading(true)
      const updatedCandidate = await updateCandidate(id, candidate)
      setCandidates(candidates.map(c => (c.id === id ? updatedCandidate : c)))
      showToast({ message: 'Candidate updated successfully', type: 'success' })
      return true
    } catch (error) {
      showToast({ message: 'Failed to update candidate', type: 'error' })
      return false
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (id: string) => {
    try {
      setLoading(true)
      await deleteCandidate(id)
      setCandidates(candidates.filter(c => c.id !== id))
      showToast({ message: 'Candidate deleted successfully', type: 'success' })
    } catch (error) {
      showToast({ message: 'Failed to delete candidate', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchCandidates()
  }, [])

  return {
    candidates,
    selectedCandidate,
    setSelectedCandidate,
    handleCreate,
    handleUpdate,
    handleDelete,
    fetchCandidates,
  }
}
