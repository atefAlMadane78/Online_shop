import 'package:ecom/cubit/shopcubit.dart';
import 'package:ecom/cubit/shopstates.dart';
import 'package:ecom/model/categoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class categorys_screen extends StatelessWidget {
  const categorys_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesmodel!.data.data[index]),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 15.0,
                ),
            itemCount:
                ShopCubit.get(context).categoriesmodel!.data.data.length);
      },
    );
  }

  Widget buildCatItem(dataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
      );
}
