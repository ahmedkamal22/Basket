import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/search/search.dart';
import 'package:shop/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Basket",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: cubit.isDark ? Colors.grey[200] : Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context: context, widget: SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.changeMode();
                  },
                  icon: cubit.isDark
                      ? Icon(Icons.brightness_4_outlined)
                      : Icon(Icons.brightness_4)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.items,
          ),
        );
      },
    );
  }
}
