import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/app/constants.dart';
import 'package:wananadroid_flutter/base/base_page.dart';
import 'package:wananadroid_flutter/providers/login_response_provider.dart';
import 'package:wananadroid_flutter/utils/toast_utils.dart';
import 'login_register_view_model.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 ChangeNotifierProvider 提供 LoginViewModel 给子组件使用
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: const _LoginRegisterBody(),
    );
  }
}

class _LoginRegisterBody extends StatefulWidget {
  const _LoginRegisterBody({super.key});

  @override
  State<_LoginRegisterBody> createState() => _LoginRegisterBodyState();
}

class _LoginRegisterBodyState extends State<_LoginRegisterBody>
    with BasePage<_LoginRegisterBody> {
  @override
  void dispose() {
    // 页面销毁时释放 LoginViewModel 中的控制器资源，防止内存泄漏
    context.read<LoginViewModel>().disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 监听 LoginViewModel 的变化，刷新UI
    final vm = context.watch<LoginViewModel>();
    final isLogin = vm.isLogin; // 判断当前是登录模式还是注册模式

    return Scaffold(
      appBar: AppBar(
        title: const Text("登录/注册"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 用户名输入框，绑定到 ViewModel 的控制器
            TextField(
              controller: vm.usernameController,
              decoration: const InputDecoration(hintText: "用户名"),
            ),
            const SizedBox(height: 12),
            // 密码输入框，绑定到 ViewModel 的控制器，且密码隐藏
            TextField(
              obscureText: true,
              controller: vm.passwordController,
              decoration: const InputDecoration(hintText: "密码"),
            ),
            // 如果是注册模式，显示确认密码输入框
            if (!isLogin) ...[ /// ... 是 Dart 语言中的 扩展操作符（spread operator）。
              const SizedBox(height: 12),
              TextField(
                obscureText: true,
                controller: vm.repasswordController,
                decoration: const InputDecoration(hintText: "确认密码"),
              ),
            ],
            const SizedBox(height: 24),
            // 登录或注册按钮，点击触发提交事件
            ElevatedButton(
              onPressed: () => _onSubmit(context),
              child: Text(isLogin ? "登录" : "注册"),
            ),
            // 登录或注册按钮，点击触发提交事件
            TextButton(
              onPressed: () => vm.toggleMode(),
              child: Text(isLogin ? "没有账号？去注册" : "已有账号？去登录"),
            ),
          ],
        ),
      ),
    );
  }

  /// 点击提交按钮时的处理逻辑
  Future<void> _onSubmit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    // 关闭软键盘
    final vm = context.read<LoginViewModel>();

    final username = vm.usernameController.text.trim();
    final password = vm.passwordController.text.trim();
    final repassword = vm.repasswordController.text.trim();

    // 简单校验用户名和密码是否为空
    if (username.isEmpty || password.isEmpty) {
      ToastUtils.showToast(context, '请输入用户名和密码');
      return;
    }

    showLoadingDialog(); // 显示加载弹窗

    // 根据当前模式调用登录或注册接口
    final response = vm.isLogin
        ? await vm.login()
        : await (password == repassword
            ? vm.register()
            : Future.error("两次密码不一致"));

    dismissLoading(); // 关闭加载弹窗

    if (response.errorCode == 0) {

      ToastUtils.showToast(
          context, vm.isLogin ? "登录成功 ${response.data?.username}" : "注册成功，请登录");
      if (vm.isLogin) { // 登录成功
        /// 保存用户数据
        context.read<LoginResponseProvider>().login(response);
        /// 跳转至首页
        Navigator.pushNamed(context, RoutesConstants.home);
      }
    } else {
      ToastUtils.showToast(context, "失败: ${response.errorMsg}");
    }
  }
}
