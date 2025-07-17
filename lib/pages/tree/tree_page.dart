import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/app/constants.dart';
import 'package:wananadroid_flutter/base/base_page.dart';
import 'package:wananadroid_flutter/pages/tree/tree_page_view_model.dart';
import 'package:wananadroid_flutter/providers/tree_response_provider.dart';
import 'package:wananadroid_flutter/utils/toast_utils.dart';

// TreePage 是整个体系页面的入口（StatelessWidget）
// 提供 TreePageViewModel 给后代组件使用
class TreePage extends StatelessWidget {
  const TreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TreePageViewModel>(
      create: (_) => TreePageViewModel(), // 创建 ViewModel
      child: _TreePageBody(), // 子组件主体
    );
  }
}

// TreePage 的页面主体，使用 StatefulWidget 方便进行生命周期控制
class _TreePageBody extends StatefulWidget {
  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<_TreePageBody> with BasePage<_TreePageBody> {
  @override
  void initState() {
    super.initState();

    // 页面初始化后加载体系结构数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<TreePageViewModel>();
      vm.loadTree(); // 加载章节树数据
    });
  }

  @override
  Widget build(BuildContext context) {
    // 从 ViewModel 获取体系结构列表（chapterList）
    final chapterList = context.watch<TreePageViewModel>().chapterList;

    // 保存章节数据到全局 provider（用于子页面访问）
    context.read<TreeResponseProvider>().saveChapter(chapterList);

    // 记录当前展开的章节 id（防止切换状态时丢失展开状态）
    final Set<int> _expandedIds = {};

    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: chapterList.length, // 章节数量
        itemBuilder: (context, index) {
          final chapter = chapterList[index]; // 当前章节

          return Card(
            margin: const EdgeInsets.all(8), // 每个章节用卡片包裹
            child: ExpansionTile(
              title: Text(chapter.name), // 展示章节标题
              initiallyExpanded: _expandedIds.contains(chapter.id), // 判断是否默认展开
              onExpansionChanged: (isExpanded) {
                setState(() {
                  // 展开或折叠时记录当前章节 id 到集合中
                  if (isExpanded) {
                    _expandedIds.add(chapter.id);
                  } else {
                    _expandedIds.remove(chapter.id);
                  }
                });
              },
              // 显示子分类列表（每个子项是一个 ListTile）
              children: chapter.children.map((child) {
                return Container(
                  margin: EdgeInsets.only(left: 24), // 子项左缩进
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: Colors.grey[300]!, width: 2), // 左侧竖线
                    ),
                  ),
                  child: ListTile(
                    title: Text(child.name),
                    onTap: () => {
                      // 点击跳转到 TreePageChild 页面
                      Navigator.pushNamed(
                        context,
                        RoutesConstants.treeChild,
                        arguments: {
                          "chapterId": index, // 父分类索引
                          'childId': child.id, // 子分类 ID
                        },
                      ),
                      // 弹出 toast 显示点击信息
                      ToastUtils.showToast(
                          context, "点击子项: ${child.name} (ID: ${child.id})")
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
