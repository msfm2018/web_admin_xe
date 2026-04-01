
import 'package:flutter/material.dart';
import 'package:simple_tree/simple_tree.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'auth.dart';
import 'service/menu_processor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  List<TreeBase> treeData = [];

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    try {
      final jsonString = await rootBundle.loadString('assets/menu.json');
      final List list = json.decode(jsonString);
      final nodes = list.map((e) => TreeNode.fromJson(e)).toList();

      final pages = MenuProcessor.convertToPages(nodes);
      Core.instance.initPages(pages);

      setState(() {
        treeData = nodes;
      });
    } catch (e) {
      debugPrint("加载菜单失败: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (treeData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          // ==================== 左侧固定栏（已放入菜单切换按钮）====================
          Container(
            width: 70,
            color: const Color(0xFF1E293B),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const FlutterLogo(size: 40),
                const SizedBox(height: 30),
                _buildIconItem(
                  tooltip: '切换菜单',
                  icon: Core.instance.isSidebarCollapsed.value ? Icons.menu : Icons.menu_open,
                  onTap: () {
                    Core.instance.toggleSidebar();
                  },
                ),
                _buildIconItem(
                  tooltip: '首页',
                  icon: Icons.home,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildIconItem(
                  tooltip: '功能1',
                  icon: Icons.ac_unit,
                  onTap: () {},
                ),
                const SizedBox(height: 15),
                _buildIconItem(
                  tooltip: '功能2',
                  icon: Icons.dashboard,
                  onTap: () {},
                ),
                const SizedBox(height: 15),
                _buildIconItem(
                  tooltip: '退出登录',
                  icon: Icons.settings,
                  onTap: () {
                    Auth.logout();
                  },
                ),
              ],
            ),
          ),

          // ==================== 右侧：树菜单 ====================
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: TreeWidget(data: treeData),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildIconItem({
  required IconData icon,
  required VoidCallback onTap,
  required String tooltip, // 👈 新增参数
}) {
  bool isHovering = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) => setState(() => isHovering = true),
        onExit: (_) => setState(() => isHovering = false),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Tooltip(
            message: tooltip, // 👈 关键：提示文字
            waitDuration: Duration(milliseconds: 300), // 可选：延迟显示
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              hoverColor: Colors.white12,
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: isHovering
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  size: 24,
                  color: isHovering ? Colors.blue : Colors.white70,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
  Widget _buildIconItem1({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    bool isHovering = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              hoverColor: Colors.white12,
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: isHovering ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  size: 24,
                  color: isHovering ? Colors.blue : Colors.white70,
                ),
              ),
              // child: Padding(
              //   padding: const EdgeInsets.all(12),
              //   child: Icon(
              //     icon,
              //     size: 24,
              //     // color: isHovering ? Colors.white : Colors.white70, // 👈 关键
              //     color: isHovering ? Colors.blue : Colors.white70,
              //   ),
              // ),
            ),
          ),
        );
      },
    );
  }
}
