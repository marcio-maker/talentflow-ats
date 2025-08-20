import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts'

interface SparklineProps {
  data: any[]
  dataKey: string
  valueKey: string
  color?: string
  height?: number
}

const Sparkline = ({ 
  data, 
  dataKey, 
  valueKey, 
  color = '#0ea5e9',
  height = 40 
}: SparklineProps) => {
  return (
    <ResponsiveContainer width="100%" height={height}>
      <LineChart data={data}>
        <Line
          type="monotone"
          dataKey={valueKey}
          stroke={color}
          strokeWidth={2}
          dot={false}
        />
        <XAxis dataKey={dataKey} hide />
        <YAxis hide />
        <Tooltip />
      </LineChart>
    </ResponsiveContainer>
  )
}

export default Sparkline
