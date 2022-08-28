import 'package:shop/models/login/login.dart';

abstract class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginFailureState extends LoginStates {
  final String error;

  LoginFailureState(this.error);
}

class LoginChangeSuffixState extends LoginStates {}
