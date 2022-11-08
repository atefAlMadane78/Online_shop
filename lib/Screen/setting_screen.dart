import 'package:ecom/Screen/Login_screen.dart';
import 'package:ecom/cubit/shopcubit.dart';
import 'package:ecom/cubit/shopstates.dart';
import 'package:ecom/model/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class setting_screen extends StatelessWidget {
  // const setting_screen({ Key? key }) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneCotroller = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneCotroller.text = model.data!.phone;

        return ShopCubit.get(context).userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserDataStates)
                      const LinearProgressIndicator(),
                      const SizedBox(height: 30.0,),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name should not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefix: Icon(Icons.person),
                          label: Text('Name'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email should not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefix: Icon(Icons.email),
                          label: Text('Email Address'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: phoneCotroller,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number should not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefix: Icon(Icons.phone),
                          label: Text('Phone Number'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              cacheHelper
                                  .removeData(key: 'token')
                                  .then((value) {
                                if (value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Login_screen()));
                                }
                              });
                            },
                            child: const Text("Log Out "),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()){
                                 ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneCotroller.text,
                                );
                              } 
                               
                            },
                            child: const Text("Update"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
