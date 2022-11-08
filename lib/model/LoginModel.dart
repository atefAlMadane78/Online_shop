class LoginModel {
  late bool status;
  late String message;
  late userData?
      data; // to allow put null in it and add condition to sure from him in cubit class line 29

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ;
    message = json['message'] ?? ' ';
    // if (data != null){
    //   data =  userData.fromJson(json['data']) ;
    // }
    data = json['data'] != null
        ? userData.fromJson(json['data'])
        : null; // maybe come without data
  }
}

class userData {
  late int id ;
  late String email, name, phone, image;
  late int? points, credit;
  late String token;

  // userData({
  //   required this.id,
  //   required this.email,
  //   required this.name,
  //   required this.phone,
  //   required this.image,
  //   required this.points,
  //   required this.credit,
  //   required this.token,
  // });

// named constructor
  userData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'] ?? 0 ;
    credit = json['credit'] ?? 0 ; 
    token = json['token'];
  }
}
