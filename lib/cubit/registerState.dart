import 'package:ecom/model/LoginModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
  final LoginModel RegisterModel;

  ShopRegisterSuccessStates(this.RegisterModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorStates(this.error);
}

class ShopRegChangePasswordVisStates extends ShopRegisterStates {}
