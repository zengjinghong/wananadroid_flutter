import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/models/login_register_response.dart';
import 'package:wananadroid_flutter/services/api_service.dart';

class LoginViewModel extends ChangeNotifier {
  // 用于用户名输入框的控制器，管理文本内容
  final usernameController = TextEditingController();
  // 用于密码输入框的控制器，管理文本内容
  final passwordController = TextEditingController();
  // 用于确认密码输入框的控制器，管理文本内容（注册模式时使用）
  final repasswordController = TextEditingController();

  // 当前是否处于登录模式，true表示登录，false表示注册
  bool _isLogin = true;
  bool get isLogin => _isLogin;

  // 当前是否处于加载状态（显示loading）
  bool _loading = false;
  bool get isLoading => _loading;

  // 切换登录/注册模式，切换时通知监听者刷新UI
  void toggleMode() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  // 调用登录接口，发送用户名和密码，等待响应并转换为模型对象
  Future<LoginRegisterResponse> login() async {
    _setLoading(true); // 设置loading状态为true
    final response = await ApiService.login(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );
    _setLoading(false); // 加载完成，设置loading状态为false
    return LoginRegisterResponse.fromJson(response);
  }

  // 调用注册接口，发送用户名、密码和确认密码，等待响应并转换为模型对象
  Future<LoginRegisterResponse> register() async {
    _setLoading(true); // 设置loading状态为true
    final response = await ApiService.register(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
      repassword: repasswordController.text.trim(),
    );
    _setLoading(false); // 加载完成，设置loading状态为false
    return LoginRegisterResponse.fromJson(response);
  }

  // 私有方法，更新加载状态并通知监听者刷新UI
  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // 释放文本控制器资源，防止内存泄漏，建议在页面销毁时调用
  void disposeControllers() {
    usernameController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
  }
}
