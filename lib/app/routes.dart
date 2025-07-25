import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/app/constants.dart';
import 'package:wananadroid_flutter/pages/collect/collect_list_page.dart';
import 'package:wananadroid_flutter/pages/detail/article_detail_page.dart';
import 'package:wananadroid_flutter/pages/home/home_page.dart';
import 'package:wananadroid_flutter/pages/login_register/login_register_page.dart';
import 'package:wananadroid_flutter/pages/search/search_page.dart';
import 'package:wananadroid_flutter/pages/treechild/tree_page_child.dart';

/// 路由表及跳转管理
class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    RoutesConstants.login: (_) => LoginRegisterPage(),
    RoutesConstants.home: (_) => HomePage(),
    RoutesConstants.treeChild: (context) {
      // 从ModalRoute获取参数
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return TreePageChild(
        chapterId: args['chapterId'],
        childId: args['childId'],
      );
    },
    RoutesConstants.collectList: (_) => CollectListPage(),
    RoutesConstants.linkDetail: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ArticleDetailPage(link: args['link'], title: args['title'],);
    },
    RoutesConstants.search: (_) => SearchPage(),
  };
}
