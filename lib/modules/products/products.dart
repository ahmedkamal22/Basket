import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories/categories.dart';
import 'package:shop/models/products/home_model.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/modules/products/product_details.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavouritesSuccessState) {
          if (state.changeFavouritesModel.status == false) {
            showToast(
                msg: "${state.changeFavouritesModel.message}",
                state: ToastStates.Error);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => buildProductsItem(
                cubit.homeModel!, cubit.categoriesModel!, context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildProductsItem(
          HomeModel home, CategoriesModel categories, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CarouselSlider(
                items: home.data!.banners
                    .map(
                      (e) => Image(
                        image: e.image == null
                            ? NetworkImage(
                                "https://i.stack.imgur.com/6M513.png")
                            : NetworkImage("${e.image}"),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 25.0,
                          color: ShopCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 120,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(
                            categories.data!.data[index], context),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemCount: categories.data!.data.length),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Text(
                "Products",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 25.0,
                      color: ShopCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 2,
              reverse: true,
              childAspectRatio: 1 / 1.66,
              children: List.generate(
                  home.data!.products.length,
                  (index) => InkWell(
                      onTap: () {
                        navigateTo(
                            context: context,
                            widget: ProductDetails(
                                home.data!.products[index], index));
                      },
                      child:
                          buildGridItem(home.data!.products[index], context))),
            ),
          ],
        ),
      );

  Widget buildGridItem(ProductsModel model, context) => Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            color: ShopCubit.get(context).isDark
                ? HexColor("333739")
                : Colors.white,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
                end: 20.0,
                top: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage("${model.image}", scale: 4),
                        width: double.infinity,
                        height: 200.0,
                      ),
                      if (model.discount != 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.red,
                          child: Text(
                            "Discount",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "${model.name}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: ShopCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                        height: 1.2,
                        fontSize: 17.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0),
                  if (model.discount != 0)
                    Text(
                      "${model.price.round()}EGP",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        "${model.oldPrice.round()}EGP",
                        style: TextStyle(
                            color:
                                model.discount != 0 ? Colors.grey : Colors.blue,
                            fontSize: 16,
                            fontWeight: model.discount != 0
                                ? FontWeight.normal
                                : FontWeight.bold,
                            decoration: model.discount != 0
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      Spacer(),
                      if (model.discount != 0)
                        Text(
                          "${model.discount.round()}% OFF",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      // IconButton(
                      //     padding: EdgeInsets.zero,
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.favorite_border_outlined,
                      //       size: 16,
                      //       color: ShopCubit.get(context).isDark
                      //           ? Colors.grey[100]
                      //           : Colors.black,
                      //     )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (userToken != null) {
                  ShopCubit.get(context).changeFavourites(model.id!);
                } else {
                  navigateTo(context: context, widget: LoginScreen());
                }
              },
              icon: CircleAvatar(
                radius: 16.0,
                backgroundColor: ShopCubit.get(context).favourites[model.id]!
                    ? defaultColor
                    : Colors.grey,
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 15.0,
                  color: Colors.white,
                  //ShopCubit.get(context).isDark ? Colors.white:Colors.black
                ),
              )),
        ],
      );

  Widget buildCategoriesItem(CategoriesData model, context) => Container(
        width: 120,
        height: 120,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.0),
                    topEnd: Radius.circular(20.0)),
                image: DecorationImage(
                  image: NetworkImage("${model.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(.9),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "${model.name}",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      );
}
