import 'package:ecom/cubit/shopcubit.dart';
import 'package:ecom/model/favoritesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/shopstates.dart';

class fav_screen extends StatelessWidget {
  const fav_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favorites.length != 0  ? ///state is !ShopLoadingGetFavoriesStates  that go wrong because there are many state come follow in a stream from state and the state will change and that causer error empty array
         ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context).favoritesmodel!.data.data[index],
                context),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 15.0,
                ),
            itemCount: ShopCubit.get(context).favoritesmodel!.data.data.length)
            :const Center( child: CircularProgressIndicator(),)
            ;
      },
    );
  }

  Widget buildFavItem(FavData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          width: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      model.product!.image,
                    ),
                    width: 120.0,
                    fit: BoxFit.cover,
                    height: 120.0,
                  ),
                  if (model.product!.discount != 0.0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price.round()}',
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.deepOrange),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice.round()}',
                            style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id);
                           // print(model.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.product!.id]! 
                                    ? Colors.deepOrange
                                    : Colors.grey,
                            radius: 15.0,
                            child: const Icon(
                              Icons.favorite,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
