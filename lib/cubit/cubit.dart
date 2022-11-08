import 'package:ecom/cubit/states.dart';
import 'package:ecom/model/LoginModel.dart';
import 'package:ecom/model/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialStates());
  
  static ShopLoginCubit get (context) => BlocProvider.of(context) ;

  late LoginModel login ;

  void userLogin({
    required String email,
    required String password
  }){

    emit(ShopLoginLoadingStates());

    dioHelper.postData(url: 'login', data: {
      'email': email ,
      'password' : password
    },).then((value) {
      print(value.data);
      login = LoginModel.fromJson(value.data);
      // if( login.data != null){ // add this condition to sure there is a value in and i add ? in line 4 in loginModel class
      //   print(login.data!.email);
      // }
      // print(login.message);
      emit(ShopLoginSuccessStates(login));
    }).catchError((error){
      print(" Erorrrrrrrrrrrrrrrrrr " +error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix =  Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changedPasswordVisibilty(){
    isPasswordShown = !isPasswordShown;

    suffix =  isPasswordShown ? Icons.visibility_outlined: Icons.visibility_off_outlined ;
    
    emit(ShopChangePasswordVisStates());
  }


}