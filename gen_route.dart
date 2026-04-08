import 'dart:io';

void main() async {
  // 1. 定义路径
  final viewDir = Directory('lib/view');
  final outputFile = File('lib/route_mapper.dart');

  if (!await viewDir.exists()) {
    // print('错误: 找不到 lib/view 目录');
    return;
  }

  List<String> imports = [];
  Map<String, String> routeEntries = {};

  // 2. 遍历 view 文件夹下的所有 .dart 文件
  final files = viewDir.listSync(recursive: true).whereType<File>();

  for (var file in files) {
    if (!file.path.endsWith('.dart')) continue;

    final content = await file.readAsString();
    // 使用正则匹配类名 (假设你的类名是 class XxxPage ...)
    final match = RegExp(r'class\s+(\w+)\s+extends').firstMatch(content);

    if (match != null) {
      final className = match.group(1)!;
      // 生成相对于 lib 的引用路径
      final relativePath = file.path.replaceFirst('lib/', '');
      
      imports.add("import '$relativePath';");
      // 建立 JSON 中的 page 字符串与类名的映射
      routeEntries[className] = "() => const $className()";
    }
  }

  // 3. 生成代码字符串
  final buffer = StringBuffer();
  buffer.writeln("// GENERATED CODE - DO NOT MODIFY BY HAND");
  buffer.writeln("import 'package:flutter/material.dart';");
  for (var imp in imports) {
    buffer.writeln(imp);
  }

  buffer.writeln("\nclass RouteMapper {");
  buffer.writeln("  static final Map<String, Widget Function()> routes = {");
  
  routeEntries.forEach((key, value) {
    buffer.writeln("    '$key': $value,");
  });
  
  buffer.writeln("  };");
  buffer.writeln("\n  static Widget? getPage(String? key) {");
  buffer.writeln("    final builder = routes[key];");
  buffer.writeln("    return builder?.call();");
  buffer.writeln("  }");
  buffer.writeln("}");

  // 4. 写入文件
  await outputFile.writeAsString(buffer.toString());
  // print('✅ 路由映射表已自动生成: ${outputFile.path}');
}