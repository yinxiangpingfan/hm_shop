import 'package:flutter/material.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';
import '../../compose/Home/Slider.dart' as HomeSlider;
import '../../compose/Home/Category.dart' as HomeCategory;
import '../../compose/Home/Suggestion.dart' as HomeSuggestion;
import '../../compose/Home/Hot.dart' as HomeHot;
import '../../compose/Home/MoreList.dart';
import '../../api/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Category> _categoryList = [];
  List<BannerItem> _bannerList = [];
  SpecialOfferResult? _specialOfferResult;
  HotSuggestResult? _hotSuggestResult;
  HotSuggestResult? _OneStopResult;
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  double _bottomPadding = 0;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _registerEvent(); // 注册滚动监听
    _bottomPadding = 100.0;
    setState(() {});
    Future.microtask(() {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  //监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      //滚动的距离>=滚动的最大距离-50
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        //加载下一页
        _getRecommendList();
      }
    });
  }

  //页码
  int _page = 1;
  bool _isLoad = false; //是否正在加载
  bool _hasMore = true; //是否还有更多数据
  //获取推荐列表的数据
  Future<void> _getRecommendList() async {
    if (_isLoad || !_hasMore) return;
    _isLoad = true;
    int _request = 8 * _page;
    List<GoodDetailItem> _newList = await getRecommendListAPI({
      "limit": _request,
    });
    _recommendList = _newList;
    _isLoad = false;
    setState(() {});
    if (_recommendList.length < 8) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  //获取爆款推荐的数据
  Future<void> _getHotSuggestList() async {
    _hotSuggestResult = await getHotSuggestList();
  }

  //获取一站式推荐的数据
  Future<void> _getOneStopList() async {
    _OneStopResult = await getOneStopList();
  }

  // 获取banner数据
  Future<void> _getBannerList() async {
    _bannerList = await getBannerList();
  }

  // 获取分类数据
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryList();
  }

  //获取特惠推荐
  Future<void> _getSpecialOfferList() async {
    _specialOfferResult = await getSpecialOfferList();
  }

  Future<void> _refresh() async {
    _page = 1;
    _isLoad = false; //是否正在加载
    _hasMore = true; //是否还有更多数据
    await Future.wait([
      _getRecommendList(),
      _getBannerList(),
      _getCategoryList(),
      _getSpecialOfferList(),
      _getOneStopList(),
      _getHotSuggestList(),
    ]);
    _bottomPadding = 0;
    setState(() {});
    Toastutils.showTxt(context, "刷新成功");
  }

  List<Widget> _getScrollChildren() {
    return [
      //包括普通widget组件的sliver
      //放置轮播图组件
      SliverToBoxAdapter(child: HomeSlider.Slider(bannerList: _bannerList)),
      //用尺寸组件分割
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //实现分类组件
      //ListView
      SliverToBoxAdapter(
        child: HomeCategory.CategoryWidget(categoryList: _categoryList),
      ),
      //实现推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HomeSuggestion.Suggestion(
          specialOfferResult: _specialOfferResult,
        ),
      ),
      //实现爆款组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      if (_hotSuggestResult != null && _OneStopResult != null)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: HomeHot.Hot(hotSuggestResult: _hotSuggestResult!),
                ),
                SizedBox(width: 10),
                Expanded(child: HomeHot.Hot(hotSuggestResult: _OneStopResult!)),
              ],
            ),
          ),
        ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //实现MoreList组件
      HmMoreList(recommendList: _recommendList),
    ];
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();
  //设置一个globalkey绑定在组件上，可以操作组件
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.only(top: _bottomPadding),
      child: RefreshIndicator(
        onRefresh: _refresh,
        key: _refreshIndicatorKey,
        child: CustomScrollView(
          controller: _controller, //绑定控制器
          slivers: _getScrollChildren(),
        ), //自由滚动容器,sliver家族的内容
      ),
    );
  }
}
