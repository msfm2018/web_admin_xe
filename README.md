## 数据定义

 import 'package:simple_tree/simple_tree.dart';

```数据定义
final List<DataBean> data = <DataBean>[
  DataBean( '餐饮', style: const TextStyle( fontSize: 34.0, fontWeight: FontWeight.bold, ),),
  DataBean('西餐', children: [...dataDetail]),
 
];

final List<DataBean> dataDetail = [
  DataBean('意大利菜', style: const TextStyle(fontFamily: 'NotoSansSC', fontSize: 20.0, color: Colors.blue)),
  DataBean('法式料理'),
  DataBean('美式快餐'),
  DataBean('西班牙菜'),
];


//定义 一对一关系
List<PageInfo> myAppPages = [
  PageInfo(name: '餐饮', widget: const P1()),
  PageInfo(name: '意大利菜', widget: const P2()),
  PageInfo(name: '法式料理', widget: Page3()),
  PageInfo(name: '美式快餐', widget: const TestIndexStack()),
];
```

## 使用方法
```
home.dart

void initState() {
    super.initState();
    // Config.style = const TextStyle(fontSize: 20.0, color: Colors.blue);
    Config.init(myAppPages);
  }



  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      appBar: getAppBar(),
      body: TreeWidget(data: data),
    );
  }
  ```
