import 'dart:convert';

import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories/categories.dart';
import 'package:shop/models/favourites/change_favourites_model.dart';
import 'package:shop/models/favourites/favourites_model.dart';
import 'package:shop/models/login/login.dart';
import 'package:shop/models/products/home_model.dart';
import 'package:shop/models/search/search.dart';
import 'package:shop/modules/account/account.dart';
import 'package:shop/modules/categories/categories.dart';
import 'package:shop/modules/favourites/favourites.dart';
import 'package:shop/modules/products/products.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  changeMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
        emit(ShopChangeModeState());
      });
    }
  }

  int currentIndex = 0;

  changeBottomNav(int index) {
    if (index == 2) {
      getFavouritesData();
    }
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    FavouritesScreen(),
    AccountScreen(),
  ];

  List<CurvedNavigationBarItem> items = [
    CurvedNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    CurvedNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    CurvedNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
    CurvedNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
  ];
  Map<int, bool> favourites = {};
  HomeModel? homeModel;

  getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(key: Home, token: userToken).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.id!: element.inFavourites!});
      });
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeFailureState(error.toString()));
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  changeFavourites(int productID) {
    favourites[productID] = !favourites[productID]!;
    emit(ShopChangeFavSuccessState());
    DioHelper.postData(
            key: Favourites, data: {"product_id": productID}, token: userToken)
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (categoriesModel!.status == false) {
        favourites[productID] = !favourites[productID]!;
      } else {
        getFavouritesData();
      }
      emit(ShopChangeFavouritesSuccessState(changeFavouritesModel!));
    }).catchError((error) {
      favourites[productID] = !favourites[productID]!;
      print(error.toString());
      emit(ShopChangeFavouritesFailureState(error.toString()));
    });
  }

  FavouritesModel? favouritesModel;

  getFavouritesData() {
    emit(ShopGetFavouritesLoadingState());
    DioHelper.getData(key: Favourites, token: userToken).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopGetFavouritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavouritesFailureState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  getCategoriesData() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(key: Categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesFailureState(error.toString()));
    });
  }

  LoginModel? userModel;

  getUserProfile() {
    emit(ShopGetProfileLoadingState());
    DioHelper.getData(key: Profile, token: userToken).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopGetProfileSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileFailureState(error.toString()));
    });
  }

  Future updateUserProfile({
    required String? name,
    required String? email,
    required String? phone,
  }) async {
    emit(ShopUpdateProfileLoadingState());
    await DioHelper.putData(
            key: updateProfile,
            data: {
              "name": name,
              "email": email,
              "phone": phone,
            },
            token: userToken)
        .then((value) {
      userModel = LoginModel.fromJson(value.data);
      getUserProfile();
      emit(ShopUpdateProfileSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileFailureState(error.toString()));
    });
  }

  SearchModel? searchModel;

  getSearchData({required String text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(key: Search, data: {"text": text}, token: userToken)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState(searchModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchFailureState(error.toString()));
    });
  }

  //Payment functions using stripe
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(context, amount) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, 'EGP'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'Kamal'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Paid Successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51L7NLXHjmyadU3ZuYImx0V8m3VjDP66HyzZiz8vrU6zRX86BN04T6Vsf6AicLh6j70AD9EPAtR1Iy3DMAkl86g5o00iimZR7ZS',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
