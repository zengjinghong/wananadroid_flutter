import 'package:flutter/material.dart';
///  工具类：用于显示原生风格的 Toast 弹窗
class ToastUtils {
  // 当前显示的 OverlayEntry (移除时引用）
  static OverlayEntry? _overlayEntry;
  // 标记是否正在显示 Toast ，避免重复弹出
  static bool _isShowing = false;

  /// 显示 Toast 弹窗
  /// [context]: 上下文弹窗
  /// [message]: 要显示的提示文字
  /// [duration]: 持续显示的时间（默认为 2 秒）
  static void showToast(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    // 如果已经有 Toast 正在显示， 直接返回
    if (_isShowing) return;

    _isShowing = true;

    // 创建 OverlayEntry（悬浮层）
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.5, // 离底部距离
        left: MediaQuery.of(context).size.width * 0.2, // 离左边距离
        width: MediaQuery.of(context).size.width * 0.6, // 离右边距离
        child: _ToastWidget(message: message), // 自定义 Toast 样式
      ),
    );

    // 插入到 Overlay 中显示
    Overlay.of(context).insert(_overlayEntry!);

    // 延时关闭 Toast
    Future.delayed(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowing = false;
    });
  }
}
/// 私有 Toast 组件，用于实现带动画的样式
class _ToastWidget extends StatefulWidget {
  final String message;

  const _ToastWidget({Key? key, required this.message}) : super(key: key);

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  // 控制透明度动画的控制器
  late AnimationController _controller;
  // 透明度动画
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // 动画时长 300ms
      vsync: this,
    );
    // 使用 CurvedAnimation 包裹，使用 easeInOut 曲线
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    // 播放动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation, // 使用透明度动画包裹整个 Toast
      child: Material(
        color: Colors.transparent, // 背景透明
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // 内边距
          margin: const EdgeInsets.symmetric(horizontal: 16), // 外边距
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8), // 半透明黑背景
            borderRadius: BorderRadius.circular(20), // 圆角
          ),
          child: Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 释放动画资源
    _controller.dispose();
    super.dispose();
  }
}
