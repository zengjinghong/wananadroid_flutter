import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/pages/personal/personal_page_view_model.dart';
import 'package:wananadroid_flutter/utils/toast_utils.dart';

import '../../app/constants.dart';
import '../../providers/login_response_provider.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonalPageViewModel>(
      create: (_) => PersonalPageViewModel(),
      child: _PersonalPageBody(),
    );
  }
}

class _PersonalPageBody extends StatefulWidget {
  const _PersonalPageBody();

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<_PersonalPageBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          // 头像 + 用户名
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/npc_face.png'),
                ),
                SizedBox(height: 12),
                Text(
                  "用户名: ${context.read<LoginResponseProvider>().user?.data?.nickname}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          // 列表项
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text('我的收藏'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // 跳转到收藏页面
                    Navigator.pushNamed(context, RoutesConstants.collectList);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('关于我'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ToastUtils.showToast(context, "记录学习的一个打工牛马!");
                  },
                ),
              ],
            ),
          ),
          // 退出登录按钮
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('退出登录'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // 执行退出逻辑
                _onLogoutClick();
              },
            ),
          ),
        ],
      ),
    );
  }

  _onLogoutClick() async {
    bool isSuccess = await (context.read<PersonalPageViewModel>().logout());

    if (isSuccess) {
      ToastUtils.showToast(context, "退出登录成功!");
      Navigator.pushNamed(context, RoutesConstants.login);
    }
  }
}
