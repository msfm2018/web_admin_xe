#### 应用截图
<p align="center">
  <img src="https://github.com/msfm2018/simple_tree/blob/0.0.5/index.png?raw=true">
</p>





## 数据定义

 import 'package:simple_tree/simple_tree.dart';

```数据定义
参考demo
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
