import 'package:flutter/material.dart';

import 'package:web_admin/plug/toast/lib/toast.dart';
// import 'package:myplus/myplus.dart';

// final searchList = ['jiejie-大长腿', 'jiejie-水蛇腰', 'gege-帅气欧巴', 'gege-小鲜肉'];
final searchList = [];

final recentSuggest = [
  // '推荐-1',
  // '推荐-2',
];

class SearchBarDelegate extends SearchDelegate<String> {
  ScrollController controller1 = ScrollController();
  //清空按钮  右边按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
            showSuggestions(context);
          } //搜索值为空
          )
    ];
  }

  //返回上级按钮  左边按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, 'null') //点击时关闭整个搜索页面
        );
  }

  //搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  //搜索查询 与建议 都在这里呈现
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
        controller: controller1,
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) => GestureDetector(
              child: ListTile(
                title: RichText(
                  //富文本
                  text: TextSpan(
                      text: suggestionsList[index].substring(0, query.length),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text:
                                suggestionsList[index].substring(query.length),
                            style: const TextStyle(color: Colors.grey))
                      ]),
                ),
              ),
              onTap: () {
                Toast.show(suggestionsList[index],
                    duration: Toast.lengthLong, gravity: Toast.bottom);
                // late Widget wd;
                // // for (var i = 0; i < Mgr().leafNodes.length - 1; i++) {
                // //   if (Mgr().leafNodes[i].name == suggestionsList[index]) {
                // //     wd = Mgr().leafNodes[i].object;
                // //     break;
                // //   }
                // // }

                // // Navigator.pushAndRemoveUntil(
                // //     context,
                // //     MaterialPageRoute<void>(
                // //         builder: (BuildContext context) => wd),
                // //     (route) => true);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute<void>(
                //         builder: (BuildContext context) => wd));
              },
            ));
  }
}
