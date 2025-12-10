//封装api，返回业务侧需要的数据类型

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerList() async {
  //返回请求
  return ((await diorequest.get(HttpConstants.BANNER_LIST)) as List)
      .map((e) => BannerItem.fromJson(e))
      .toList();
}

Future<List<Category>> getCategoryList() async {
  return ((await diorequest.get(HttpConstants.CATEGORY_LIST)) as List)
      .map((e) => Category.fromJson(e))
      .toList();
}

//特惠推荐的接口
Future<SpecialOfferResult> getSpecialOfferList() async {
  return SpecialOfferResult.fromJson(
    await diorequest.get(HttpConstants.PRODUCT_LIST),
  );
}

//爆款推荐
Future<HotSuggestResult> getHotSuggestList() async {
  return HotSuggestResult.fromJson(
    await diorequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

//一站买全
Future<HotSuggestResult> getOneStopList() async {
  return HotSuggestResult.fromJson(
    await diorequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

//推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await diorequest.get(
            HttpConstants.RECOMMEND_LIST,
            queryParameters: params,
          ))
          as List)
      .map((item) {
        return GoodDetailItem.fromJson(item as Map<String, dynamic>);
      })
      .toList();
}
