class BannerItem {
  //每一个轮播图的位置
  String? image;
  String? id;
  BannerItem({required this.image, required this.id});
  //扩展一个工厂函数 一般用factory来声明，一般用来创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(image: json['imgUrl'] ?? '', id: json['id'] ?? '');
  }
}

//根据json编写class和工厂转化函数
class Category {
  String? id;
  String? name;
  String? picture;
  List<Category>? children;
  String? goods;
  Category({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      goods: json['goods'] ?? '',
      children: json['children'] == null
          ? null
          : (json['children'] as List)
                .map((e) => Category.fromJson(e))
                .toList(),
    );
  }
}

// 商品项模型
class GoodsItem {
  String? id;
  String? name;
  String? desc;
  String? price;
  String? picture;
  int? orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'],
    );
  }
}

// 商品列表模型
class GoodsItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<GoodsItem>? items;

  GoodsItems({this.counts, this.pageSize, this.pages, this.page, this.items});

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      page: json['page'],
      items: json['items'] == null
          ? null
          : (json['items'] as List).map((e) => GoodsItem.fromJson(e)).toList(),
    );
  }
}

// 子类型模型
class SubType {
  String? id;
  String? title;
  GoodsItems? goodsItems;

  SubType({required this.id, required this.title, this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: json['goodsItems'] == null
          ? null
          : GoodsItems.fromJson(json['goodsItems']),
    );
  }
}

// 特惠推荐结果模型
class SpecialOfferResult {
  String? id;
  String? title;
  List<SubType>? subTypes;

  SpecialOfferResult({required this.id, required this.title, this.subTypes});

  factory SpecialOfferResult.fromJson(Map<String, dynamic> json) {
    return SpecialOfferResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: json['subTypes'] == null
          ? null
          : (json['subTypes'] as List).map((e) => SubType.fromJson(e)).toList(),
    );
  }
}

class Goods {
  String? id;
  String? name;
  String? picture;
  String? price;
  String? desc;
  int? orderNum;
  Goods({
    this.id,
    this.name,
    this.picture,
    this.price,
    this.desc,
    this.orderNum,
  });
  factory Goods.fromJson(Map<String, dynamic> json) {
    return Goods(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      price: json['price'] ?? '',
      desc: json['desc'],
      orderNum: json['orderNum'],
    );
  }
}

class GoodItems {
  String? id;
  String? title;
  List<GoodsItem>? items;
  GoodItems({this.id, this.title, this.items});
  factory GoodItems.fromJson(Map<String, dynamic> json) {
    return GoodItems(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      items: json['goodsItems'] == null
          ? null
          : (json['goodsItems'] as List)
                .map((e) => GoodsItem.fromJson(e))
                .toList(),
    );
  }
}

class SubTypes {
  String? id;
  String? title;
  List<GoodItems>? goodItems;
  SubTypes({this.id, this.title, this.goodItems});
  factory SubTypes.fromJson(Map<String, dynamic> json) {
    return SubTypes(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodItems: json['goodItems'] == null
          ? null
          : (json['goodItems'] as List)
                .map((e) => GoodItems.fromJson(e))
                .toList(),
    );
  }
}

class HotSuggestResult {
  String? id;
  String? title;
  List<SubType>? subType;
  HotSuggestResult({this.id, this.title, this.subType});
  factory HotSuggestResult.fromJson(Map<String, dynamic> json) {
    return HotSuggestResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subType:
          json['subTypes'] ==
              null // 注意这里改为 subTypes
          ? null
          : (json['subTypes'] as List).map((e) => SubType.fromJson(e)).toList(),
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

class GoodsDetailItems {
  int? counts;
  int? pageSize;
  int? pages;
  int? page;
  List<GoodDetailItem>? items;

  GoodsDetailItems({
    this.counts,
    this.pageSize,
    this.pages,
    this.page,
    this.items,
  });

  factory GoodsDetailItems.fromJson(Map<String, dynamic> json) {
    return GoodsDetailItems(
      counts: json['counts'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      page: json['page'],
      items: json['items'] == null
          ? null
          : (json['items'] as List)
                .map((e) => GoodDetailItem.fromJson(e))
                .toList(),
    );
  }
}
