import 'package:flutter/material.dart';
import 'package:web_admin/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用深蓝色背景，模拟图片中的背景氛围
      backgroundColor: const Color(0xFF081642),
      body: Center(
        child: Container(
          width: 900, // 限制整体宽度
          height: 500,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)],
          ),
          child: Row(
            children: [
              // --- 左侧蓝色部分 ---
              Expanded(
                flex: 11, // 根据图片比例微调
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2B7CFF), Color(0xFF0046CC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    // 这里可以放你的 sw.6e51dfbf.png 图片作为背景
                    image: DecorationImage(
                      image: AssetImage('assets/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CRMEB",
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "自己的，才是最好的\n每个企业都应该有属于自己的CRMEB系统",
                        style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),

              // --- 右侧白色表单部分 ---
              Expanded(
                flex: 9,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120, // 必须设置高度，确保是一个正方形
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60), // 圆角半径等于宽度的一半，就是一个圆
                          child: Image.network(
                            'https://avatars.githubusercontent.com/u/13409222?s=80&v=4',
                            fit: BoxFit.cover, // 确保图片完全填充并被裁剪
                          ),
                        ),
                      ),
                      const Text(
                        "CRMEB系统",
                        style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 40),

                      // 账号输入框
                      TextField(
                        decoration: InputDecoration(
                          hintText: "demo",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 密码输入框
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "密码",
                          suffixIcon: const Icon(Icons.visibility_outlined, size: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 登录按钮
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Auth.login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1890FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text("登 录", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
