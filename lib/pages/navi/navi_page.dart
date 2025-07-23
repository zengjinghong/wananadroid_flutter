import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/pages/navi/navi_page_view_model.dart';

import '../../app/constants.dart';
import '../../base/base_page.dart';

class NaviPage extends StatelessWidget {
  const NaviPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NaviPageViewModel>(
      create: (_) => NaviPageViewModel(), // 创建 ViewModel
      child: _NaviPageBody(), // 子组件主体
    );
  }
}

class _NaviPageBody extends StatefulWidget {
  @override
  _NaviPageState createState() => _NaviPageState();
}

class _NaviPageState extends State<_NaviPageBody> with BasePage<_NaviPageBody> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<NaviPageViewModel>();
      vm.loadNavi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final naviDataList = context.watch<NaviPageViewModel>().naviData;


    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 左侧导航栏
          Container(
            width: 100,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: naviDataList.length,
              itemBuilder: (_, index) {
                final selected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: selected ? Colors.white : Colors.transparent,
                    child: Center(
                      child: Text(
                        naviDataList[index].name,
                        style: TextStyle(
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.normal,
                          color: selected ? Colors.blue : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// 右侧内容（瀑布流）
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: naviDataList[selectedIndex].articles.length,
                itemBuilder: (context, index) {
                  final article = naviDataList[selectedIndex].articles[index];

                  return InkWell(
                    onTap: () {
                      print('获取到导航数据: ${article.toJson()}');
                      Navigator.pushNamed(
                          context, RoutesConstants.linkDetail,
                          arguments: {
                            'link': article.link,
                            'title': article.title,
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[100 * ((index % 8) + 1)],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
