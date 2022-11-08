import 'package:flutter/cupertino.dart';

class catrgoriesModel {
  late bool status;
  late categoriesDataModel data;

  catrgoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = categoriesDataModel.formjson(json['data']);
  }
}

class categoriesDataModel {
  late int current_page;
  List<dataModel> data = [];

  categoriesDataModel.formjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(dataModel.fromjson(element));
    });
  }
}
//  json['products'].forEach(// this way i put data from json list
//         (element) {
//       products.add(ProductModel.formjson(element));
//     });

class dataModel {
  late int id;
  late String name, image;

  dataModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
