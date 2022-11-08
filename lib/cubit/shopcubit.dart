import 'package:ecom/Screen/category_screen.dart';
import 'package:ecom/Screen/fav_screen.dart';
import 'package:ecom/Screen/products_screen.dart';
import 'package:ecom/Screen/setting_screen.dart';
import 'package:ecom/contsant.dart';
import 'package:ecom/cubit/shopstates.dart';
import 'package:ecom/model/LoginModel.dart';
import 'package:ecom/model/categoriesModel.dart';
import 'package:ecom/model/changeFavModel.dart';
import 'package:ecom/model/dio_helper.dart';
import 'package:ecom/model/favoritesModel.dart';
import 'package:ecom/model/fullprintmodel.dart';
import 'package:ecom/model/homeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIniatialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    products_screen(),
    categorys_screen(),
    fav_screen(),
    setting_screen()
  ];

  void changedBottom(int index) {
    currentIndex = index;
    emit(ShopChangedIndexNavStates());
  }

  late homeModel? homemodel = null;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    dioHelper
        .getData(
      url: 'home',
      token: token,
    )
        .then((value) {
      homemodel = homeModel.formjson(value.data);

      // printFulltext(homemodel!.data.banners.toString()); //banners[0]['image']
      // print(homemodel!.status);

      homemodel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      //print(homemodel.toString());
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrHomeDataStates());
    });
  }

  late catrgoriesModel? categoriesmodel = null; //= null

  void getCategoriesData() {
    dioHelper
        .getData(
      url: 'categories',
      token: token,
    )
        .then((value) {
      categoriesmodel = catrgoriesModel.fromjson(value.data);

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(' Error from categories ' + error.toString());
      emit(ShopErorrCategoriesStates());
    });
  }

  late changeFavModel changefavmodel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[
        productId]!; // when the user press favorite icon the color will change jsut now and the post method will run after that and if error happend will said that to user and reurn the old color
    emit(ShopChangeFavoritesStates());

    // late bool? fav  ;  Another way

    //  fav = favorites[productId];
    // if (fav != null) {
    //   favorites[productId] =
    //       !fav!; // when the user press favorite icon the color will change jsut now and the post method will run after that and if error happend will said that to user and reurn the old color
    //   emit(ShopChangeFavoritesStates());
    // }

    dioHelper
        .postData(
      url: 'favorites',
      data: {'product_id': productId},
      token: token,
    )
        .then((value) {
      changefavmodel = changeFavModel.fromjson(value.data);
      print(value.data);

      if (!changefavmodel.status) {
        favorites[productId] = !favorites[
            productId]!; // if error happend will get the previos color for favorite icon
        // if (fav != null) {
        //    fav = favorites[productId];
        //   favorites[productId] =
        //       !fav!;
        // }
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesStates(changefavmodel));
    }).catchError((error) {
      print('error form change Fav ' + error);
      favorites[productId] = !favorites[
          productId]!; // if error happend will get the previos color for favorite icon
      // if (fav != null) {
      //   fav = favorites[productId];
      //   favorites[productId] =
      //       !fav!;
      // }
      emit(ShopErorrChangeFavoritesStates());
    });
  }

  late favoritesModel? favoritesmodel = null;

  void getFavorites() {
    emit(ShopLoadingGetFavoriesStates());

    dioHelper
        .getData(
      url: 'favorites',
      token: token,
    )
        .then((value) {
      favoritesmodel = favoritesModel.fromJson(value.data);
      printFulltext(value.data.toString());
      emit(ShopSuccessGetFavoriesStates());
    }).catchError((error) {
      print(' Error from categories ' + error.toString());
      emit(ShopErorrGetFavoriesStates());
    });
  }

  late LoginModel? userModel = null;

  void getUserData() {
    //print(" tokkennnnnnnnnnnnnnnnnnn" + token) ;

    emit(ShopLoadingGetUserDataStates());

    dioHelper
        .getData(
      url: 'profile',
      token: token,
    )
        .then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(" name is " + userModel!.data!.name);

      //printFulltext(userModel.data!.name);
      emit(ShopSuccessGetUserDataStates(userModel!));
    }).catchError((error) {
      print(' Error from Get Data userrrrrrrrr ' + error.toString());
      emit(ShopErorrGetUserDataStates());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    //print(" tokkennnnnnnnnnnnnnnnnnn" + token) ;

    emit(ShopLoadingUpdateUserDataStates());

    dioHelper.putData(
      url: 'update-profile',
      token: token,
      data: {
        'name' : name,
        'email' : email ,
        'phone' : phone
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(" name is " + userModel!.data!.name);

      //printFulltext(userModel.data!.name);
      emit(ShopSuccessUpdateUserDataStates(userModel!));
    }).catchError((error) {
      print(' Error from Get Data userrrrrrrrr ' + error.toString());
      emit(ShopErorrUpdateUserDataStates());
    });
  }
}
