import { useState } from 'react'
import { Candidate } from '../../lib/types/candidate'
import Button from '../ui/Button'
import Input from '../ui/Input'
import Select from '../ui/Select'

interface CandidateFormProps {
  initialData?: Candidate
  onSubmit: (candidate: Candidate) => void
  isLoading?: boolean
  onCancel?: () => void
}

const CandidateForm = ({ initialData, onSubmit, isLoading, onCancel }: CandidateFormProps) => {
  const [formData, setFormData] = useState<Candidate>(
    initialData || {
      id: '',
      name: '',
      email: '',
      phone: '',
      skills: [],
      experience: '',
      education: '',
      status: 'Applied',
      appliedDate: new Date().toISOString().split('T')[0],
      notes: ''
    }
  )

  const [skillsInput, setSkillsInput] = useState(initialData?.skills.join(', ') || '')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    const skillsArray = skillsInput.split(',').map(skill => skill.trim()).filter(Boolean)
    onSubmit({ ...formData, skills: skillsArray })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <Input
        label="Full Name"
        value={formData.name}
        onChange={(e) => setFormData({ ...formData, name: e.target.value })}
        required
      />
      
      <Input
        label="Email"
        type="email"
        value={formData.email}
        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
        required
      />
      
      <Input
        label="Phone"
        value={formData.phone}
        onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
      />
      
      <Input
        label="Skills (comma-separated)"
        value={skillsInput}
        onChange={(e) => setSkillsInput(e.target.value)}
        placeholder="React, TypeScript, Node.js"
      />
      
      <Input
        label="Experience"
        value={formData.experience}
        onChange={(e) => setFormData({ ...formData, experience: e.target.value })}
        placeholder="5 years"
      />
      
      <Input
        label="Education"
        value={formData.education}
        onChange={(e) => setFormData({ ...formData, education: e.target.value })}
        placeholder="BS in Computer Science"
      />
      
      <Select
        label="Status"
        value={formData.status}
        onChange={(e) => setFormData({ ...formData, status: e.target.value as any })}
        options={[
          { value: 'Applied', label: 'Applied' },
          { value: 'Interview', label: 'Interview' },
          { value: 'Offer', label: 'Offer' },
          { value: 'Hired', label: 'Hired' },
          { value: 'Rejected', label: 'Rejected' },
        ]}
      />
      
      <Input
        label="Applied Date"
        type="date"
        value={formData.appliedDate}
        onChange={(e) => setFormData({ ...formData, appliedDate: e.target.value })}
      />
      
      {formData.status === 'Interview' && (
        <Input
          label="Interview Date"
          type="date"
          value={formData.interviewDate || ''}
          onChange={(e) => setFormData({ ...formData, interviewDate: e.target.value })}
        />
      )}
      
      <div className="flex space-x-3">
        <Button type="submit" isLoading={isLoading}>
          {initialData ? 'Update Candidate' : 'Add Candidate'}
        </Button>
        {onCancel && (
          <Button type="button" variant="outline" onClick={onCancel}>
            Cancel
          </Button>
        )}
      </div>
    </form>
  )
}

export default CandidateForm
