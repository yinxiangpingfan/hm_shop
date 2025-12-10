import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:hm_shop/viewmodels/login.dart';

//需要共享的属性，属性需要相应式更新
class Usercontrol extends GetxController {
  var user = UserInfo.fromJSON({}).obs; //.obs意味着user被监听了
  //想要取值的话,需要user.value
  updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
