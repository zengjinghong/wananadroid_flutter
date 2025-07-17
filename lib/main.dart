import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/app/constants.dart';
import 'package:wananadroid_flutter/providers/login_response_provider.dart';
import 'package:wananadroid_flutter/providers/tree_response_provider.dart';

import 'app/routes.dart';

void main() {
  // 保证 Flutter 与平台（Android/iOS）进行绑定初始化，确保调用平台通道、使用插件前初始化完毕
  WidgetsFlutterBinding.ensureInitialized();

  // 隐藏系统状态栏和底部导航栏（全屏模式）
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // 启动应用，并注册全局的 Provider 状态管理
  runApp(
    MultiProvider(
      providers: [
        // 注册 LoginResponseProvider 到全局，可以在整个应用中访问该登录状态
        ChangeNotifierProvider(create: (_) => LoginResponseProvider()),
        ChangeNotifierProvider(create: (_) => TreeResponseProvider()),
      ],
      child: MyApp(), // 根组件
    ),
  );
}

/// 应用根组件
class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓 Flutter 版', // 应用标题
      debugShowCheckedModeBanner: false, // 关闭右上角 Debug 标签
      theme: ThemeData(
        primarySwatch: Colors.blue, // 设置主题颜色为蓝色
      ),
      initialRoute: RoutesConstants.login, // 应用启动时的初始路由（跳转登录页）
      routes: AppRoutes.routes, // 注册路由表，定义页面跳转路径
    );
  }
}
