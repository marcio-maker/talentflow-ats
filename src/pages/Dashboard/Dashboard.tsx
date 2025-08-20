import { useEffect } from 'react'
import { useApp } from '../../context/AppContext'
import { useDashboardStats } from '../../features/dashboard/useDashboardStats'
import BarChart from '../../components/charts/BarChart'
import PieChart from '../../components/charts/PieChart'
import Card from '../../components/ui/Card'

const Dashboard = () => {
  const { loading, setLoading } = useApp()
  const { stats, fetchStats } = useDashboardStats()

  useEffect(() => {
    const loadData = async () => {
      setLoading(true)
      await fetchStats()
      setLoading(false)
    }
    loadData()
  }, [fetchStats, setLoading])

  if (loading) return <div>Loading dashboard...</div>

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Dashboard</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card title="Total Candidates" value={stats.totalCandidates.toString()} />
        <Card title="Open Jobs" value={stats.openJobs.toString()} />
        <Card title="Hired This Month" value={stats.hiredThisMonth.toString()} />
        <Card title="Interviews Scheduled" value={stats.interviewScheduled.toString()} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <BarChart 
          data={stats.applicationTrends} 
          title="Application Trends (Last 6 Months)"
          dataKey="name"
          valueKey="value"
        />
        <PieChart 
          data={stats.statusDistribution} 
          title="Candidate Status Distribution"
          dataKey="name"
          valueKey="value"
        />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card title="Recent Activity">
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">New application received</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">John Doe applied for Senior Frontend Developer</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">2h ago</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Interview scheduled</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Jane Smith interview with Tech Team</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">1d ago</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Offer sent</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Mike Johnson received offer for Backend Engineer</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">3d ago</span>
            </div>
          </div>
        </Card>

        <Card title="Upcoming Interviews">
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Sarah Wilson</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Senior Frontend Developer • 10:00 AM</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">Today</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">David Brown</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">UX Designer • 2:30 PM</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">Tomorrow</span>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-gray-900 dark:text-white">Emily Chen</p>
                <p className="text-sm text-gray-500 dark:text-gray-400">Product Manager • 11:00 AM</p>
              </div>
              <span className="text-sm text-gray-500 dark:text-gray-400">Jun 12</span>
            </div>
          </div>
        </Card>
      </div>
    </div>
  )
}

export default Dashboard
