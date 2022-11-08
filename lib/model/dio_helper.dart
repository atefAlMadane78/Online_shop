import 'package:dio/dio.dart';

class dioHelper {
  static late Dio dio;
  static init() {
    dio = Dio (
      BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/', //'https://newsapi.org/',
      receiveDataWhenStatusError: true,
      
    ));
  }

  static Future<Response> getData({
    required String url,
    //Map<String, dynamic>
     query,
    lang = 'en' ,
      token ,
  }) async {
  //   dio.options = BaseOptions(
  //   headers: {
  //     'lang': lang ,
  //     'Authorization' : token // ?? null
  //   }
  // );

  dio.options.headers ={
     'Content-Type':'application/json',
     'lang': lang ,
      'Authorization' : token ?? ''// ?? null
  };
    return await dio.get(url, queryParameters: query);
  }

static Future<Response> postData(
  {
     required String url,
     query,
     required Map<String, dynamic> data,
      lang = 'en' ,
      token ,
  }
)async{

  // dio.options = BaseOptions(
  //   headers: {
  //     'lang': lang ,
  //     'Authorization' : token // ?? null
  //   }
  // );
  dio.options.headers ={
     'Content-Type':'application/json',
     'lang': lang ,
      'Authorization' : token ?? '' // ?? null
  };

  return dio.post(url ,
  queryParameters: query,
  data: data
   );
}


static Future<Response> putData(
  {
     required String url,
     query,
     required Map<String, dynamic> data,
      lang = 'en' ,
      token ,
  }
)async{

  // dio.options = BaseOptions(
  //   headers: {
  //     'lang': lang ,
  //     'Authorization' : token // ?? null
  //   }
  // );
  dio.options.headers ={
     'Content-Type':'application/json',
     'lang': lang ,
      'Authorization' : token ?? '' // ?? null
  };

  return dio.put(url ,
  queryParameters: query,
  data: data
   );
}
  
}
