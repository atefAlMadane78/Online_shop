import 'package:ecom/cubit/registerState.dart';
import 'package:ecom/cubit/states.dart';
import 'package:ecom/model/LoginModel.dart';
import 'package:ecom/model/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialStates());
  
  static ShopRegisterCubit get (context) => BlocProvider.of(context) ;

  late LoginModel Register ;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone
  }){

    emit(ShopRegisterLoadingStates());

    dioHelper.postData(url: 'register', data: {
      'name':name,
      'email': email ,
      'password' : password,
      'phone' : phone
    },).then((value) {
      print(value.data);
      Register = LoginModel.fromJson(value.data);
      // if( Register.data != null){ // add this condition to sure there is a value in and i add ? in line 4 in RegisterModel class
      //   print(Register.data!.email);
      // }
      // print(Register.message);
      emit(ShopRegisterSuccessStates(Register));
    }).catchError((error){
      print(" Erorrrrrrrrrrrrrrrrrr RegisterCubit " +error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }

  IconData suffix =  Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changedPasswordVisibilty(){
    isPasswordShown = !isPasswordShown;

    suffix =  isPasswordShown ? Icons.visibility_outlined: Icons.visibility_off_outlined ;
    
    emit(ShopRegChangePasswordVisStates());
  }


}