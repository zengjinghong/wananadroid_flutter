import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/base/base_page.dart';
import 'package:wananadroid_flutter/models/articles_response.dart';
import 'package:wananadroid_flutter/pages/top/top_page_view_model.dart';
import 'package:wananadroid_flutter/utils/toast_utils.dart';
import 'package:wananadroid_flutter/widgets/vp_banner.dart';

import '../../widgets/article_item.dart';

// 顶部页面，使用 StatelessWidget 包装 ChangeNotifierProvider，提供 TopPageViewModel
class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TopPageViewModel>(
      // 创建并提供 TopPageViewModel 实例给子组件使用
      create: (_) => TopPageViewModel(),
      child: _TopPageBody(),
    );
  }
}

// 页面主体，负责显示 Banner 和文章列表，管理滚动与加载状态
class _TopPageBody extends StatefulWidget {
  @override
  State<_TopPageBody> createState() => _TopPageBodyState();
}

class _TopPageBodyState extends State<_TopPageBody>
    with BasePage<_TopPageBody> {
  late final ScrollController _scrollController; // 滚动控制器，用于监听滚动事件
  int _currentPage = 0; // 当前文章页码
  bool _isLoadingMore = false; // 是否正在加载更多

  @override
  void initState() {
    super.initState();

    // 初始化滚动控制器并监听滚动事件
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // 页面首次渲染完成后调用接口加载 Banner 和文章第一页数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<TopPageViewModel>();
      vm.loadBanner();
      vm.loadArticles(0);
    });
  }

  @override
  void dispose() {
    // 释放滚动控制器资源
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 监听 ViewModel 中的 Banner 和文章列表变化
    final bannerList = context.watch<TopPageViewModel>().bannerList;
    final articleList = context.watch<TopPageViewModel>().articleList;

    return Container(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Banner 区域，使用 SliverToBoxAdapter 包装普通 Widget
          SliverToBoxAdapter(
            child: VpBanner(
                radius: 10,
                margin: 3,
                height: 300,
                imageList: bannerList.map((e) => e.imagePath).toList(),
                indicatorType: IndicatorType.circle,
                bannerClick: (position) {
                  ToastUtils.showToast(
                      context, '点击了: ${bannerList[position].title}');
                }),
          ),

          SliverList(
            // 使用 SliverChildBuilderDelegate 动态构建列表项
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // 获取对应索引的文章数据
                final article = articleList[index];
                return GestureDetector(
                  // 点击整条文章项的回调（这里留空，可自定义）
                  onTap: () {},
                  child: ArticleItemLayout(
                    article: article,
                    // 点击收藏按钮时调用的回调，触发收藏/取消收藏逻辑
                    onCollectTap: () {
                      _onCollectClick(article);
                    },
                  ),
                );
              },
              // 列表项数量
              childCount: articleList.length,
            ),
          ),
        ],
      ),
    );
  }

  // 文章收藏/取消收藏事件处理
  _onCollectClick(Article article) async {
    bool collected = article.collect;
    // 根据当前收藏状态调用收藏或取消收藏接口
    bool isSuccess = await (!collected
        ? context.read<TopPageViewModel>().collect(article.id)
        : context.read<TopPageViewModel>().uncollect(article.id));
    if (isSuccess) {
      ToastUtils.showToast(context, collected ? "取消收藏!" : "收藏成功!");
      article.collect = !article.collect; // 更新收藏状态
    } else {
      ToastUtils.showToast(context, collected ? "取消收藏失败 -- " : "收藏失败 -- ");
    }
  }

  // 滚动监听，判断是否需要加载更多数据
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // 当滚动到接近底部且非加载状态，触发加载更多
    if (currentScroll >= maxScroll - 50 && !_isLoadingMore) {
      _loadMore();
    }
  }

  /// 加载更多文章数据
  Future<void> _loadMore() async {
    _isLoadingMore = true;
    _currentPage++; // 页码加1
    await context.read<TopPageViewModel>().loadArticles(_currentPage);
    _isLoadingMore = false;
  }
}
