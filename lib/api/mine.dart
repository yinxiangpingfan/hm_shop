import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<GoodsDetailItems> getGoodDetailItem(Map<String, dynamic> pr) async {
  return GoodsDetailItems.fromJson(
    await diorequest.get(HttpConstants.GUESS_LIST, queryParameters: pr),
  );
}
