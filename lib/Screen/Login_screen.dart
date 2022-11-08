import 'package:ecom/Screen/register_screen.dart';
import 'package:ecom/Screen/shopLayout_screen.dart';
import 'package:ecom/cubit/cubit.dart';
import 'package:ecom/cubit/states.dart';
import 'package:ecom/model/cacheHelper.dart';
import 'package:ecom/model/toasteColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../contsant.dart';

class Login_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) => {
            if (state is ShopLoginSuccessStates)
              {
                if (state.loginModel.status)
                  {
                    print(state.loginModel.data!.token),
                    print(state.loginModel.message),
                    cacheHelper
                        .saveData(
                            key: 'token', value: state.loginModel.data!.token)
                        .then((value) {
                      token = state.loginModel.data!.token;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => shopLayout_screen()));
                    })
                    // Fluttertoast.showToast(
                    //     msg: state.loginModel.message,
                    //     toastLength: Toast.LENGTH_LONG, // for andriod
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 5, // for ios
                    //     backgroundColor: chooseToasteColor(ToasteColor.SUCCESS),
                    //     textColor: Colors.white,
                    //     fontSize: 16.0),
                  }
                else
                  {
                    print(state.loginModel.message),
                    Fluttertoast.showToast(
                        msg: state.loginModel.message,
                        toastLength: Toast.LENGTH_LONG, // for andriod
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5, // for ios
                        backgroundColor: chooseToasteColor(
                            ToasteColor.ERROR), // easy way to dael with colors
                        textColor: Colors.white,
                        fontSize: 16.0),
                  }
              }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            "login now to browse our offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              prefix: Icon(Icons.email_outlined),
                              label: Text('Email'),
                            ),
                          ),
                          TextFormField(
                            obscureText:
                                ShopLoginCubit.get(context).isPasswordShown,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefix: const Icon(Icons.lock),
                              label: const Text('Password'),
                              suffix: IconButton(
                                onPressed: () {
                                  ShopLoginCubit.get(context)
                                      .changedPasswordVisibilty();
                                },
                                icon: Icon(ShopLoginCubit.get(context).suffix),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          state is! ShopLoginLoadingStates
                              ? RaisedButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  child: Container(
                                    child: const Center(child: Text("LOGIN")),
                                    width: double.infinity,
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Dont\' have an account ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                register_screen()));
                                  },
                                  child: Text('Register'.toUpperCase()))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
