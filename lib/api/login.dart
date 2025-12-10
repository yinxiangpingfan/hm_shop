import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/login.dart';
import 'package:hm_shop/constants/index.dart';

Future<UserInfo> loginApi(String username, String password) async {
  return UserInfo.fromJSON(
    await Diorequest().post(
      HttpConstants.LOGIN,
      data: {'account': username, 'password': password},
    ),
  );
}

Future<UserInfo> getUserInfoApi() async {
  return UserInfo.fromJSON(await Diorequest().get(HttpConstants.USER_PROFILE));
}
