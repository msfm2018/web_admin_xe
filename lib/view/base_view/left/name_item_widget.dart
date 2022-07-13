import 'package:flutter/material.dart';
import '../mgr.dart';
import '../../../view_config/name_bean.dart';

class NameItemWidget extends StatefulWidget {
  final NameBean bean;
  const NameItemWidget(this.bean, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NameItemWidgetState createState() => _NameItemWidgetState();
}

class _NameItemWidgetState extends State<NameItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Mgr().colorControler.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return ListTile(
            title: _buildItem(widget.bean),
          );
        });
  }

  Widget _buildItem(NameBean bean) {
    if (bean.children.isEmpty) {
      return Mgr().selectedNodeName == bean.name
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
                if ((!Mgr().openedTabPageList.contains(bean.name)) &&
                    (Mgr().vView[bean.name] != null)) {
                  Mgr().openedTabPageList.add(bean.name);
                }
                Mgr().selectedNodeName = bean.name;
                Mgr().idControlerAction.add(bean.name);
                Mgr().idControler.add(bean.name);
                Mgr().colorControler.add(bean.name);
              },
            )
          : ListTile(
              title: Text(
                bean.name,
              ),
              onTap: () {
                if ((!Mgr().openedTabPageList.contains(bean.name)) &&
                    (Mgr().vView[bean.name] != null)) {
                  Mgr().openedTabPageList.add(bean.name);
                }
                Mgr().selectedNodeName = bean.name;
                Mgr().idControlerAction.add(bean.name);
                Mgr().idControler.add(bean.name);
                Mgr().colorControler.add(bean.name);
              },
            );
    }

    return ExpansionTile(
      key: PageStorageKey<NameBean>(bean),
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
