import 'package:bloc/bloc.dart';
import 'package:ecom/contsant.dart';
import 'package:ecom/cubit/searchState.dart';
import 'package:ecom/model/dio_helper.dart';
import 'package:ecom/model/searchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class searchCubit extends Cubit<serachState> {
  searchCubit() : super(SearchInatialState());

  static searchCubit get(context) => BlocProvider.of(context);

  late searchModel? model = null;

  void search(String text) {
              emit(SearchLoadingState());

    dioHelper
        .postData(
          url: 'products/search',
          data: {'text': text},
          token: token
        )
        .then((value) {
          model =searchModel.fromJson(value.data);
          emit(SearchSuccesslState());
        })
        .catchError((error) {
          print('Error form SearchCubittttttttt' + error.toString());
          emit(SearchErrorState());
        });
  }
}
