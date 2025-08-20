import { BarChart as RechartsBarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import Card from '../ui/Card'

interface BarChartProps {
  data: any[]
  title: string
  dataKey: string
  valueKey: string
}

const BarChart = ({ 
  data, 
  title, 
  dataKey = 'name', 
  valueKey = 'value' 
}: BarChartProps) => {
  return (
    <Card title={title}>
      <div className="h-80">
        <ResponsiveContainer width="100%" height="100%">
          <RechartsBarChart data={data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey={dataKey} />
            <YAxis />
            <Tooltip />
            <Bar dataKey={valueKey} fill="#0ea5e9" />
          </RechartsBarChart>
        </ResponsiveContainer>
      </div>
    </Card>
  )
}

export default BarChart
