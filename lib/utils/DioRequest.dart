//基于dio二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/stores/TokenManger.dart';

class Diorequest {
  final _dio = Dio();
  //基础地址拦截器
  Diorequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    //拦截器
    _addInterceptor();
  }
  void _addInterceptor() {
    //添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          //注入token，在request 中加入header Authorization = "Bearer token"
          if (tokenManager.getToken() != null) {
            request.headers['Authorization'] =
                'Bearer ${tokenManager.getToken()}';
          }
          handler.next(request);
        },
        onResponse: (response, handler) {
          //http状态码
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          } else {
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
          }
        },
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data['msg'] ?? '加载数据异常',
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) {
    return _handlerResponse(_dio.get(url, queryParameters: queryParameters));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handlerResponse(_dio.post(url, data: data));
  }

  Future<dynamic> _handlerResponse(Future<Response<dynamic>> response) async {
    try {
      Response<dynamic> res = await response;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS) {
        //可以正常放行
        return data['result'];
      } else {
        //抛出异常
        throw DioException(
          requestOptions: res.requestOptions,
          message: res.data['msg'] ?? '加载数据异常',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}

//单例对象
final diorequest = Diorequest();

//把所有的接口的data解放出来，拿到真正的数据 要判断业务状态码是否等于1
