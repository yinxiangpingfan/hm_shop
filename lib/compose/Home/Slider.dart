import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Slider extends StatefulWidget {
  final List<BannerItem> bannerList;
  Slider({Key? key, required this.bannerList}) : super(key: key);
  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  final _carouselController = CarouselSliderController(); //控制轮播图跳转控制器
  int _currentIndex = 0; //当前轮播图索引

  //返回轮播图
  Widget _getSlider() {
    final double width = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _carouselController,
      items: [
        for (int i = 0; i < widget.bannerList.length; i++)
          Image.network(
            widget.bannerList[i].image!,
            fit: BoxFit.cover,
            width: width,
          ),
      ],
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  //返回搜索框
  Widget _getSearch() {
    return Positioned(
      top: 10,
      right: 5,
      left: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          //设置到上下的中间
          alignment: Alignment(-0.80, 0),
          child: Text(
            '搜索...',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  //返回指示灯导航栏
  Widget _getIndicator() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < widget.bannerList.length; i++)
            GestureDetector(
              onTap: () {
                _carouselController.jumpToPage(i);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: i == _currentIndex ? 40 : 20,
                height: 8,
                //设置圆角
                decoration: BoxDecoration(
                  color: i == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.4),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getIndicator()]);
    // return Container(
    //   alignment: Alignment.center,
    //   color: Colors.blue,
    //   height: 300,
    //   child: Text('这是轮播图', style: TextStyle(color: Colors.white)),
    // );
  }
}
