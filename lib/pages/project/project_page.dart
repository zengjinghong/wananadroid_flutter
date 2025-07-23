import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wananadroid_flutter/pages/project/project_page_view_model.dart';
import 'package:wananadroid_flutter/utils/toast_utils.dart';
import 'package:wananadroid_flutter/widgets/project_article_item.dart';

import '../../app/constants.dart';
import '../../base/base_page.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用ChangeNotifierProvider提供ProjectPageViewModel状态管理
    // create参数创建ViewModel实例
    // child参数指定子组件_ProjectPageBody
    return ChangeNotifierProvider<ProjectPageViewModel>(
      create: (_) => ProjectPageViewModel(), // 创建 ViewModel
      child: _ProjectPageBody(), // 子组件主体
    );
  }
}

// ProjectPage的页面主体，使用StatefulWidget以便进行生命周期控制
// 与TabController和ScrollController配合使用需要StatefulWidget
class _ProjectPageBody extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<_ProjectPageBody>
    with BasePage<_ProjectPageBody>, SingleTickerProviderStateMixin {
  late TabController _tabController; // 控制Tab栏的控制器

  late final ScrollController _scrollController; // 控制列表滚动的控制器


  int selectedIndex = 0; // 当前选中的Tab索引
  int currentPage = 1;   // 当前加载的页码
  int currentId = 0;     // 当前分类ID

  @override
  void initState() {
    super.initState();

    // 初始化滚动控制器并添加滚动监听
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll); // 绑定滚动监听方法

    // 在Widget树构建完成后执行初始化操作
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<ProjectPageViewModel>();
      // 加载项目分类数据
      vm.loadProjectCategory().then((_) {
        // 检查组件是否仍然挂载
        if (mounted) {
          setState(() {
            // 初始化TabController，长度等于分类数量
            _tabController = TabController(
              length: vm.projectCategoryList.length,
              vsync: this, // 使用SingleTickerProviderStateMixin提供vsync
              initialIndex: selectedIndex, // 初始选中索引
            );
          });
          // 设置当前分类ID并加载第一页文章
          currentId = vm.projectCategoryList[selectedIndex].id;
          vm.loadProjectArticles(currentPage, currentId);
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // 释放TabController资源
    _scrollController.dispose(); // 释放ScrollController资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 监听项目分类列表变化
    final projectCategoryList =
        context.watch<ProjectPageViewModel>().projectCategoryList;

    // 监听项目文章列表变化
    final projectArticleList =
        context.watch<ProjectPageViewModel>().projectArticleList;

    return Column(
      children: [
        // 顶部水平Tab栏
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController, // 绑定TabController
            isScrollable: true, // 允许横向滚动
            indicatorColor: Colors.blue, // 指示器颜色
            labelColor: Colors.blue, // 选中标签颜色
            unselectedLabelColor: Colors.black54, // 未选中标签颜色
            tabs: projectCategoryList.map((e) => Tab(text: e.name)).toList(), // 生成Tab列表
            tabAlignment: TabAlignment.start, // 标签对齐方式
            onTap: (index) {
              // Tab点击事件处理
              setState(() {
                selectedIndex = index; // 更新选中索引
                currentId = context
                    .read<ProjectPageViewModel>()
                    .projectCategoryList[selectedIndex]
                    .id; // 更新当前分类ID
                currentPage = 1; // 重置页码
              });

              // 加载新分类的第一页数据
              context
                  .read<ProjectPageViewModel>()
                  .loadProjectArticles(currentPage, currentId);
            },
          ),
        ),

        // 内容区域，使用Expanded填满剩余空间
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              controller: _scrollController, // 绑定滚动控制器
              itemCount: projectArticleList.length, // 列表项数量
              itemBuilder: (_, i) {
                // 构建每个文章项
                return ProjectArticleItemLayout(
                  projectArticle: projectArticleList[i],
                  onCollectTap: () {
                    Navigator.pushNamed(
                        context, RoutesConstants.linkDetail,
                        arguments: {
                          'link': projectArticleList[i].link,
                          'title': projectArticleList[i].title,
                        });
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  // 滚动监听方法
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent; // 最大滚动范围
    final currentScroll = _scrollController.position.pixels; // 当前滚动位置

    // 当滚动到接近底部(距离底部50像素)时触发加载更多
    if (currentScroll >= maxScroll - 50) {
      _loadMore();
    }
  }

  /// 加载更多文章数据
  Future<void> _loadMore() async {
    currentPage++; // 页码增加
    // 加载下一页数据
    await context.read<ProjectPageViewModel>().loadProjectArticles(currentPage, currentId);
  }
}
