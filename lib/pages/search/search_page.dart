import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/base/base_page.dart';
import 'package:wananadroid_flutter/pages/search/search_page_view_model.dart';

import '../../app/constants.dart';
import '../../models/articles_response.dart';
import '../../utils/toast_utils.dart';
import '../../widgets/article_item.dart';

// 搜索页面外壳组件（Stateless），用于提供 ViewModel 注入
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 Provider 注入 SearchPageViewModel
    return ChangeNotifierProvider<SearchPageViewModel>(
      create: (_) => SearchPageViewModel(),
      child: _SearchPageBody(), // 主页面主体
    );
  }
}

// 搜索页面的具体 UI 和交互逻辑
class _SearchPageBody extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPageBody>
    with BasePage<_SearchPageBody> {
  final ScrollController _scrollController = ScrollController(); // 控制列表滚动
  int _page = 0;               // 当前分页页码
  bool _isLoadingMore = false; // 是否正在加载更多数据，避免重复加载

  @override
  void initState() {
    // 注册滑动监听器，用于实现滑动到底部自动加载更多
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // 页面销毁时释放滚动控制器资源
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取 ViewModel 实例，监听数据变化以触发重建
    final vm = context.watch<SearchPageViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('搜索界面')),
      body: Column(
        children: [
          // 搜索栏区域
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // 输入框
                Expanded(
                  child: TextField(
                    controller: vm.userSearchController, // 输入控制器
                    decoration: const InputDecoration(
                      hintText: '请输入搜索内容',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // 搜索按钮
                ElevatedButton(
                  onPressed: () {
                    vm.search(_page); // 点击搜索，调用 ViewModel 的搜索方法
                  },
                  child: const Text('搜索'),
                ),
              ],
            ),
          ),
          // 搜索结果列表
          Expanded(
            child: ListView.separated(
              controller: _scrollController, // 绑定滚动控制器
              itemCount: vm.articleList.length, // 数据项数量
              separatorBuilder: (_, __) => const Divider(height: 1), // 分隔线
              itemBuilder: (_, i) {
                return ArticleItemLayout(
                  article: vm.articleList[i], // 单篇文章数据
                  onCollectTap: () {
                    _onCollectClick(vm.articleList[i]); // 收藏按钮点击事件
                  },
                  onTap: () {
                    // 点击跳转详情页
                    Navigator.pushNamed(context, RoutesConstants.linkDetail,
                        arguments: {
                          'link': vm.articleList[i].link,
                          'title': vm.articleList[i].title,
                        });
                  },
                  showCollectBtn: true, // 是否显示收藏按钮
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // 处理文章的收藏/取消收藏点击事件
  _onCollectClick(Article article) async {
    bool collected = article.collect;

    // 根据当前收藏状态调用不同接口
    bool isSuccess = await (!collected
        ? context.read<SearchPageViewModel>().collect(article.id) // 收藏
        : context.read<SearchPageViewModel>().uncollect(article.id)); // 取消收藏

    if (isSuccess) {
      // 接口调用成功，更新状态并提示用户
      ToastUtils.showToast(context, collected ? "取消收藏!" : "收藏成功!");
      article.collect = !article.collect; // 本地切换收藏状态
    } else {
      // 接口调用失败，弹出提示
      ToastUtils.showToast(context, collected ? "取消收藏失败 -- " : "收藏失败 -- ");
    }
  }

  // 滚动监听器，用于检测是否接近底部
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent; // 最大滚动位置
    final currentScroll = _scrollController.position.pixels;      // 当前滚动位置

    // 若已接近底部，且未处于加载中状态，则加载更多数据
    if (currentScroll >= maxScroll - 50 && !_isLoadingMore) {
      _loadMore();
    }
  }

  /// 加载更多文章数据（分页）
  Future<void> _loadMore() async {
    _isLoadingMore = true; // 标记为加载中
    _page++; // 页码 +1
    await context.read<SearchPageViewModel>().search(_page); // 调用搜索
    _isLoadingMore = false; // 重置加载状态
  }
}
