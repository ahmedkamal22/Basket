import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/favourites/favourites_model.dart';
import 'package:shop/modules/products/product_details.dart';
import 'package:shop/shared/components/components.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        // dynamic amount = cubit.favouritesModel!.data!.data[cubit.currentIndex].product!.price *
        //     cubit.favouritesModel!.data!.data.length
        // ;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ConditionalBuilder(
                condition: cubit.favouritesModel!.data!.data.isNotEmpty,
                builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            navigateTo(
                                context: context,
                                widget: ProductDetails(
                                    cubit.homeModel!.data!.products[index],
                                    index));
                          },
                          child: buildFavItem(
                              cubit.favouritesModel!.data!.data[index].product!,
                              context),
                        ),
                    separatorBuilder: (context, index) => lineDivider(),
                    itemCount: cubit.favouritesModel!.data!.data.length),
                fallback: (context) => Container(
                  height: 450,
                  width: double.infinity,
                  child: testScreen(
                      text: "You don't have favourite items",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: ShopCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          )),
                ),
              ),
              if (cubit.favouritesModel!.data!.data.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                      onPressed: () {
                        cubit.makePayment(context,
                            "${cubit.favouritesModel!.data!.data[cubit.currentIndex].product!.price * cubit.favouritesModel!.data!.data.length}");
                      },
                      text: "Pay",
                      radius: 20.0),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFavItem(ProductData model, context) => Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          ShopCubit.get(context).changeFavourites(model.id!);
        },
        child: Container(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                        "${model.image}",
                      ),
                      height: 140,
                      width: 120,
                    ),
                    if (model.discount != 0)
                      Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 10.0, end: 10.0),
                          child: Text(
                            "Discount",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${model.name}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            height: 1.2,
                            color: ShopCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (model.discount == 0) Spacer(),
                      Text(
                        "${model.price.round()}EGP",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16, color: Colors.blue),
                      ),
                      if (model.discount != 0) Spacer(),
                      if (model.discount != 0)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 5),
                              if (model.discount != 0)
                                Text(
                                  "${model.oldPrice.round()}EGP",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              Spacer(),
                              if (model.discount != 0)
                                Text(
                                  "${model.discount}% OFF",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
