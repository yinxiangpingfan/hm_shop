import 'package:shared_preferences/shared_preferences.dart';
import '../constants/index.dart';

class TokenManager {
  //返回持久化的实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  //初始化
  String _token = '';
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? '';
  }

  //设置token
  Future<void> set(String token) async {
    final prefs = await _getInstance();
    await prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;
  }

  //获取token,尽量使用同步方法，所以把获取token的地方写在init，然后在这里直接return
  getToken() {
    return _token;
  }

  //删除
  Future<void> remove() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); //磁盘
    _token = ''; //内存
  }
}

final tokenManager = TokenManager();
