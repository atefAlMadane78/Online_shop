import 'package:ecom/Screen/shopLayout_screen.dart';
import 'package:ecom/contsant.dart';
import 'package:ecom/cubit/registerCubit.dart';
import 'package:ecom/cubit/registerState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecom/model/cacheHelper.dart';

import '../model/toasteColor.dart';

class register_screen extends StatelessWidget {
  const register_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
           if (state is ShopRegisterSuccessStates)
              {
                if (state.RegisterModel.status)
                  {
                    print(state.RegisterModel.data!.token);
                    print(state.RegisterModel.message);
                    cacheHelper
                        .saveData(
                            key: 'token', value: state.RegisterModel.data!.token)
                        .then((value) {
                      token = state.RegisterModel.data!.token;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => shopLayout_screen()));
                    });
                    
                  }
                else
                  {
                    print(state.RegisterModel.message);
                    Fluttertoast.showToast(
                        msg: state.RegisterModel.message,
                        toastLength: Toast.LENGTH_LONG, // for andriod
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5, // for ios
                        backgroundColor: chooseToasteColor(
                            ToasteColor.ERROR), // easy way to dael with colors
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
              }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
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
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Register now to browse our offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefix: Icon(Icons.person),
                            label: Text('USer Name'),
                          ),
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
                              ShopRegisterCubit.get(context).isPasswordShown,
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
                                ShopRegisterCubit.get(context)
                                    .changedPasswordVisibilty();
                              },
                              icon: Icon(ShopRegisterCubit.get(context).suffix),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            // if (formKey.currentState!.validate()) {
                            //   ShopRegisterCubit.get(context).userLogin(
                            //     email: emailController.text,
                            //     password: passwordController.text,
                            //   );
                            // }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefix: Icon(Icons.phone),
                            label: Text('Phone Number'),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        state is! ShopRegisterLoadingStates
                            ? RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                child: Container(
                                  child: const Center(child: Text("REGISTER")),
                                  width: double.infinity,
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
