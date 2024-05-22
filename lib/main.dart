import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/layout/home.dart';
import 'package:shop/modules/boarding/on_boarding.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripeKey;
  await Stripe.instance.applySettings();
  Bloc.observer = MyBlocObserver();
  DioHelper.getInit();
  await CacheHelper.init();
  Widget widget;
  var boarding = CacheHelper.getData(key: "Boarding");
  var isDark = CacheHelper.getData(key: "isDark");
  userToken ?? CacheHelper.getData(key: "token");
  if (boarding != null) {
    if (userToken != null) {
      widget = const HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final bool? isDark;

  MyApp({this.isDark, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..changeMode(fromShared: isDark)
        ..getHomeData()
        ..getCategoriesData()
        ..getFavouritesData()
        ..getUserProfile(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
