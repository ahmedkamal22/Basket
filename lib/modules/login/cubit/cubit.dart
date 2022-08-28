import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login/login.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginLoadingState());

  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;

  userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(key: Login, lang: "en", data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailureState(error.toString()));
    });
  }

  bool isPasswordShown = true;
  IconData suffixIcon = Icons.visibility;

  changeSuffix() {
    isPasswordShown = !isPasswordShown;
    isPasswordShown
        ? suffixIcon = Icons.visibility
        : suffixIcon = Icons.visibility_off;
    emit(LoginChangeSuffixState());
  }
}
