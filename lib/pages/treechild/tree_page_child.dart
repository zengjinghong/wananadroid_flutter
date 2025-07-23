import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/pages/treechild/tree_page_child_view_model.dart';

import '../../app/constants.dart';
import '../../base/base_page.dart';
import '../../models/articles_response.dart';
import '../../providers/tree_response_provider.dart';
import '../../utils/toast_utils.dart';
import '../../widgets/article_item.dart';

// 子体系页面（对应某个分类下的子分类）
// 使用 Provider 提供 ViewModel（TreePageChildViewModel）给内部组件使用
class TreePageChild extends StatelessWidget {
  final int chapterId; // 父分类索引（在全局章节列表中的位置）
  final int childId; // 子分类 ID（真正用于加载文章）

  const TreePageChild({
    Key? key,
    required this.chapterId,
    required this.childId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 向下提供 ViewModel，并将 chapterId 和 childId 传入子组件
    return ChangeNotifierProvider<TreePageChildViewModel>(
      create: (_) => TreePageChildViewModel(),
      child: _TreePageChildBody(
        chapterId: chapterId,
        childId: childId,
      ),
    );
  }
}

// 页面主体（StatefulWidget）：接收父分类索引和子分类 ID，用于展示 Tab + 文章列表
class _TreePageChildBody extends StatefulWidget {
  final int chapterId;
  final int childId;

  const _TreePageChildBody({
    super.key,
    required this.chapterId,
    required this.childId,
  });

  @override
  _TreePageChildState createState() => _TreePageChildState();
}

class _TreePageChildState extends State<_TreePageChildBody>
    with BasePage<_TreePageChildBody>, SingleTickerProviderStateMixin {
  // 控制 TabBar 与 TabBarView 联动的控制器
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // 从全局 Provider 获取章节数据
    final chapterList = context.read<TreeResponseProvider>().chapterList!;
    final children = chapterList[widget.chapterId].children;

    // 查找当前 childId 在 children 中的 index，作为默认选中的 Tab
    final initialIndex = children.indexWhere((c) => c.id == widget.childId);

    // 初始化 TabController
    _tabController = TabController(
      length: children.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    // 页面绘制后，立即加载默认选中的 Tab 对应的文章列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadArticlesAtIndex(_tabController.index);
    });

    // 监听 tab 切换事件
    _tabController.addListener(() {
      // index 发生变化且切换完成时触发
      if (_tabController.indexIsChanging == false) {
        _loadArticlesAtIndex(_tabController.index);
      }
    });
  }

  // 加载某个 tab 对应子分类的文章列表
  void _loadArticlesAtIndex(int index) {
    final chapterList = context.read<TreeResponseProvider>().chapterList!;
    final childChapter = chapterList[widget.chapterId].children[index];

    // 调用 ViewModel 加载指定分类文章
    context.read<TreePageChildViewModel>().loadArticles(0, childChapter.id);
  }

  @override
  void dispose() {
    _tabController.dispose(); // 销毁 TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chapterList = context.read<TreeResponseProvider>().chapterList!;
    final children = chapterList[widget.chapterId].children;

    return DefaultTabController(
      length: children.length,
      child: Scaffold(
        appBar: AppBar(
          // 标题为当前父分类名称
          title: Text(chapterList[widget.chapterId].name),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: children.map((c) => Tab(text: c.name)).toList(), // 子分类名作为 Tab
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(children.length, (index) {
            return Consumer<TreePageChildViewModel>(
              builder: (_, vm, __) {
                final articles = vm.articleList;

                // 加载中或数据为空时显示加载指示器
                if (articles.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 显示文章列表
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (_, i) {
                    return ArticleItemLayout(
                      article: articles[i], // 单篇文章数据
                      onCollectTap: () {
                        _onCollectClick(articles[i]); // 收藏按钮点击事件
                      },
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesConstants.linkDetail,
                            arguments: {
                              'link': articles[i].link,
                              'title': articles[i].title,
                            });
                      },
                      showCollectBtn: true,
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }

  // 处理文章的收藏/取消收藏点击事件
  _onCollectClick(Article article) async {
    bool collected = article.collect;

    // 根据当前状态选择调用收藏或取消收藏接口
    bool isSuccess = await (!collected
        ? context.read<TreePageChildViewModel>().collect(article.id)
        : context.read<TreePageChildViewModel>().uncollect(article.id));

    if (isSuccess) {
      // 收藏/取消成功：提示 + 刷新 UI
      ToastUtils.showToast(context, collected ? "取消收藏!" : "收藏成功!");
      article.collect = !article.collect;
    } else {
      // 收藏/取消失败：提示
      ToastUtils.showToast(context, collected ? "取消收藏失败 -- " : "收藏失败 -- ");
    }
  }
}
