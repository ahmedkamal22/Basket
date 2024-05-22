import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/search/search.dart';
import 'package:shop/modules/settings/settings_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';

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
                  icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Colors.transparent,
            backgroundColor: defaultColor,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.fastEaseInToSlowEaseOut,
            index: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.items,
          ),
          drawer: customDrawer(context: context, settingsNavigation: (){
            navigateTo(context: context, widget: SettingsScreen());
          }),
        );
      },
    );
  }
}
