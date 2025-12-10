import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/stores/TokenManger.dart';
import 'package:hm_shop/stores/UserControl.dart';
import '../home/index.dart';
import '../category/index.dart';
import '../cart/index.dart';
import '../mine/index.dart';
import '../../api/login.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _initUser();
  }

  final Usercontrol _usercontrol = Get.put(Usercontrol());

  void _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken() != null) {
      // 获取用户信息
      _usercontrol.updateUserInfo(await getUserInfoApi());
    }
  }

  final List<Map<String, String>> _bottomItems = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_home_active.png", // 激活显示的图标
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_pro_active.png", // 激活显示的图标
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_cart_active.png", // 激活显示的图标
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", // 正常显示的图标
      "active_icon": "lib/assets/ic_public_my_active.png", // 激活显示的图标
      "text": "我的",
    },
  ];

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    List<BottomNavigationBarItem> _items = [];
    for (int i = 0; i < _bottomItems.length; i++) {
      _items.add(
        BottomNavigationBarItem(
          icon: Image.asset(_bottomItems[i]["icon"]!, width: 30, height: 30),
          activeIcon: Image.asset(
            _bottomItems[i]["active_icon"]!,
            width: 30,
            height: 30,
          ),
          label: _bottomItems[i]["text"],
        ),
      );
    }
    return _items;
  }

  List<Widget> _getListWidget() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SafeArea避开安全区的组件,indexStack索引堆叠组件
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex, //索引
          children: _getListWidget(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: _getBottomNavigationBarItems(),
      ),
    );
  }
}
