import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories/categories.dart';
import 'package:shop/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryListItems(
                  cubit.categoriesModel!.data!.data[index], context),
              separatorBuilder: (context, index) => lineDivider(),
              itemCount: cubit.categoriesModel!.data!.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCategoryListItems(CategoriesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: NetworkImage("${model.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                "${model.name!.toUpperCase()}",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: ShopCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
}
