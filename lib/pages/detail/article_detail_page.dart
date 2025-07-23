import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


// 文章详情页面（直接使用WebView展示）
class ArticleDetailPage extends StatefulWidget {
  final String link; // 接收外部传入的文章链接
  final String title;

  const ArticleDetailPage({super.key, required this.link, required this.title});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {


  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebView(
        initialUrl: widget.link,
      ),
    );
  }
}