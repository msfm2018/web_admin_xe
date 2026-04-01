
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardChart extends StatelessWidget {
  const DashboardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LineChart(
        LineChartData(
          // 1. 坐标轴范围配置
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 180000, // 左侧金额轴最大值
          
          // 2. 标题与双 Y 轴配置
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text("${value.toInt() + 3}-01", style: TextStyle(fontSize: 10)),
              ),
            ),
            // 左侧轴：显示金额 (0 - 180,000)
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
              ),
            ),
            // 右侧轴：显示数量 (映射 0 - 400)
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  // 将 0-180000 线性映射到 0-400 显示
                  double displayValue = (value / 180000) * 400;
                  return Text(displayValue.toInt().toString());
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          // 3. 数据线配置
          lineBarsData: [
            // 紫色平滑折线 (金额)
            LineChartBarData(
              spots: const [FlSpot(0, 130000), FlSpot(2, 80000), FlSpot(4, 140000), FlSpot(6, 170000), FlSpot(8, 90000), FlSpot(10, 110000)],
              isCurved: true,
              color: Colors.purple,
              barWidth: 2,
              dotData: const FlDotData(show: true),
            ),
            // 橙色折线 (比例/访客)
            LineChartBarData(
              spots: const [FlSpot(0, 20000), FlSpot(3, 30000), FlSpot(6, 25000), FlSpot(10, 35000)],
              isCurved: true,
              color: Colors.orange,
              barWidth: 2,
              dotData: const FlDotData(show: true),
            ),
          ],

          // 4. 重点：用 ExtraLinesData 模拟柱状图 (或者使用额外的 BarChart)
          // 如果要追求图片中那种细柱子，也可以在 Stack 里底层放 BarChart，顶层放 LineChart
          extraLinesData: ExtraLinesData(
            verticalLines: [
              VerticalLine(x: 3, color: Colors.blue.withOpacity(0.8), strokeWidth: 15), // 模拟 03-13 的大柱子
              VerticalLine(x: 5, color: Colors.blue.withOpacity(0.8), strokeWidth: 10),
              VerticalLine(x: 8, color: Colors.blue.withOpacity(0.8), strokeWidth: 12),
            ],
          ),
          
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: true, border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        ),
      ),
    );
  }
}