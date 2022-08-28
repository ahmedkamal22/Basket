import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/products/home_model.dart';
import 'package:shop/shared/components/constants.dart';

class ProductDetails extends StatelessWidget {
  ProductsModel product;
  int generalIndex;

  ProductDetails(this.product, this.generalIndex);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, index) {},
      builder: (context, index) {
        var cubit = ShopCubit.get(context);
        var model = cubit.homeModel!.data!.products[generalIndex];
        Color cubitColor = cubit.isDark ? Colors.white : Colors.black;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model.name}",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: cubitColor, height: 1.1, fontSize: 23),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${model.id}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.red),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Image(
                          image: NetworkImage("${model.image}"),
                          height: 200,
                          fit: BoxFit.fitHeight,
                          width: double.infinity,
                        ),
                        if (model.discount != 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(20.0),
                                topEnd: Radius.circular(20.0),
                              ),
                              color: Colors.red,
                            ),
                            child: Text(
                              "Discount",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          "${model.price.round()} EGP",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: defaultColor,
                                  ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            cubit.changeFavourites(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor: cubit.favourites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (model.discount != 0)
                      Row(
                        children: [
                          Text(
                            "${model.oldPrice.round()} EGP",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                          ),
                          Spacer(),
                          Text(
                            "${model.discount}% OFF",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.green,
                                    ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: cubitColor, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadiusDirectional.circular(30.0)),
                      child: Text(
                        "${model.description}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
