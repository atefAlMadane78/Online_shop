import 'package:ecom/Screen/Login_screen.dart';
import 'package:ecom/Screen/search_screen.dart';
import 'package:ecom/cubit/shopcubit.dart';
import 'package:ecom/cubit/shopstates.dart';
import 'package:ecom/model/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class shopLayout_screen extends StatelessWidget {
  const shopLayout_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Sallla'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => search_screen()));
                },
                icon:const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changedBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}


// TextButton(
//           onPressed: () {
            // Sign out code
            // cacheHelper.removeData(key: 'token' ).then((value) {
            //   if(value){
            //     print(cacheHelper.getStringData(key:'token'));
            //      Navigator.pushReplacement(
            //   context, MaterialPageRoute(builder: (context) => Login_screen()));
            //   print('Mission Doneeeeeeeeeeeee');
            //   }
            // });  
//           },
//           child: Text('Sign out '),
//         ),