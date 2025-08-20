import { Candidate } from '../lib/types/candidate'
import { Job } from '../lib/types/job'

export const mockCandidates: Candidate[] = [
  {
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+1 (555) 123-4567',
    skills: ['React', 'TypeScript', 'Node.js', 'CSS'],
    experience: '5 years',
    education: 'BS in Computer Science',
    status: 'Interview',
    appliedDate: '2023-03-15',
    interviewDate: '2023-03-20',
    notes: 'Strong React skills, good communication'
  },
  {
    id: '2',
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    phone: '+1 (555) 987-6543',
    skills: ['Angular', 'Java', 'Spring Boot', 'SQL'],
    experience: '7 years',
    education: 'MS in Software Engineering',
    status: 'Applied',
    appliedDate: '2023-03-18',
    notes: 'Extensive backend experience'
  },
  {
    id: '3',
    name: 'Mike Johnson',
    email: 'mike.johnson@example.com',
    phone: '+1 (555) 456-7890',
    skills: ['Vue.js', 'JavaScript', 'HTML', 'CSS'],
    experience: '3 years',
    education: 'BS in Web Development',
    status: 'Hired',
    appliedDate: '2023-02-10',
    interviewDate: '2023-02-15',
    notes: 'Great cultural fit, quick learner'
  },
  {
    id: '4',
    name: 'Sarah Wilson',
    email: 'sarah.wilson@example.com',
    phone: '+1 (555) 234-5678',
    skills: ['Python', 'Django', 'PostgreSQL', 'Docker'],
    experience: '4 years',
    education: 'BS in Computer Engineering',
    status: 'Offer',
    appliedDate: '2023-03-12',
    interviewDate: '2023-03-17',
    notes: 'Strong problem-solving skills'
  },
  {
    id: '5',
    name: 'David Brown',
    email: 'david.brown@example.com',
    phone: '+1 (555) 876-5432',
    skills: ['React Native', 'Firebase', 'Redux', 'Jest'],
    experience: '2 years',
    education: 'BS in Mobile Development',
    status: 'Rejected',
    appliedDate: '2023-03-05',
    interviewDate: '2023-03-10',
    notes: 'Lacked required testing experience'
  }
]

export const mockJobs: Job[] = [
  {
    id: '1',
    title: 'Senior Frontend Developer',
    department: 'Engineering',
    level: 'Senior',
    description: 'We are looking for a skilled Frontend Developer to join our team...',
    requirements: ['React', 'TypeScript', '5+ years experience', 'CSS expertise'],
    location: 'Remote',
    type: 'Full-time',
    status: 'Open',
    salaryRange: {
      min: 90000,
      max: 130000,
      currency: 'USD'
    },
    applications: 24,
    createdDate: '2023-02-01'
  },
  {
    id: '2',
    title: 'Backend Engineer',
    department: 'Engineering',
    level: 'Mid',
    description: 'Join our backend team to build scalable APIs and services...',
    requirements: ['Node.js', 'Python', '3+ years experience', 'Database knowledge'],
    location: 'San Francisco, CA',
    type: 'Full-time',
    status: 'Open',
    salaryRange: {
      min: 85000,
      max: 120000,
      currency: 'USD'
    },
    applications: 18,
    createdDate: '2023-02-15'
  },
  {
    id: '3',
    title: 'UX Designer',
    department: 'Design',
    level: 'Senior',
    description: 'Create beautiful and intuitive user experiences for our products...',
    requirements: ['Figma', 'User research', '5+ years experience', 'Prototyping'],
    location: 'New York, NY',
    type: 'Full-time',
    status: 'On-hold',
    salaryRange: {
      min: 80000,
      max: 110000,
      currency: 'USD'
    },
    applications: 15,
    createdDate: '2023-01-20'
  },
  {
    id: '4',
    title: 'DevOps Engineer',
    department: 'Operations',
    level: 'Senior',
    description: 'Manage our cloud infrastructure and CI/CD pipelines...',
    requirements: ['AWS', 'Docker', 'Kubernetes', '4+ years experience'],
    location: 'Remote',
    type: 'Full-time',
    status: 'Open',
    salaryRange: {
      min: 100000,
      max: 140000,
      currency: 'USD'
    },
    applications: 12,
    createdDate: '2023-03-01'
  },
  {
    id: '5',
    title: 'Product Manager',
    department: 'Product',
    level: 'Lead',
    description: 'Lead product development and work with cross-functional teams...',
    requirements: ['Product strategy', 'Agile methodology', '6+ years experience'],
    location: 'Austin, TX',
    type: 'Full-time',
    status: 'Closed',
    salaryRange: {
      min: 110000,
      max: 150000,
      currency: 'USD'
    },
    applications: 32,
    createdDate: '2023-01-10',
    closedDate: '2023-02-28'
  }
]
