

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // 浅灰色背景，衬托白色卡片
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 顶部筛选栏 (自建 Widget)
              _buildFilterBar(), 
              const SizedBox(height: 16),
              
              // 2. 混合图表区域
              const DashboardChart(), 
              const SizedBox(height: 16),
              
              // 3. 商品排行列表 (也就是你的 buildProductList)
              _buildProductList(), 
            ],
          ),
        ),
      ),
    );
  }
Widget _buildFilterBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        const Text("商品排行", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Spacer(), // 将筛选控件推向右侧
        
        // 1. 下拉选择框
        Container(
          width: 120,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: "浏览量",
              items: ["浏览量", "访客数", "支付金额"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 13)),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
        const SizedBox(width: 10),

        // 2. 日期范围选择 (这里用简单的 TextField 模拟图片外观)
        Container(
          width: 200,
          height: 32,
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: "2026/03/03 - 2026/04/01",
              hintStyle: const TextStyle(fontSize: 12),
              prefixIcon: const Icon(Icons.calendar_today, size: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // 3. 查询按钮
        SizedBox(
          height: 32,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              elevation: 0,
            ),
            child: const Text("查询", style: TextStyle(fontSize: 13)),
          ),
        ),
      ],
    ),
  );
}
  // --- 这里的 buildProductList 建议包装在一个 Card 里 ---
  Widget _buildProductList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("商品排行", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1), // 分割线
          // 放置具体的 Table 代码
          _buildActualTable(), 
        ],
      ),
    );
  }

  Widget _buildActualTable() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal, // 允许横向滚动，防止列表太宽溢出
    child: DataTable(
      // 表头背景色
      headingRowColor: WidgetStateProperty.all(const Color(0xFFF5F7FA)),
      // 列间距
      columnSpacing: 30,
      // 每一列的定义
      columns: const [
        DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('商品图片', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('商品名称', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('浏览量', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('访客数', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('支付金额', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('转化率(%)', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      // 写死的数据行
      rows: [
        _buildStaticRow(
          "963", 
          "https://qcloud.dpfile.com/pc/RHRqluYVqD_8E_kcfwkiUYt9Wvs8TW8UMsIPg6zWq0-aKF3WiTGKFQQjvS4o_t_2.jpg", // 替换为真实商品图片地址
          "UR2024夏季新款女装复古纯欲氛围感一字肩短款T恤UWG440060", 
          "1117", "305", "1257.72", "16%"
        ),
        _buildStaticRow(
          "108", 
          "https://qcloud.dpfile.com/pc/RHRqluYVqD_8E_kcfwkiUYt9Wvs8TW8UMsIPg6zWq0-aKF3WiTGKFQQjvS4o_t_2.jpg", 
          "FOMIX 蛋壳椅 进口头层牛皮橙色单人沙发椅Egg chain设计师", 
          "1070", "285", "79949.54", "5%"
        ),
        _buildStaticRow(
          "48", 
          "https://qcloud.dpfile.com/pc/RHRqluYVqD_8E_kcfwkiUYt9Wvs8TW8UMsIPg6zWq0-aKF3WiTGKFQQjvS4o_t_2.jpg", 
          "阿迪达斯官网 adidas BBALL CAP COT 男女训练运动帽子", 
          "873", "233", "1410.10", "3%"
        ),
      ],
    ),
  );
}

// 辅助方法：构建单行数据
DataRow _buildStaticRow(String id, String imgUrl, String name, String views, String visitors, String price, String rate) {
  return DataRow(cells: [
    DataCell(Text(id)),
    DataCell(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(imgUrl, width: 40, height: 40, fit: BoxFit.cover),
        ),
      ),
    ),
    DataCell(
      Container(
        width: 250, // 限制名称宽度，防止表格过宽
        child: Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    ),
    DataCell(Text(views)),
    DataCell(Text(visitors)),
    DataCell(Text(price, style: const TextStyle(fontWeight: FontWeight.w500))),
    DataCell(Text(rate, style: const TextStyle(color: Colors.blue))),
  ]);
}
}

class DashboardChart extends StatelessWidget {
  const DashboardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: LineChart(
        LineChartData(
          // 设置 Y 轴最大值，方便对齐
          minY: 0, maxY: 200000, 
          
          titlesData: FlTitlesData(
            // X 轴日期标题
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const days = ['03-03', '03-04', '03-05', '03-06', '03-07', '03-08', '03-09', '03-10'];
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Transform.rotate(angle: -0.5, child: Text(days[value.toInt()], style: const TextStyle(fontSize: 10))),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            // 左侧金额轴
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 50, interval: 30000),
            ),
            // 右侧数量轴 (通过 interval 模拟 100, 200, 300, 400)
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 50000, // 映射 200000/400 = 500
                getTitlesWidget: (value, meta) => Text("${(value / 500).toInt()}"),
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          // 图表线条数据
          lineBarsData: [
            // 紫色线
            LineChartBarData(
              spots: const [FlSpot(0, 130000), FlSpot(1, 100000), FlSpot(2, 70000), FlSpot(3, 140000), FlSpot(4, 180000), FlSpot(5, 120000)],
              isCurved: true,
              color: Colors.purple.withOpacity(0.6),
              barWidth: 2,
              dotData: const FlDotData(show: false),
            ),
            // 橙色线
            LineChartBarData(
              spots: const [FlSpot(0, 20000), FlSpot(2, 15000), FlSpot(4, 30000), FlSpot(6, 25000)],
              isCurved: true,
              color: Colors.orange,
              barWidth: 2,
            ),
          ],

          // 模拟图片中的蓝色背景条 (柱状效果)
          extraLinesData: ExtraLinesData(
            verticalLines: [
              VerticalLine(x: 3, color: Colors.blue.withOpacity(0.8), strokeWidth: 20),
              VerticalLine(x: 4.5, color: Colors.blue.withOpacity(0.8), strokeWidth: 10),
              VerticalLine(x: 7, color: Colors.blue.withOpacity(0.8), strokeWidth: 15),
            ],
          ),

          gridData: const FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 30000),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}