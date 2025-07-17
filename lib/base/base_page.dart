import 'package:flutter/material.dart';

/// BasePage 是一个 Mixin，可用于所有继承 State 的类（例如 StatefulWidget 页面）
mixin BasePage<T extends StatefulWidget> on State<T> {
  /// 是否正在显示loading弹窗
  bool showingLoading = false;

  /// 显示加载中弹窗（如果已经显示过了，就不重复显示）
  Future<void> showLoadingDialog() async {
    if (showingLoading) {
      return;
    }

    /// 清除焦点，隐藏键盘
    FocusManager.instance.primaryFocus?.unfocus();

    showingLoading = true;
    await showDialog<int>(
        context: context,
        barrierDismissible: true, // 允许点击背景关闭弹窗
        builder: (context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min, // 内容高度根据子内容压缩
              children: [
                CircularProgressIndicator(), // 加载进度条
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text("请稍等...."), // 加载提示文字
                )
              ],
            ),
          );
        });
    showingLoading = false; // 弹窗关闭后，恢复状态
  }

  dismissLoading() {
    if (showingLoading) {

      /// 清除焦点，隐藏键盘
      FocusManager.instance.primaryFocus?.unfocus();

      showingLoading = false;
      Navigator.of(context).pop(); // 关闭当前弹窗
    }
  }
}

/// 用于显示加载失败，并提供“点击重试”的组件
class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, required this.onTapRetry});
  /// 点击“重试”的回调函数（由外部传入）
  final void Function() onTapRetry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque, // 允许点击透明区域
        onTap: onTapRetry, // 用户点击整个区域触发重试
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 居中显示
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Icon(Icons.refresh)), // 刷新图标
              Text("加载失败，点击重试")  // 文本提示
            ],
          ),
        ));
  }
}

/// 用于显示“无数据”的提示组件
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 内容垂直居中
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 16), child: Icon(Icons.book)),
          Text("无数据")
        ],
      ),
    );
  }
}
