import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/products/home_model.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatelessWidget {
  ProductsModel product;

  ProductDetails(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, index) {},
      builder: (context, index) {
        var cubit = ShopCubit.get(context);
        var model = product;
        Color cubitColor = cubit.isDark ? Colors.white : Colors.black;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${model.id}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Hero(
                          tag: "${model.id}",
                          child: FadeInImage(
                            fadeInCurve: Curves.fastLinearToSlowEaseIn,
                            placeholder: MemoryImage(kTransparentImage),
                            image: NetworkImage("${model.image}"),
                            width: double.infinity,
                            height: 200.0,
                          ),
                        ),
                        if (model.discount != 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
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
                    const SizedBox(
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
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            cubit.changeFavourites(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor: cubit.favourites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
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
                          const Spacer(),
                          Text(
                            "${model.discount}% OFF",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.green,
                                    ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: cubitColor, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
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
