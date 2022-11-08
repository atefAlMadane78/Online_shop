class changeFavModel{
  late bool status ;
  late String message;

  changeFavModel.fromjson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}