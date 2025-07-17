import 'package:flutter/cupertino.dart';
import '../../models/chapter_response.dart';

// TreeResponseProvider 是一个全局数据提供器，用于保存“体系结构（章节）”列表
// 它继承自 ChangeNotifier，可通过 Provider 通知 UI 更新
class TreeResponseProvider extends ChangeNotifier {
  // 私有成员变量，存储体系结构数据（章节列表）
  List<Chapter>? _chapterList;

  // 对外暴露只读属性，用于获取章节列表
  List<Chapter>? get chapterList => _chapterList;

  // 保存章节数据并通知监听者（如 UI 刷新）
  void saveChapter(List<Chapter> chapterList) {
    _chapterList = chapterList;
    notifyListeners(); // 通知依赖此数据的组件重新构建
  }

  // 登出时清空章节数据并通知监听者
  void logOut() {
    _chapterList = null;
    notifyListeners(); // 通知 UI 数据已清空（可用于重定向或重置）
  }
}
