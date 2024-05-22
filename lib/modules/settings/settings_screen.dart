import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/layout/home.dart';
import 'package:shop/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings Screen"),
            leading: IconButton(
                onPressed: () {
                  navigateAndFinish(context: context, widget: const HomeScreen());
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Column(
              children: [
                defaultSwitchListTile(
                  context: context,
                  value: cubit.isDark,
                  onChanged: (value) {
                    cubit.changeMode();
                  },
                  text: "Change Mode",
                  subtitle: "Swap between b&w themes .",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
