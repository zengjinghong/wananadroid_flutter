import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/app/constants.dart';
import 'package:wananadroid_flutter/utils/toast_utils.dart';

import '../../widgets/collect_item.dart';
import 'collect_list_page_view_model.dart';

// 收藏列表页面组件
class CollectListPage extends StatelessWidget {
  const CollectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用ChangeNotifierProvider提供视图模型
    return ChangeNotifierProvider(
      // 创建视图模型实例并立即加载第一页数据
      create: (_) => CollectListPageViewModel()..loadCollectList(0),
      // 页面主体内容
      child: const _CollectListPageBody(),
    );
  }
}

// 收藏列表页面主体内容（私有组件）
class _CollectListPageBody extends StatefulWidget {
  const _CollectListPageBody();

  @override
  State<_CollectListPageBody> createState() => _CollectListPageState();
}

// 收藏列表页面状态类，处理滚动和加载更多逻辑
class _CollectListPageState extends State<_CollectListPageBody> {
  late final ScrollController _scrollController; // 滚动控制器
  int _currentPage = 0; // 当前页码
  bool _isLoadingMore = false; // 是否正在加载更多

  @override
  void initState() {
    super.initState();
    // 初始化滚动控制器并添加滚动监听
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    // 销毁时清理滚动控制器
    _scrollController.dispose();
    super.dispose();
  }

  // 滚动事件处理函数，实现无限滚动
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent; // 最大滚动距离
    final currentScroll = _scrollController.position.pixels; // 当前滚动位置

    // 当滚动到底部附近(50px缓冲)且没有正在加载时，触发加载更多
    if (currentScroll >= maxScroll - 50 && !_isLoadingMore) {
      _loadMore();
    }
  }

  // 加载更多数据的异步函数
  Future<void> _loadMore() async {
    setState(() {
      _isLoadingMore = true; // 设置加载状态
      _currentPage++; // 页码增加
    });

    // 通过视图模型加载下一页数据
    await context
        .read<CollectListPageViewModel>()
        .loadCollectList(_currentPage);

    setState(() {
      _isLoadingMore = false; // 重置加载状态
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的收藏")), // 页面标题
      body: Consumer<CollectListPageViewModel>(
        builder: (context, vm, _) {
          final collectList = vm.collectDetailList; // 从视图模型获取收藏列表

          // 使用CustomScrollView实现复杂滚动布局
          return CustomScrollView(
            controller: _scrollController, // 绑定滚动控制器
            slivers: [
              // 如果列表为空且不在加载中，显示加载指示器
              if (collectList.isEmpty && !_isLoadingMore)
                SliverFillRemaining(
                  child: const Center(child: CircularProgressIndicator()),
                )
              else ...[
                // 列表顶部添加8像素间距
                SliverToBoxAdapter(child: const SizedBox(height: 8)),
                // 收藏项列表主体
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // 使用CollectItemLayout组件渲染每个收藏项
                      return CollectItemLayout(
                        collectDetail: collectList[index],
                        onCollectTap: () {
                          print('获取到的 link 为: ${collectList[index].link}');
                          Navigator.pushNamed(
                              context, RoutesConstants.linkDetail,
                              arguments: {
                                'link': collectList[index].link,
                                'title': collectList[index].title,
                              });
                        },
                      );
                    },
                    childCount: collectList.length, // 列表项数量
                  ),
                ),
                // 底部加载指示器（加载时显示）
                SliverToBoxAdapter(
                  child: _isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink(), // 不加载时隐藏
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
