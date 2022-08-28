import 'package:shop/models/login/login.dart';

abstract class RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterFailureState extends RegisterStates {
  final String error;

  RegisterFailureState(this.error);
}

class RegisterChangeSuffixState extends RegisterStates {}
