import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/pages/navi/navi_page.dart';
import 'package:wananadroid_flutter/pages/personal/personal_page.dart';
import 'package:wananadroid_flutter/pages/project/project_page.dart';
import 'package:wananadroid_flutter/pages/top/top_page.dart';
import 'package:wananadroid_flutter/pages/tree/tree_page.dart';

import '../../providers/login_response_provider.dart';
import '../../widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 当前底部导航选中的索引
  int _currentIndex = 0;

  // 用于缓存页面实例，避免每次切换都重新创建
  List<Widget?> _pages = List<Widget?>.filled(5, null, growable: false);

  static const List<String> _labels = [
    "首页",
    "体系",
    "导航",
    "项目",
    "我的",
  ];

  // 根据索引构建对应页面
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const TopPage(); // 首页页面
      case 1:
        return const TreePage(); // 体系页面
      case 2:
        return const NaviPage(); // 导航页面
      case 3:
        return const ProjectPage(); // 项目页面
      case 4:
        return const PersonalPage(); // 个人中心页面
      default:
        return const SizedBox(); // 默认空白页面
    }
  }

  @override
  void initState() {
    super.initState();

    // 读取登录状态Provider，获取当前用户信息
    final loginProvider = context.read<LoginResponseProvider>();
    final user = loginProvider.user;
    if (user != null) {
      // 打印当前用户用户名，方便调试
      print('首页获取用户信息: ${user.data?.username}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final showSearchIcon = _currentIndex != 4; // 除了“我的”页，其他页显示搜索图标

    return Scaffold(
      appBar: CustomAppBar(
        title: _labels[_currentIndex],
        showSearchIcon: showSearchIcon,
      ),
      // 使用 IndexedStack 保持所有页面状态，同时显示当前选中的页面
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(_pages.length, (index) {
          // 如果缓存中该页面为空，则创建并缓存
          if (_pages[index] == null) {
            _pages[index] = _buildPage(index);
          }
          // 返回缓存的页面实例
          return _pages[index]!;
        }),
      ),
      // 底部导航栏，切换时更新当前索引并刷新界面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // 当前选中索引
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 更新选中索引，触发重建
          });
        },
        selectedItemColor: Colors.blue,
        // 选中项颜色
        unselectedItemColor: Colors.grey,
        // 未选中项颜色
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: "体系"),
          BottomNavigationBarItem(icon: Icon(Icons.navigation), label: "导航"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "项目"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
      backgroundColor: Colors.white60, // 整体背景色
    );
  }
}
