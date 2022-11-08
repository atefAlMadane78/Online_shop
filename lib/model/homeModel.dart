import 'package:flutter/cupertino.dart';

class homeModel {
  late bool status;
  late HomeDataModel data;

  homeModel.formjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.formjson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  //  dynamic banners = [];
  //  dynamic products = [];

  HomeDataModel.formjson(Map<String, dynamic> json) {
    json['banners'].forEach(// this way i put data from json list
        (element) {
      banners.add(BannerModel.formjson(element)); //.add(Banner.fromjson(element)) if yoy want to removw dynamic
    });

    json['products'].forEach(// this way i put data from json list
        (element) {
      products.add(ProductModel.formjson(element));
    });
  }
}

class BannerModel {
  late int id;
  late String image;

  BannerModel.formjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price, oldPrice, discountl;
  late String image, name;
  late bool inFavorites, inCart;
  
  ProductModel.formjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discountl = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
