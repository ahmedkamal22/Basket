import 'package:shop/models/favourites/change_favourites_model.dart';
import 'package:shop/models/login/login.dart';
import 'package:shop/models/search/search.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeModeState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeFailureState extends ShopStates {
  final String error;

  ShopHomeFailureState(this.error);
}

class ShopCategoriesLoadingState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesFailureState extends ShopStates {
  final String error;

  ShopCategoriesFailureState(this.error);
}

class ShopChangeFavouritesSuccessState extends ShopStates {
  ChangeFavouritesModel changeFavouritesModel;

  ShopChangeFavouritesSuccessState(this.changeFavouritesModel);
}

class ShopChangeFavSuccessState extends ShopStates {}

class ShopChangeFavouritesFailureState extends ShopStates {
  final String error;

  ShopChangeFavouritesFailureState(this.error);
}

class ShopGetFavouritesLoadingState extends ShopStates {}

class ShopGetFavouritesSuccessState extends ShopStates {}

class ShopGetFavouritesFailureState extends ShopStates {
  final String error;

  ShopGetFavouritesFailureState(this.error);
}

class ShopGetProfileLoadingState extends ShopStates {}

class ShopGetProfileSuccessState extends ShopStates {
  final LoginModel userModel;

  ShopGetProfileSuccessState(this.userModel);
}

class ShopGetProfileFailureState extends ShopStates {
  final String error;

  ShopGetProfileFailureState(this.error);
}

class ShopUpdateProfileLoadingState extends ShopStates {}

class ShopUpdateProfileSuccessState extends ShopStates {
  final LoginModel userModel;

  ShopUpdateProfileSuccessState(this.userModel);
}

class ShopUpdateProfileFailureState extends ShopStates {
  final String error;

  ShopUpdateProfileFailureState(this.error);
}

class ShopSearchLoadingState extends ShopStates {}

class ShopSearchSuccessState extends ShopStates {
  final SearchModel searchModel;

  ShopSearchSuccessState(this.searchModel);
}

class ShopSearchFailureState extends ShopStates {
  final String error;

  ShopSearchFailureState(this.error);
}
