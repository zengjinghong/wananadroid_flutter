import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/articles_response.dart';

class ArticleItemLayout extends StatefulWidget {
  // 构造函数，接收文章数据、收藏点击回调及是否显示收藏按钮
  const ArticleItemLayout(
      {Key? key,
        required this.article,
        required this.onCollectTap,
        required this.onTap,
        this.showCollectBtn})
      : super(key: key);

  final Article article; // 文章数据模型

  final void Function() onCollectTap; // 收藏按钮点击回调
  final void Function() onTap; // 文章列表点击事件

  final bool? showCollectBtn; // 是否显示收藏按钮，默认为显示

  @override
  State<StatefulWidget> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItemLayout> {
  @override
  void initState() {
    super.initState();
    // 监听文章收藏状态变化，更新UI
    widget.article.addListener(_onCollectChange);
  }

  @override
  void didUpdateWidget(ArticleItemLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果传入的文章数据模型变化，重新注册监听
    if (oldWidget.article != widget.article) {
      oldWidget.article.removeListener(_onCollectChange);
      widget.article.addListener(_onCollectChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    // 移除监听，防止内存泄漏
    widget.article.removeListener(_onCollectChange);
  }

  // 文章收藏状态变更时调用，刷新当前组件
  _onCollectChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 格式化发布时间字符串，去除末尾多余字符
    String publishTime =
    DateTime.fromMillisecondsSinceEpoch(widget.article.publishTime)
        .toString();
    publishTime = publishTime.substring(0, publishTime.length - 4);

    // 拼接文章分类字符串，格式为 “父分类·子分类”
    StringBuffer sb = StringBuffer(widget.article.superChapterName ?? "");
    if (sb.isNotEmpty && widget.article.chapterName.isNotEmpty) {
      sb.write("·");
    }
    sb.write(widget.article.chapterName ?? "");

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: widget.onTap,
          child: Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            elevation: 8, // 卡片阴影
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      // 作者名称，若作者为空显示分享人
                      Container(
                        padding: widget.article.type == 1
                            ? const EdgeInsets.fromLTRB(8, 0, 0, 0)
                            : const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Text(
                            '作者: ${widget.article.author.isNotEmpty == true ? widget.article.author : widget.article.shareUser ?? ""}'),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 8),
                          alignment: Alignment.centerRight,
                          // 发布时间显示
                          child: Text(publishTime),
                        ),
                      )
                    ],
                  ),
                  // 文章标题区域，支持HTML样式并限制最大两行，溢出省略
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: Html(
                              data: widget.article.title,
                              style: {
                                "html": Style(
                                    margin: Margins.zero,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontSize: FontSize(14),
                                    padding: HtmlPaddings.zero,
                                    alignment: Alignment.topLeft),
                                "body": Style(
                                    margin: Margins.zero,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontSize: FontSize(14),
                                    padding: HtmlPaddings.zero,
                                    alignment: Alignment.topLeft)
                              },
                            ))
                      ],
                    ),
                  ),
                  // 分类标签与收藏按钮一行布局
                  Row(
                    children: [
                      // 显示文章分类
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(sb.toString())),
                      Expanded(
                        child: Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 8),
                          child: Builder(
                            builder: (context) {
                              // 如果不显示收藏按钮，返回空容器
                              if (widget.showCollectBtn == false) {
                                return Container();
                              }
                              // 收藏按钮，已收藏为红色实心心形，未收藏为默认图标
                              return GestureDetector(
                                onTap: widget.onCollectTap,
                                child: !(widget.article.collect)
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite, color: Colors.red),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
