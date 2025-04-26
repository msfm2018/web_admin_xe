import 'package:flutter/material.dart';
import 'core.dart';
import 'data.dart';

class ItemPage extends StatefulWidget {
  final TreeData bean;
  const ItemPage(this.bean, {super.key});

  @override
  ItemPageState createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Core.instance.itemControllerAction.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return ListTile(title: _buildItem(widget.bean));
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

  void _handlePressed(TreeData bean) {
    try {
      var entry2 = Core.instance.pageMap.entries.firstWhere((entry) => entry.value.name == bean.name);
      entry2.value.isActive = true;

      Core.instance.selectedNodeName = bean.name;
      Core.instance.notifyBtns(bean.name);
      Core.instance.notifyPage(bean.name);
      Core.instance.notifyItem(bean.name);
    } catch (e) {
      debugPrint('error:-->Core.instance.pageMap.entries.firstWhere(...)');
    }
  }

  Widget _buildItem(TreeData bean) {
    if (bean.children.isEmpty) {
      return Core.instance.selectedNodeName == bean.name
          ? TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue[200]!), // 设置背景颜色
              foregroundColor: WidgetStateProperty.resolveWith<Color?>(foregroundColor),
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero), // 设置内边距为零
              minimumSize: WidgetStateProperty.all<Size>(const Size(44, 40)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.center,
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 设置圆角半径
                ),
              ),
              side: WidgetStateProperty.all<BorderSide>(
                const BorderSide(width: 1.0, color: Colors.white), // 设置边框宽度和颜色
              ),
              iconColor: WidgetStateProperty.all<Color?>(Colors.white),
              iconSize: WidgetStateProperty.all(15),
            ),
            child: Text(bean.name, style: bean.style ?? Config.style),
            onPressed: () => _handlePressed(bean),
          )
          : TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color?>(overlayColor),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>(foregroundColor),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: Text(bean.name, style: bean.style ?? Config.style),
            onPressed: () => _handlePressed(bean),
          );
    }

    return ExpansionTile(
      key: PageStorageKey<TreeData>(bean),
      title: Text(bean.name, style: Config.style),
      leading: CircleAvatar(backgroundColor: Colors.green, child: Text(bean.name.substring(0, 1), style: const TextStyle(color: Colors.white))),
      children: bean.children.map((e) => _buildItem(e)).toList(),
    );
  }
}
