
# 历史上最简单的 生成树

<p align="center">
  <img src="https://github.com/msfm2018/simple_tree/blob/1.0.0/index.png?raw=true">
    <img src="https://github.com/msfm2018/simple_tree/blob/1.0.0/1.png?raw=true">
</p>





## 数据定义

 import 'package:simple_tree/simple_tree.dart';



# 方法一  好处： 不用json中page字段 与类名一一对应 坏处：手动改两个文件
## 手写路由表  两步

## 一、 定义menu.json文件
```
[
  {
    "index": 1,
    "name": "首页",
    "icon": "home"
  },
  {
    "index": 2,
    "name": "系统配置",
    "children": [
      { "index": 21, "name": "基础设置", "page": "a1" }
    ]
  },
 ]
```

## 二、手动改写 route_mapper.dart 

 ```
static final Map<String, Widget Function()> routes = {
    "a1": () => const AdminDashboardPage(),
  };

  ```


# 方法二   好处：只改写 json文件  坏处：json中page与类名 一一对应
## 自动生成路由表
 ```
  运行  dart gen_route.dart   自动生成 route_mapper.dart文件

       条件：
         json中 page字段 和view下文件 类名一致

       例如：p_1.dart

         class P1 extends StatelessWidget {
              const P1({super.key});
              @override
              Widget build(BuildContext context) {
                return Text("P1");
              }
            }
      
       json 文件 
          {
            "index": 1,
            "name": "首页",
            "page": "P1",  ----> 这里要一致
            "icon": "home"
          },
      
  ```
