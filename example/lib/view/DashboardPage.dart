import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 顶部统计卡片
            Row(
              children: const [
                Expanded(child: StatCard(title: "用户访问量", value: "6,666", color: Colors.blue)),
                SizedBox(width: 12),
                Expanded(child: StatCard(title: "系统消息", value: "168", color: Colors.green)),
                SizedBox(width: 12),
                Expanded(child: StatCard(title: "商品数量", value: "8,888", color: Colors.red)),
                SizedBox(width: 12),
                Expanded(child: StatCard(title: "今日订单", value: "568", color: Colors.orange)),
              ],
            ),

            const SizedBox(height: 16),

            /// 图表区域
            Expanded(
              child: Row(
                children: [
                  /// 左边折线图
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: LineChart(_lineChartData()),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// 右边饼图
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: PieChart(_pieChartData()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 折线图
  LineChartData _lineChartData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: true),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          spots: const [
            FlSpot(0, 120),
            FlSpot(1, 140),
            FlSpot(2, 300),
            FlSpot(3, 150),
            FlSpot(4, 90),
            FlSpot(5, 230),
            FlSpot(6, 210),
          ],
          color: Colors.teal,
          barWidth: 3,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.teal.withOpacity(0.2),
          ),
        ),
        LineChartBarData(
          isCurved: true,
          spots: const [
            FlSpot(0, 220),
            FlSpot(1, 130),
            FlSpot(2, 200),
            FlSpot(3, 240),
            FlSpot(4, 190),
            FlSpot(5, 140),
            FlSpot(6, 310),
          ],
          color: Colors.red,
          barWidth: 2,
        ),
      ],
    );
  }

  /// 饼图
  PieChartData _pieChartData() {
    return PieChartData(
      sections: [
        PieChartSectionData(value: 30, color: Colors.blue, title: "30%"),
        PieChartSectionData(value: 25, color: Colors.green, title: "25%"),
        PieChartSectionData(value: 20, color: Colors.red, title: "20%"),
        PieChartSectionData(value: 15, color: Colors.orange, title: "15%"),
        PieChartSectionData(value: 10, color: Colors.teal, title: "10%"),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            child: const Icon(Icons.bar_chart, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}