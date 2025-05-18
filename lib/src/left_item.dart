import 'package:flutter/material.dart';
import 'package:rxflare/rxflare.dart';
import 'core.dart';
import 'tree_base.dart';

class ItemPage extends StatefulWidget {
  final TreeBase bean;
  const ItemPage(this.bean, {super.key});

  @override
  ItemPageState createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Rx.custom(
      deps: [Core.instance.itemAction, Core.instance.selectedNodeIndex], // Depend on itemAction and selectedNodeIndex
      builder: () {
        return ListTile(title: _buildItem(widget.bean, depth: 0));
      },
    );
  }

  Color? foregroundColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.focused) || states.contains(WidgetState.hovered)) {
      return Colors.white;
    }
    return null;
  }

  Color? overlayColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.focused)) {
      return Colors.grey.withAlpha(200);
    }
    if (states.contains(WidgetState.hovered)) {
      return Colors.blue[200];
    }
    return null;
  }

  void _handlePressed(TreeBase bean) {
    try {
      var entry2 = Core.instance.pageMap.value.entries.firstWhere((entry) => entry.value.index == bean.index);
      final updatedEntry = entry2.value.copyWith(isActive: true); // Use copyWith
      Core.instance.updatePageInfo(entry2.key, updatedEntry); // 更新 pageMap

      Core.instance.selectedNodeIndex.value = bean.index;
      Core.instance.notifyBtns(bean.index);
      Core.instance.notifyPage(bean.index);
      Core.instance.notifyItem(bean.index);
    } catch (e) {
      // debugPrint('error:-->Core.instance.pageMap.entries.firstWhere(...)');
      print('Error in _handlePressed: $e'); // 更好的错误处理
    }
  }

  Widget _buildItem(TreeBase bean, {int depth = 0}) {
    final indent = depth * 16.0;

    if (bean.children.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: indent),
        child: Core.instance.selectedNodeIndex.value == bean.index // Access .value
            ? TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue[200]!),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(foregroundColor),
                  padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(44, 40)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  side: WidgetStateProperty.all<BorderSide>(const BorderSide(width: 1.0, color: Colors.white)),
                  iconColor: WidgetStateProperty.all<Color?>(Colors.white),
                  iconSize: WidgetStateProperty.all(15),
                ),
                child: Text(bean.name, style: bean.style ?? Core.instance.style),
                onPressed: () => _handlePressed(bean),
              )
            : TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(overlayColor),
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(foregroundColor),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text(bean.name, style: bean.style ?? Core.instance.style),
                onPressed: () => _handlePressed(bean),
              ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: ExpansionTile(
        key: PageStorageKey<TreeBase>(bean),
        title: Text(bean.name, style: Core.instance.style),
        // leading: CircleAvatar(backgroundColor: Colors.green, child: Text(bean.name.substring(0, 1), style: const TextStyle(color: Colors.white))),
        leading: Container(
          width: 12.0, // Diameter of the circle
          height: 12.0,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        children: bean.children.map((e) => _buildItem(e, depth: depth + 1)).toList(),

      ),
    );
  }
}
