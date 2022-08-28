import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login/login.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterLoadingState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginModel registerModel;

  userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(key: Register, lang: "en", data: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    }).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterFailureState(error.toString()));
    });
  }

  bool isPasswordShown = true;
  IconData suffixIcon = Icons.visibility;

  changeSuffix() {
    isPasswordShown = !isPasswordShown;
    isPasswordShown
        ? suffixIcon = Icons.visibility
        : suffixIcon = Icons.visibility_off;
    emit(RegisterChangeSuffixState());
  }
}
