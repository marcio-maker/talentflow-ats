import { useState } from 'react'
import { Job } from '../../lib/types/job'
import Button from '../ui/Button'
import Input from '../ui/Input'
import Select from '../ui/Select'

interface JobFormProps {
  initialData?: Job
  onSubmit: (job: Job) => void
  isLoading?: boolean
  onCancel?: () => void
}

const JobForm = ({ initialData, onSubmit, isLoading, onCancel }: JobFormProps) => {
  const [formData, setFormData] = useState<Job>(
    initialData || {
      id: '',
      title: '',
      department: '',
      level: 'Mid',
      description: '',
      requirements: [],
      location: '',
      type: 'Full-time',
      status: 'Open',
      salaryRange: {
        min: 0,
        max: 0,
        currency: 'USD'
      },
      applications: 0,
      createdDate: new Date().toISOString().split('T')[0],
    }
  )

  const [requirementsInput, setRequirementsInput] = useState(initialData?.requirements.join(', ') || '')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    const requirementsArray = requirementsInput.split(',').map(req => req.trim()).filter(Boolean)
    onSubmit({ ...formData, requirements: requirementsArray })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <Input
        label="Job Title"
        value={formData.title}
        onChange={(e) => setFormData({ ...formData, title: e.target.value })}
        required
      />
      
      <Input
        label="Department"
        value={formData.department}
        onChange={(e) => setFormData({ ...formData, department: e.target.value })}
        required
      />
      
      <Select
        label="Level"
        value={formData.level}
        onChange={(e) => setFormData({ ...formData, level: e.target.value as any })}
        options={[
          { value: 'Intern', label: 'Intern' },
          { value: 'Junior', label: 'Junior' },
          { value: 'Mid', label: 'Mid' },
          { value: 'Senior', label: 'Senior' },
          { value: 'Lead', label: 'Lead' },
        ]}
      />
      
      <div>
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
          Description
        </label>
        <textarea
          value={formData.description}
          onChange={(e) => setFormData({ ...formData, description: e.target.value })}
          className="input-field h-32"
          required
        />
      </div>
      
      <Input
        label="Requirements (comma-separated)"
        value={requirementsInput}
        onChange={(e) => setRequirementsInput(e.target.value)}
        placeholder="React, TypeScript, 5+ years experience"
      />
      
      <Input
        label="Location"
        value={formData.location}
        onChange={(e) => setFormData({ ...formData, location: e.target.value })}
        required
      />
      
      <Select
        label="Employment Type"
        value={formData.type}
        onChange={(e) => setFormData({ ...formData, type: e.target.value as any })}
        options={[
          { value: 'Full-time', label: 'Full-time' },
          { value: 'Part-time', label: 'Part-time' },
          { value: 'Contract', label: 'Contract' },
          { value: 'Remote', label: 'Remote' },
        ]}
      />
      
      <Select
        label="Status"
        value={formData.status}
        onChange={(e) => setFormData({ ...formData, status: e.target.value as any })}
        options={[
          { value: 'Open', label: 'Open' },
          { value: 'Closed', label: 'Closed' },
          { value: 'On-hold', label: 'On-hold' },
        ]}
      />
      
      <div className="grid grid-cols-2 gap-4">
        <Input
          label="Minimum Salary"
          type="number"
          value={formData.salaryRange.min}
          onChange={(e) => setFormData({ 
            ...formData, 
            salaryRange: { ...formData.salaryRange, min: parseInt(e.target.value) }
          })}
          required
        />
        
        <Input
          label="Maximum Salary"
          type="number"
          value={formData.salaryRange.max}
          onChange={(e) => setFormData({ 
            ...formData, 
            salaryRange: { ...formData.salaryRange, max: parseInt(e.target.value) }
          })}
          required
        />
      </div>
      
      <Input
        label="Currency"
        value={formData.salaryRange.currency}
        onChange={(e) => setFormData({ 
          ...formData, 
          salaryRange: { ...formData.salaryRange, currency: e.target.value }
        })}
        required
      />
      
      <div className="flex space-x-3">
        <Button type="submit" isLoading={isLoading}>
          {initialData ? 'Update Job' : 'Create Job'}
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

export default JobForm
