import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Suggestion extends StatefulWidget {
  final SpecialOfferResult? specialOfferResult;
  const Suggestion({super.key, required this.specialOfferResult});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  //获取商品列表
  List<GoodsItem> _getGoodsList() {
    List<GoodsItem> goodsList = [];
    // 检查数据是否为空
    if (widget.specialOfferResult == null ||
        widget.specialOfferResult!.subTypes == null ||
        widget.specialOfferResult!.subTypes!.isEmpty) {
      return [];
    }

    var items = widget.specialOfferResult!.subTypes![0].goodsItems?.items;
    if (items != null && items.length >= 3) {
      for (int i = 0; i < 3; i++) {
        goodsList.add(items[i]);
      }
    }
    return goodsList;
  }

  //右侧内容
  List<Widget> _buildGoodsList() {
    List<GoodsItem> goodsList = _getGoodsList();
    List<Widget> goodsWidgetList = [];
    for (int i = 0; i < goodsList.length; i++) {
      goodsWidgetList.add(
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  errorBuilder:
                      (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) {
                        return Image.asset(
                          'lib/assets/home_cmd_inner.png',
                          width: 90,
                          height: 126,
                          fit: BoxFit.cover,
                        );
                      },
                  goodsList[i].picture!,
                  width: 90,
                  height: 126,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  goodsList[i].price!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return goodsWidgetList;
  }

  //顶部内容
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  //左侧结构
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 148,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('lib/assets/home_cmd_inner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 如果数据为空，返回空容器
    if (widget.specialOfferResult == null) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('lib/assets/home_cmd_sm.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: 220,
        child: Column(
          children: [
            //顶部内容
            _buildHeader(),
            SizedBox(height: 5),
            //内容
            Row(
              children: [
                _buildLeft(),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildGoodsList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
