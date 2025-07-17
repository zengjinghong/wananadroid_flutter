import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/widgets/vp_text.dart';

import '../app/constants.dart';

/// 通用轮播图组件（支持图片轮播、指示器、标题、圆角、点击事件、手势控制等）
class VpBanner extends StatefulWidget {
  // 图片资源列表（必传）
  final List<String>? imageList;

  // 可选标题集合，对应每张图的标题
  final List<String>? titleList;

  // 圆角大小
  final double? radius;

  // banner 高度
  final double? height;

  // 单独设置图片边距（四边）
  final double? imageMarginLeft,
      imageMarginTop,
      imageMarginRight,
      imageMarginBottom,
      imageMargin;

  // 整个 banner 的边距（四边）
  final double? marginLeft, marginTop, marginRight, marginBottom, margin;

  // 指示器距离底部、左右的边距
  final double? indicatorMarginBottom,
      indicatorMarginRight,
      indicatorMarginLeft;

  // 指示器颜色
  final Color? indicatorSelectColor, indicatorUnSelectColor;

  // 指示器尺寸（选中与未选中）
  final double? indicatorWidth,
      indicatorHeight,
      indicatorUnWidth,
      indicatorUnHeight;

  // 指示器之间的间距
  final double? indicatorMargin;

  // 指示器样式类型（圆形/矩形/文字）
  final IndicatorType? indicatorType;

  // 指示器圆角（矩形时有效）
  final double? indicatorRadius;

  // 指示器是否显示在 banner 下方区域
  final bool? indicatorBannerBottom;

  // banner 下方的指示器区域背景色与尺寸、边距
  final Color? indicatorBottomColor;
  final double? indicatorBottomHeight;
  final double? indicatorBottomMarginLeft;
  final double? indicatorBottomMarginRight;

  // banner 下方指示器的对齐方式
  final MainAxisAlignment indicatorBottomMainAxisAlignment;

  // 自动轮播时间间隔（单位：秒）
  final int? delay;

  // 是否启用自动轮播
  final bool? autoPlay;

  // 是否显示指示器
  final bool? showIndicators;

  // 点击事件回调，返回当前 index
  final Function(int)? bannerClick;

  // 页面缩进程度（控制左右滑动效果）
  final double? viewportFraction;

  // 文字指示器对齐方式、样式、背景色、内边距
  final Alignment? textIndicatorAlignment;
  final TextStyle? textIndicatorStyle;
  final Color? textIndicatorBgColor;
  final double? textIndicatorPadding;
  final double? textIndicatorPaddingLeft,
      textIndicatorPaddingTop,
      textIndicatorPaddingRight,
      textIndicatorPaddingBottom;

  // 标题背景色、高度、样式、对齐方式、底部间距
  final Color? titleBgColor;
  final double? titleHeight;
  final Alignment? titleAlignment;
  final TextStyle? titleStyle;
  final double? titleMarginBottom;

  // 非当前页图片缩放比例
  final double? bannerOtherScale;

  // 占位图、错误图
  final String? placeholderImage;
  final String? errorImage;

  // 图片适应方式
  final BoxFit? imageBoxFit;

  const VpBanner({
    super.key,
    required this.imageList,
    this.radius = 0,
    this.height = 150,
    this.marginLeft = 0,
    this.marginTop = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.margin,
    this.imageMarginLeft = 0,
    this.imageMarginTop = 0,
    this.imageMarginRight = 0,
    this.imageMarginBottom = 0,
    this.imageMargin,
    this.indicatorMarginBottom = 10,
    this.indicatorMarginRight,
    this.indicatorMarginLeft,
    this.indicatorSelectColor = Colors.red,
    this.indicatorUnSelectColor = Colors.grey,
    this.indicatorWidth = 10,
    this.indicatorHeight = 10,
    this.indicatorMargin = 5,
    this.indicatorType = IndicatorType.circle,
    this.indicatorRadius = 0,
    this.indicatorUnWidth,
    this.indicatorUnHeight,
    this.indicatorBannerBottom = false,
    this.indicatorBottomColor = Colors.transparent,
    this.indicatorBottomHeight = 30,
    this.indicatorBottomMarginLeft = 0,
    this.indicatorBottomMarginRight = 0,
    this.indicatorBottomMainAxisAlignment = MainAxisAlignment.center,
    this.delay = 5,
    this.autoPlay = true,
    this.showIndicators = true,
    this.bannerClick,
    this.viewportFraction = 1,
    this.textIndicatorAlignment = Alignment.center,
    this.textIndicatorStyle,
    this.textIndicatorPadding,
    this.textIndicatorPaddingLeft = 0,
    this.textIndicatorPaddingTop = 0,
    this.textIndicatorPaddingRight = 0,
    this.textIndicatorPaddingBottom = 0,
    this.titleList,
    this.titleBgColor = Colors.transparent,
    this.titleHeight,
    this.titleAlignment = Alignment.centerLeft,
    this.titleStyle,
    this.titleMarginBottom = 0,
    this.bannerOtherScale = 1.0,
    this.placeholderImage,
    this.imageBoxFit = BoxFit.cover,
    this.errorImage,
    this.textIndicatorBgColor,
  });

  @override
  State<StatefulWidget> createState() => _CarouselState();
}

class _CarouselState extends State<VpBanner> with WidgetsBindingObserver {
  late PageController _controller; // PageView 控制器
  int _currentPage = 0; // 当前显示页面
  int _pagePosition = 0; // 实际 PageView 位置（可能大于图片数量）

  Timer? _timer; // 轮播定时器
  bool _isRunning = false; // 定时器运行标志
  bool _isClick = true; // 判断是点击还是滑动

  /// 启动轮播定时器
  void _startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(Duration(seconds: widget.delay!), (timer) {
        _controller.animateToPage(
          _pagePosition + 1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  /// 暂停轮播定时器
  void _pauseTimer() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.viewportFraction!);
    WidgetsBinding.instance.addObserver(this);
    if (widget.autoPlay!) {
      _startTimer();
    }
  }

  /// 应用生命周期变更（后台暂停轮播，恢复继续）
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _startTimer();
    } else if (state == AppLifecycleState.paused) {
      _pauseTimer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// 页面滑动监听
  void _onPageChanged(int index) {
    var position = index % widget.imageList!.length;
    setState(() {
      _currentPage = position;
      _pagePosition = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 空数据直接返回占位
    if (widget.imageList == null || widget.imageList!.isEmpty) {
      return const SizedBox(
          height: 150, child: Center(child: Text("暂无 Banner")));
    }

    // 构建 banner 图组件（包含手势控制）
    Widget bannerImage = ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius!),
      child: Container(
        margin: widget.margin != null
            ? EdgeInsets.all(widget.margin!)
            : EdgeInsets.only(
                left: widget.marginLeft!,
                top: widget.marginTop!,
                right: widget.marginRight!,
                bottom: widget.marginBottom!,
              ),
        height: widget.height,
        child: Listener(
          onPointerDown: (_) {
            _pauseTimer(); // 手指按下暂停轮播
            _isClick = true;
          },
          onPointerMove: (_) {
            _isClick = false;
          },
          onPointerUp: (_) {
            _startTimer(); // 手指抬起重启轮播
            if (_isClick && widget.bannerClick != null) {
              widget.bannerClick!(_currentPage);
            }
          },
          child: PageView.builder(
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              double scale = index % widget.imageList!.length != _currentPage
                  ? widget.bannerOtherScale!
                  : 1.0;
              String imageUrl =
                  widget.imageList![index % widget.imageList!.length];
              return Transform.scale(
                scale: scale,
                child: Container(
                  margin: widget.imageMargin != null
                      ? EdgeInsets.all(widget.imageMargin!)
                      : EdgeInsets.only(
                          left: widget.imageMarginLeft!,
                          top: widget.imageMarginTop!,
                          right: widget.imageMarginRight!,
                          bottom: widget.imageMarginBottom!,
                        ),
                  child: getBannerImage(imageUrl),
                ),
              );
            },
          ),
        ),
      ),
    );

    // 组合返回 Stack 或 Column（依据指示器位置）
    return !widget.indicatorBannerBottom!
        ? Stack(
            children: [
              bannerImage,
              if (widget.titleList != null) bannerTitle(),
              if (widget.showIndicators!) getBannerIndicators(),
            ],
          )
        : Column(
            children: [
              bannerImage,
              if (widget.showIndicators!) getBannerBottomIndicators(),
            ],
          );
  }

  /// 获取 banner 图片组件（支持占位图）
  Widget getBannerImage(String imageUrl) {
    if (widget.placeholderImage == null) {
      return Image.network(imageUrl, fit: widget.imageBoxFit);
    } else {
      return FadeInImage(
        fit: widget.imageBoxFit,
        placeholderFit: widget.imageBoxFit,
        placeholder: getPlaceholder(),
        image: NetworkImage(imageUrl),
        placeholderErrorBuilder: (_, __, ___) => _imagePlaceholder(),
        imageErrorBuilder: (_, __, ___) => _imageError(),
      );
    }
  }

  Widget _imagePlaceholder() =>
      Image.asset(ImageConstant.imageDefault, fit: widget.imageBoxFit);

  Widget _imageError() =>
      Image.asset(widget.errorImage ?? ImageConstant.imageDefault,
          fit: widget.imageBoxFit);

  ImageProvider getPlaceholder() => AssetImage(widget.placeholderImage!);

  /// 顶部叠加指示器（文字或点）
  Widget getBannerIndicators() {
    return Positioned(
      left: widget.indicatorMarginRight != null
          ? null
          : widget.indicatorMarginLeft ?? 0,
      right: widget.indicatorMarginLeft != null
          ? null
          : widget.indicatorMarginRight ?? 0,
      bottom: widget.indicatorMarginBottom!,
      child: _buildIndicators(MainAxisAlignment.center),
    );
  }

  /// 底部指示器区域
  Widget getBannerBottomIndicators() {
    return Container(
      height: widget.indicatorBottomHeight,
      color: widget.indicatorBottomColor,
      margin: EdgeInsets.only(
        left: widget.indicatorBottomMarginLeft!,
        right: widget.indicatorBottomMarginRight!,
      ),
      child: _buildIndicators(widget.indicatorBottomMainAxisAlignment),
    );
  }

  /// 构建点状或文字型指示器
  Widget _buildIndicators(MainAxisAlignment mainAxisAlignment) {
    if (widget.indicatorType == IndicatorType.text) {
      return Container(
        alignment: widget.textIndicatorAlignment,
        child: VpText(
          "${_currentPage + 1}/${widget.imageList!.length}",
          style: widget.textIndicatorStyle,
          backgroundColor: widget.textIndicatorBgColor,
          padding: widget.textIndicatorPadding,
          paddingLeft: widget.textIndicatorPaddingLeft,
          paddingTop: widget.textIndicatorPaddingTop,
          paddingRight: widget.textIndicatorPaddingRight,
          paddingBottom: widget.textIndicatorPaddingBottom,
        ),
      );
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(widget.imageList!.length, (index) {
        bool isSelected = index == _currentPage;
        return Container(
          width: isSelected
              ? widget.indicatorWidth
              : widget.indicatorUnWidth ?? widget.indicatorWidth,
          height: isSelected
              ? widget.indicatorHeight
              : widget.indicatorUnHeight ?? widget.indicatorHeight,
          margin: EdgeInsets.symmetric(horizontal: widget.indicatorMargin!),
          decoration: BoxDecoration(
            shape: widget.indicatorType == IndicatorType.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: widget.indicatorType == IndicatorType.rectangle
                ? BorderRadius.circular(widget.indicatorRadius!)
                : null,
            color: isSelected
                ? widget.indicatorSelectColor
                : widget.indicatorUnSelectColor,
          ),
        );
      }),
    );
  }

  /// 显示 Banner 当前标题（可选）
  Widget bannerTitle() {
    return Positioned(
      bottom: widget.titleMarginBottom,
      left: 0,
      right: 0,
      child: VpText(
        widget.titleList![_currentPage],
        height: widget.titleHeight,
        backgroundColor: widget.titleBgColor,
        alignment: widget.titleAlignment,
        style: widget.titleStyle,
      ),
    );
  }
}

/// 指示器样式类型
enum IndicatorType { circle, rectangle, text }
