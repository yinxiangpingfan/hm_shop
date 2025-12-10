import 'package:flutter/material.dart';
import '../../viewmodels/home.dart';

class Hot extends StatefulWidget {
  final HotSuggestResult hotSuggestResult;
  Hot({required this.hotSuggestResult});

  @override
  State<Hot> createState() => _HotState();
}

class _HotState extends State<Hot> {
  Widget _buildText() {
    return Row(
      children: [
        Text(
          widget.hotSuggestResult.title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 5),
        Text(
          widget.hotSuggestResult.title == "爆款推荐" ? "最受欢迎" : "核心优选",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  //获取商品
  List<GoodsItem> _getGoods() {
    if (widget.hotSuggestResult.subType == null ||
        widget.hotSuggestResult.subType!.isEmpty ||
        widget.hotSuggestResult.subType![0].goodsItems == null ||
        widget.hotSuggestResult.subType![0].goodsItems!.items == null ||
        widget.hotSuggestResult.subType![0].goodsItems!.items!.isEmpty) {
      return [];
    }

    var item = widget.hotSuggestResult.subType![0].goodsItems!.items!;
    List<GoodsItem> items = [];
    int count = item.length < 2 ? item.length : 2;
    for (int i = 0; i < count; i++) {
      items.add(item[i]);
    }
    return items;
  }

  List<Widget> _buildPic() {
    List<GoodsItem> goods = _getGoods();
    List<Widget> goodsWidgets = [];
    for (int i = 0; i < goods.length; i++) {
      goodsWidgets.add(
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  errorBuilder:
                      (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) {
                        return Image.asset(
                          'lib/assets/home_cmd_inner.png',
                          width: 85,
                          height: 108,
                          fit: BoxFit.cover,
                        );
                      },
                  goods[i].picture!,
                  width: 85,
                  height: 108,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 3),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  goods[i].price!,
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
      if (i == 0) goodsWidgets.add(SizedBox(width: 10));
    }
    return goodsWidgets;
  }

  Widget _buildConter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _buildPic(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      //设置高度和宽度一样
      height: 200,
      decoration: BoxDecoration(
        color: widget.hotSuggestResult.title == "爆款推荐"
            ? const Color.fromARGB(255, 144, 202, 250)
            : const Color.fromARGB(255, 236, 215, 215),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [_buildText(), SizedBox(height: 10), _buildConter()],
      ),
    );
  }
}
