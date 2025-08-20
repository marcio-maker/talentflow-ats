import { useState, useCallback } from 'react'
import { getCandidates } from '../../api/candidateAPI'
import { getJobs } from '../../api/jobAPI'
import { useApp } from '../../context/AppContext'

interface DashboardStats {
  totalCandidates: number
  openJobs: number
  hiredThisMonth: number
  interviewScheduled: number
  applicationTrends: any[]
  statusDistribution: any[]
}

export const useDashboardStats = () => {
  const { setLoading, showToast } = useApp()
  const [stats, setStats] = useState<DashboardStats>({
    totalCandidates: 0,
    openJobs: 0,
    hiredThisMonth: 0,
    interviewScheduled: 0,
    applicationTrends: [],
    statusDistribution: []
  })

  const fetchStats = useCallback(async () => {
    try {
      setLoading(true)
      const [candidates, jobs] = await Promise.all([getCandidates(), getJobs()])
      
      // Calculate basic stats
      const totalCandidates = candidates.length
      const openJobs = jobs.filter(job => job.status === 'Open').length
      
      const thisMonth = new Date().getMonth()
      const hiredThisMonth = candidates.filter(candidate => 
        candidate.status === 'Hired' && 
        new Date(candidate.appliedDate).getMonth() === thisMonth
      ).length
      
      const interviewScheduled = candidates.filter(candidate => 
        candidate.status === 'Interview' && candidate.interviewDate
      ).length
      
      // Generate application trends (last 6 months)
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      const currentMonth = new Date().getMonth()
      const applicationTrends = Array.from({ length: 6 }, (_, i) => {
        const monthIndex = (currentMonth - 5 + i + 12) % 12
        const month = months[monthIndex]
        const count = candidates.filter(candidate => 
          new Date(candidate.appliedDate).getMonth() === monthIndex
        ).length
        return { name: month, value: count }
      })
      
      // Generate status distribution
      const statusDistribution = [
        { name: 'Applied', value: candidates.filter(c => c.status === 'Applied').length },
        { name: 'Interview', value: candidates.filter(c => c.status === 'Interview').length },
        { name: 'Offer', value: candidates.filter(c => c.status === 'Offer').length },
        { name: 'Hired', value: candidates.filter(c => c.status === 'Hired').length },
        { name: 'Rejected', value: candidates.filter(c => c.status === 'Rejected').length },
      ]
      
      setStats({
        totalCandidates,
        openJobs,
        hiredThisMonth,
        interviewScheduled,
        applicationTrends,
        statusDistribution
      })
    } catch (error) {
      showToast({ message: 'Failed to load dashboard stats', type: 'error' })
    } finally {
      setLoading(false)
    }
  }, [setLoading, showToast])

  return {
    stats,
    fetchStats
  }
}
