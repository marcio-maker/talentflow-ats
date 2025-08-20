import { useState } from 'react'
import { useCandidates } from '../../features/candidates/useCandidates'
import { Candidate } from '../../lib/types/candidate'
import CandidateList from '../../components/candidates/CandidateList'
import CandidateForm from '../../components/candidates/CandidateForm'
import Button from '../../components/ui/Button'
import Card from '../../components/ui/Card'
import { useToast } from '../../hooks/useToast'

const Candidates = () => {
  const { candidates, handleCreate, handleUpdate, handleDelete } = useCandidates()
  const [isFormOpen, setIsFormOpen] = useState(false)
  const [editingCandidate, setEditingCandidate] = useState<Candidate | null>(null)
  const [viewMode, setViewMode] = useState<'grid' | 'table'>('grid')
  const toast = useToast()

  const handleCandidateClick = (candidate: Candidate) => {
    setEditingCandidate(candidate)
    setIsFormOpen(true)
  }

  const handleFormSubmit = async (candidateData: Candidate) => {
    const isEdit = !!editingCandidate
    const success = isEdit
      ? await handleUpdate(editingCandidate.id, candidateData)
      : await handleCreate(candidateData)
    
    if (success) {
      setIsFormOpen(false)
      setEditingCandidate(null)
      toast.success(`Candidate ${isEdit ? 'updated' : 'created'} successfully`)
    }
  }

  const handleDeleteCandidate = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this candidate?')) {
      await handleDelete(id)
    }
  }

  if (isFormOpen) {
    return (
      <div className="max-w-4xl mx-auto">
        <div className="flex items-center justify-between mb-6">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            {editingCandidate ? 'Edit Candidate' : 'Add New Candidate'}
          </h1>
          <Button variant="outline" onClick={() => {
            setIsFormOpen(false)
            setEditingCandidate(null)
          }}>
            Cancel
          </Button>
        </div>
        
        <Card>
          <CandidateForm
            initialData={editingCandidate || undefined}
            onSubmit={handleFormSubmit}
            onCancel={() => {
              setIsFormOpen(false)
              setEditingCandidate(null)
            }}
          />
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Candidates</h1>
        <div className="flex space-x-3">
          <select
            value={viewMode}
            onChange={(e) => setViewMode(e.target.value as 'grid' | 'table')}
            className="input-field w-auto"
          >
            <option value="grid">Grid View</option>
            <option value="table">Table View</option>
          </select>
          <Button onClick={() => setIsFormOpen(true)}>
            Add Candidate
          </Button>
        </div>
      </div>

      <CandidateList
        candidates={candidates}
        onCandidateClick={handleCandidateClick}
        viewMode={viewMode}
      />
    </div>
  )
}

export default Candidates
