# Changelog
## 1.1.1
* 🛠 Fixes: Resolved lint warnings and deprecated API usage (withOpacity to withValues).
* 📏 Naming: Normalized file naming to follow Dart's lower_case_with_underscores convention.
* 📝 Docs: Continued improvement of API documentation.

## 1.1.0

* **文档与规范大升级**: 
    * 补全了全量 API 文档注释，核心类库文档覆盖率达到 100%。
    * 优化了包结构，符合 Pub.dev 官方发布最佳实践。
* **数据模型优化**:
    * 增强了 `TreeNode.fromJson` 的鲁棒性。
    * 修复了图标解析逻辑，支持通过字符串名称映射 `IconData`。
* **视觉体验**:
    * 优化了侧边栏（Sidebar）的响应式宽度计算逻辑（使用 clamp 策略）。
    * 增加了多标签页（Tabs）的选中与未选中视觉区分。

## 1.0.1

* **自动化工具**: 引入 `gen_route.dart` 脚本，支持根据目录结构自动生成路由配置。
* **代码清理**: 移除了冗余的依赖包，减小了库的体积。

## 1.0.0

* **核心架构升级**: 
    * 支持通过标准的 JSON 格式动态生成整棵功能树。
    * 引入 `rxflare` 状态管理，实现多标签页切换的局部刷新。
    * 增加了页面缓存机制，切换标签不再丢失页面状态（如滚动位置）。

## 0.1.1

* **UI 增强**: 修复了工具栏（Toolbar）在未选中状态下的背景色显示问题。

## 0.1.0

* **API 规范化**: 统一了参数命名规范，为关键构造函数增加了前置必填项检查。

## 0.0.8

* **参数优化**: 优化了内部状态传递逻辑，增强了参数的类型约束。

## 0.0.6

* **布局修正**: 
    * 修复了树形结构嵌套缩进计算错误的 Bug。
    * 修正了数据节点（TreeNode）的命名冲突。

## 0.0.5

* **逻辑修复**: 修正了树节点选中态的索引判定逻辑。

## 0.0.2

* **性能优化**: 删除了不必要的第三方包引用，优化包体积。

## 0.0.1

* **初始版本发布**: 实现基础的树形菜单与响应式右侧内容区布局。