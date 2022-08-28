import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/home.dart';
import 'package:shop/modules/register/cubit/cubit.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                if (state.loginModel.status == true) {
                  CacheHelper.saveData(
                          key: "token", value: state.loginModel.data!.token)
                      .then((value) {
                    userToken = state.loginModel.data!.token!;
                    ShopCubit.get(context).getUserProfile();
                    ShopCubit.get(context).updateUserProfile(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text);
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
              var cubit = RegisterCubit.get(context);
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
                            "Register",
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
                            "Register now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          defaultFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: "Name",
                            prefix: Icons.person,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Name mustn't be empty!!";
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Email Address mustn't be empty!!";
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
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            label: "Phone",
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Phone mustn't be empty!!";
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
                                cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
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
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: "register",
                              isUpper: true,
                              radius: 20.0,
                            ),
                            fallback: (context) => state is RegisterLoadingState
                                ? defaultButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text: "register",
                                    isUpper: true,
                                    radius: 20.0,
                                  )
                                : (Center(child: CircularProgressIndicator())),
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
