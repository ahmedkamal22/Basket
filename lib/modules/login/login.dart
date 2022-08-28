import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/home.dart';
import 'package:shop/modules/login/cubit/cubit.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/modules/register/register.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                if (state.loginModel.status == true) {
                  CacheHelper.saveData(
                          key: "token", value: state.loginModel.data!.token)
                      .then((value) {
                    userToken = state.loginModel.data!.token!;
                    ShopCubit.get(context).getUserProfile();
                    navigateAndFinish(context: context, widget: HomeScreen());
                  });
                } else {
                  showToast(
                      msg: "${state.loginModel.message}",
                      state: ToastStates.Error);
                }
              }
            },
            builder: (context, state) {
              var cubit = LoginCubit.get(context);
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 35,
                                    color: ShopCubit.get(context).isDark
                                        ? Colors.grey[200]
                                        : Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Login now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          defaultFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Email mustn't be empty!!";
                              }
                              return null;
                            },
                            radius: 20.0,
                            generalWidgetsColor: ShopCubit.get(context).isDark
                                ? Colors.grey[200]
                                : Colors.black.withOpacity(.7),
                            style: TextStyle(
                              color: ShopCubit.get(context).isDark
                                  ? Colors.grey[200]
                                  : Colors.black.withOpacity(.6),
                            ),
                          ),
                          SizedBox(height: 20),
                          defaultFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: cubit.isPasswordShown,
                            suffixPressed: () {
                              cubit.changeSuffix();
                            },
                            label: "Password",
                            prefix: Icons.lock,
                            suffix: cubit.suffixIcon,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password mustn't be empty!!";
                              }
                              return null;
                            },
                            radius: 20.0,
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            generalWidgetsColor: ShopCubit.get(context).isDark
                                ? Colors.grey[200]
                                : Colors.black.withOpacity(.6),
                            style: TextStyle(
                                color: ShopCubit.get(context).isDark
                                    ? Colors.grey[200]
                                    : Colors.black.withOpacity(.6)),
                          ),
                          SizedBox(height: 25),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: "login",
                              isUpper: true,
                              radius: 20.0,
                            ),
                            fallback: (context) => state is LoginLoadingState
                                ? defaultButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text: "login",
                                    isUpper: true,
                                    radius: 20.0,
                                  )
                                : (Center(child: CircularProgressIndicator())),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 15,
                                        color: ShopCubit.get(context).isDark
                                            ? Colors.grey[200]
                                            : Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              defaultTextButton(
                                onPressed: () {
                                  navigateTo(
                                      context: context,
                                      widget: RegisterScreen());
                                },
                                text: "register",
                                isUpper: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15, color: Colors.blue),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
