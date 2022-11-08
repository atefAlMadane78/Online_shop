import 'package:bloc/bloc.dart';
import 'package:ecom/Screen/Login_screen.dart';
import 'package:ecom/Screen/onBoarding_screen.dart';
import 'package:ecom/Screen/shopLayout_screen.dart';
import 'package:ecom/cubit/cubit.dart';
import 'package:ecom/cubit/shopcubit.dart';
import 'package:ecom/cubit/shopstates.dart';
import 'package:ecom/model/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './model/dio_helper.dart';
import 'contsant.dart';
import 'cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  dioHelper.init();
  await cacheHelper.init();

  Widget widget;
  bool onboarding = cacheHelper.getBoolData(key: 'onBoarding');
   token = cacheHelper.getStringData(key: 'token');
  print(onboarding);

  if (onboarding != false) {
    // here and line below
    if (token != '') {
      // i put this value in cacheHelper in line 26 & 34 where value cant be null for that i give it a value different null and here i compare with as i want
      widget = const shopLayout_screen();
    } else {
      widget = Login_screen();
    }
  } else {
    widget = onBoarding_screen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatefulWidget {
  // MyApp({Key? key}) : super(key: key);
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
/*@override
  void didChangeDependencies() {
    Provider.of<themeprovider>(context, listen:false ).getThemeMode();
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),
        ),
        // BlocProvider(
        //   create: (context) => ShopLoginCubit(),
        // )
      ],
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "PRo 5",
            theme: ThemeData(
              backgroundColor: Colors.white,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              //dialogBackgroundColor: Colors.white70,
              appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  //color: Colors.white, //Color.fromARGB(255, 194, 86, 204),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.orange,
                  elevation: 20.0),
              // floatingActionButtonTheme: const FloatingActionButtonThemeData(
              //     backgroundColor: Colors.deepOrange),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              // scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  // backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    //statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.orange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  //backgroundColor: HexColor('333739')),
                  //  floatingActionButtonTheme:  FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            home: widget.startWidget,
            //widget.onBoarding? Login_screen() : const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* @override
  void initState() {
    
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFD902EE),
      // ),
      body: onBoarding_screen(),
    );
  }
}
