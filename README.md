
# 历史上最简单的 生成树

<p align="center">
  <img src="https://github.com/msfm2018/simple_tree/blob/1.0.0/index.png?raw=true">
    <img src="https://github.com/msfm2018/simple_tree/blob/1.0.0/1.png?raw=true">
</p>





## 数据定义

 import 'package:simple_tree/simple_tree.dart';



## 手写路由表 使用方法 两步

# 第一、assets目录下 随意 定义menu.json文件
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
      { "index": 21, "name": "基础设置", "page": "a1","icon":"settings" }
    ]
  },
  {
    "index": 3,
    "name": "权限管理",
    "children": [
      { "index": 31, "name": "用户管理", "page": "a2" ,"icon":"home"},
      { "index": 32, "name": "角色管理", "page": "a3" }
    ]
  },
  {
    "index": 4,
    "name": "数字化大屏",
    "page": "AdminDashboardPage"
  },
  {
    "index": 5,
    "name": "外链测试",
    "children": []
  },

]
```

# 第二：定义路由表route_mapper.dart  json中的  "page"字段 与page文件对应即可

 ``` static final Map<String, Widget Function()> routes = {
    "a1": () => const AdminDashboardPage(),
    "a2": () => const   DashboardChart(),
    "a3": () =>  AdminDashboardPage(),
  };

  ```


# 自动生成路由表 route_mapper.dart  根据view下的文件自动生成路由表
 ```
  根目录 下运行  dart gen_route.dart 
                 自动生成 route_mapper.dart文件

       条件：
       1. assets目录下 menu.json文件 中 page字段要和view目录下的文件的类名一致

       例如 class P1 extends StatelessWidget {
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
            "page": "P1",  //这里要一致
            "icon": "home"
          },
      
  ```