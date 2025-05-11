#### 应用截图
<p align="center">
  <img src="https://github.com/msfm2018/simple_tree/blob/0.0.5/index.png?raw=true">
</p>





## 数据定义

 import 'package:simple_tree/simple_tree.dart';

```数据定义

final List<TreeNode> data = <TreeNode>[
  //可定义可不定义样式
  TreeNode( '餐饮', style: const TextStyle( fontSize: 34.0, fontWeight: FontWeight.bold, ),),
  TreeNode('西餐', children: [...dataDetail]), 
];

final List<TreeNode> dataDetail = [
  TreeNode('意大利菜', style: const TextStyle(fontFamily: 'NotoSansSC', fontSize: 20.0, color: Colors.blue)),
  TreeNode('法式料理'),
  TreeNode('美式快餐'),
  TreeNode('西班牙菜'),
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
    //可定义可不定义样式
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
