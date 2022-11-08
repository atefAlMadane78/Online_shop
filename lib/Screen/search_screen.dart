import 'package:ecom/cubit/searchState.dart';
import 'package:ecom/cubit/searchcubit.dart';
import 'package:ecom/cubit/shopcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class search_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchCubit(),
      child: BlocConsumer<searchCubit, serachState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(backgroundColor: Colors.white,),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (String value) {
                          searchCubit.get(context).search(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter text to search  ';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefix: Icon(Icons.search),
                          label: Text('Serach'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      if(state is SearchSuccesslState)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildFavItem(
                                searchCubit.get(context)
                                    .model!
                                    .data
                                    .data[index],
                                context),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15.0,
                                ),
                            itemCount: searchCubit.get(context)
                                .model!
                                .data
                                .data
                                .length),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
  
  Widget buildFavItem( model, context) => Padding(
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
                      model.image,
                    ),
                    width: 120.0,
                    //fit: BoxFit.cover,
                    height: 120.0,
                  ),
                  if (model.discount != 0.0)
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
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.deepOrange),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.id);
                           // print(model.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]! 
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
