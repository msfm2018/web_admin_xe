import 'package:flutter/material.dart';
import '../core.dart';
import '../../tree_config/data_bean.dart';

class ItemPage extends StatefulWidget {
  final DataBean bean;
  const ItemPage(this.bean, {Key? key}) : super(key: key);

  @override
  ItemPageState createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Core.instance.itemControlerAction.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return ListTile(
            title: _buildItem(widget.bean),
          );
        });
  }

  Widget _buildItem(DataBean bean) {
    if (bean.children.isEmpty) {
      return Core.instance.selectedNodeName == bean.name
          ? ListTile(
              dense: true,
              title: Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.green.withOpacity(0.5),
                child: Text(
                  bean.name,
                ),
              ),
              enabled: true,
              onTap: () {
                if ((!Core.instance.openedPageList.contains(bean.name)) && (Core.instance.pages[bean.name] != null)) {
                  Core.instance.openedPageList.add(bean.name);
                }
                Core.instance.selectedNodeName = bean.name;
                Core.instance.notifyBtns(bean.name);
                Core.instance.notifyPage(bean.name);
                Core.instance.notifyItem(bean.name);
              },
            )
          : ListTile(
              title: Text(
                bean.name,
              ),
              onTap: () {
                if ((!Core.instance.openedPageList.contains(bean.name)) && (Core.instance.pages[bean.name] != null)) {
                  Core.instance.openedPageList.add(bean.name);
                }
                Core.instance.selectedNodeName = bean.name;
                Core.instance.notifyBtns(bean.name);
                Core.instance.notifyPage(bean.name);
                Core.instance.notifyItem(bean.name);
              },
            );
    }

    return ExpansionTile(
      key: PageStorageKey<DataBean>(bean),
      title: Text(
        bean.name,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          bean.name.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      children: bean.children.map((e) => _buildItem(e)).toList(),
    );
  }

  // _showSeletedName(String name) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text("选择的是：$name")));
  // }
}
