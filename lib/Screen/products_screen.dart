import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/cubit/shopcubit.dart';
import 'package:ecom/cubit/shopstates.dart';
import 'package:ecom/model/categoriesModel.dart';
import 'package:ecom/model/homeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/toasteColor.dart';

class products_screen extends StatelessWidget {
  const products_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  return Container();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesStates) {
          if (!state.changefavmodel.status) {
            Fluttertoast.showToast(
                msg: state.changefavmodel.message,
                toastLength: Toast.LENGTH_LONG, // for andriod
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5, // for ios
                backgroundColor: chooseToasteColor(
                    ToasteColor.ERROR), // easy way to dael with colors
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: state.changefavmodel.message,
                toastLength: Toast.LENGTH_LONG, // for andriod
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5, // for ios
                backgroundColor: chooseToasteColor(
                    ToasteColor.SUCCESS), // easy way to dael with colors
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return ShopCubit.get(context).homemodel != null &&
                ShopCubit.get(context).categoriesmodel != null
            ? productBilder(ShopCubit.get(context).homemodel,
                ShopCubit.get(context).categoriesmodel, context)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget productBilder(
          homeModel? model, catrgoriesModel? categories, context) =>
      SingleChildScrollView(
        // 1 -add this
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction:
                      1.0 // put one image in slider if but 0.5 will put 2 image in slider

                  ),
              items: model!.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategories(categories!.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categories!.data.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // Expanded(
            // child: 2 -remove expanded
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true, // 3- add this line and line below
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2, // put 2 element in line
                mainAxisSpacing: 1.0, // add space between elements  -up down
                crossAxisSpacing: 1.0, // -left right
                childAspectRatio: 1 / 1.6, // width / height
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
            // ),
          ],
        ),
      );

  Widget buildCategories(dataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          // FadeInImage(
          //   image: NetworkImage(
          //     model.image,
          //   ),
          //   width: 100.0,
          //   height: 100.0,
          //   placeholder: const AssetImage("assets/images/onboard2.jfif"),
          //   imageErrorBuilder: (context, error, stackTrace) {
          //     return Image.asset(
          //       'assets/images/onboard3.jfif',
          //     );
          //   },
          //   fit: BoxFit.fitWidth,
          // ),
          Container(
            width: 100.0,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            color: Colors.black.withOpacity(.8),
          ),
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  width: double.infinity,
                  // fit: BoxFit.cover,
                  height: 200.0,
                  // errorBuilder: (BuildContext context, Object exception,
                  //     StackTrace? stackTrace) {
                  //   return const Text('😢');
                  // },
                ),
               
                if (model.discountl != 0.0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
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
                      if (model.discountl != 0)
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
                          ShopCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id] ??
                                      false
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
      );
}

//model!.data.banners.map((e) => Image(image: NetworkImage(e.image),

/*
Image(
      image: NetworkImageWithRetry(
      'http://ImageUrl.png',),
      errorBuilder: (context, exception, stackTrack) => Icon(Icons.error,),
      loadingBuilder: (context, exception, stackTrack) => CircularProgressIndicator(),
    )
 */