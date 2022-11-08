class searchModel {
  late bool status;
  late Null message;
  late Data data;

  searchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =Data.fromJson(json['data']) ;
    // json['data'] != null ? new : null;
  }
}

class Data {
  late int? currentPage;
  late List<Product> data;
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String lastPageUrl;
  late Null nextPageUrl;
  late String path;
  late int? perPage;
  late Null prevPageUrl;
  late int? to;
  late int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ??0;
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data.add(Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ;
    from = json['from']?? 0;
    lastPage = json['last_page']?? 0;
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page']?? 0;
    prevPageUrl = json['prev_page_url'];
    to = json['to']?? 0;
    total = json['total']?? 0;
  }
}



class Product {
  late int? id;
  late dynamic price;
  late dynamic oldPrice;
  late int? discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'] ?? 0;
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
