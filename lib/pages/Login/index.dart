import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/login.dart';
import 'package:hm_shop/stores/TokenManger.dart';
import 'package:hm_shop/stores/UserControl.dart';
import 'package:hm_shop/utils/Loading.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 手机号和密码的控制器
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Usercontrol _usercontrol = Get.find();

  //头部提示控件
  Widget _getHeaderWidget() {
    return const Text(
      '手机号密码登陆',
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
    );
  }

  //输入手机号控件
  Widget _getUserWidget() {
    return TextFormField(
      controller: _phoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入手机号';
        }
        //校验手机号
        if (!RegExp(r'^1[3456789]\d{9}$').hasMatch(value)) {
          return '请输入正确的手机号';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20.0),
        hintText: '请输入手机号',
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  bool _isObscure = true;
  //输入密码控件
  Widget _getPassWidget() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入密码';
        }
        return null;
      },
      obscureText: _isObscure,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
        hintText: '请输入密码',
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
    );
  }

  //勾选隐私条款和用户协议控件
  bool _isChecked = false;
  Widget _getCheckboxWidget() {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.black,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        Text('我已阅读并同意'),
        Text('隐私条款', style: TextStyle(color: Colors.blue)),
        Text('和'),
        Text('用户协议', style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  //登陆按钮
  Widget _getLoginButtonWidget() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          // 先检查是否同意协议
          if (!_isChecked) {
            Toastutils.showTxt(context, '请同意隐私条款和用户协议');
            return;
          }
          // 验证表单
          if (_formKey.currentState?.validate() ?? false) {
            // 校验通过，执行登录
            _login();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: const Text(
          '登录',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 登录函数
  _login() async {
    try {
      // 显示加载中
      LoadingDiolog.show(context, message: '登录中...');
      // 获取输入的手机号和密码
      final phone = _phoneController.text;
      final password = _passwordController.text;

      // 调用登录API
      final userInfo = await loginApi(phone, password);
      //将信息加入到getX
      _usercontrol.updateUserInfo(userInfo);
      //保存token
      tokenManager.set(userInfo.token);
      LoadingDiolog.hide(context);
      Toastutils.showTxt(context, '登录成功');
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      // 登录失败
      LoadingDiolog.hide(context);
      Toastutils.showTxt(context, '登录失败: ${(e as DioException).message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '登录',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(30.0),
            color: Colors.white,
            child: Column(
              children: [
                _getHeaderWidget(),
                const SizedBox(height: 20.0),
                _getUserWidget(),
                const SizedBox(height: 20.0),
                _getPassWidget(),
                const SizedBox(height: 20.0),
                _getCheckboxWidget(),
                const SizedBox(height: 20.0),
                _getLoginButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
