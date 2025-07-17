import 'package:flutter/material.dart';

import '../models/login_register_response.dart';

// 登录信息提供器：用于管理用户登录状态与用户信息
// 通过 ChangeNotifier 实现数据变更通知（供 Provider 使用）
class LoginResponseProvider extends ChangeNotifier {
  // 私有用户对象，保存当前登录的用户信息
  LoginRegisterResponse? _user;

  // 对外提供只读用户信息访问
  LoginRegisterResponse? get user => _user;

  // 是否已登录（根据 _user 是否为 null 判断）
  bool get isLoggedIn => _user != null;

  // 登录方法：设置当前用户信息并通知监听者（通常用于刷新 UI）
  void login(LoginRegisterResponse user) {
    _user = user;
    notifyListeners(); // 通知所有依赖此 Provider 的组件进行更新
  }

  // 登出方法：清空用户信息并通知监听者
  void logout() {
    _user = null;
    notifyListeners(); // 通知 UI 登录状态变化
  }
}
