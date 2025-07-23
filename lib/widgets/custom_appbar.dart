import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/app/constants.dart';
import 'package:wananadroid_flutter/pages/navi/navi_page.dart';

// 自定义 AppBar 组件，实现带标题和可选搜索图标的 AppBar
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title; // 标题文字
  final bool showSearchIcon; // 是否显示右侧的搜索图标

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showSearchIcon = true, // 默认显示搜索图标
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  // 指定 AppBar 的高度
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 设置 AppBar 标题
      title: Text(widget.title),

      // 关闭默认的返回按钮（返回箭头），适用于首页等不需要返回的场景
      automaticallyImplyLeading: false,

      // 设置 AppBar 背景颜色
      backgroundColor: Colors.blue,

      // 自定义标题文字样式
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),

      // 如果需要显示搜索图标，则构建 IconButton；否则不显示 actions
      actions: widget.showSearchIcon
          ? [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // 这里是搜索按钮点击后的回调，可根据需要添加跳转或弹窗逻辑
                  Navigator.pushNamed(context, RoutesConstants.search);
                },
              )
            ]
          : null,
    );
  }
}
