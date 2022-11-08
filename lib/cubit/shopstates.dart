import 'package:ecom/model/LoginModel.dart';
import 'package:ecom/model/changeFavModel.dart';

abstract class ShopStates {}

class ShopIniatialStates extends ShopStates {}

class ShopChangedIndexNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErorrHomeDataStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErorrCategoriesStates extends ShopStates {}

class ShopChangeFavoritesStates extends ShopStates {}

class ShopSuccessChangeFavoritesStates extends ShopStates {
  final changeFavModel changefavmodel;

  ShopSuccessChangeFavoritesStates(this.changefavmodel);
}

class ShopErorrChangeFavoritesStates extends ShopStates {}

class ShopLoadingGetFavoriesStates extends ShopStates {}

class ShopSuccessGetFavoriesStates extends ShopStates {}

class ShopErorrGetFavoriesStates extends ShopStates {}

class ShopLoadingGetUserDataStates extends ShopStates {}

class ShopSuccessGetUserDataStates extends ShopStates {
 final LoginModel loginModel;

  ShopSuccessGetUserDataStates(this.loginModel);
}

class ShopErorrGetUserDataStates extends ShopStates {}

class ShopLoadingUpdateUserDataStates extends ShopStates {}

class ShopSuccessUpdateUserDataStates extends ShopStates {
  
 final LoginModel loginModel;

  ShopSuccessUpdateUserDataStates(this.loginModel);
}

class ShopErorrUpdateUserDataStates extends ShopStates {}