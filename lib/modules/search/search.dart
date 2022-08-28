import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/search/search.dart';
import 'package:shop/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        Color cubitColor =
            cubit.isDark ? Colors.white : Colors.black.withOpacity(.6);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  label: "Search",
                  prefix: Icons.search,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Type your desired word to be searched";
                    }
                    return null;
                  },
                  generalWidgetsColor: cubitColor,
                  radius: 20.0,
                  style: TextStyle(color: cubitColor),
                  onChanged: (text) {
                    cubit.getSearchData(text: text);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (state is ShopSearchLoadingState) LinearProgressIndicator(),
                if (state is ShopSearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildSearchItem(
                            context, cubit.searchModel!.data!.data[index]),
                        separatorBuilder: (context, index) => lineDivider(),
                        itemCount: cubit.searchModel!.data!.data.length),
                  ),
                if (state is ShopSearchFailureState)
                  testScreen(
                      text: "Not Found!!!!!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: cubitColor)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchItem(context, SearchData model) => Container(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Image(
                image: NetworkImage(
                  "${model.image}",
                ),
                height: 140,
                width: 120,
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
                    Spacer(),
                    Text(
                      "${model.price.round()}EGP",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
