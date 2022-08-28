import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var userModel = ShopCubit.get(context).userModel!.data;
        nameController.text = userModel!.name!;
        emailController.text = userModel.email!;
        phoneController.text = userModel.phone!;
        Color cubitColor =
            cubit.isDark ? Colors.white : Colors.black.withOpacity(.6);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateProfileLoadingState)
                      Column(
                        children: [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        defaultFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: "Name",
                          prefix: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Name mustn't be empty";
                            }
                            return null;
                          },
                          generalWidgetsColor: cubitColor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: cubitColor, fontSize: 18),
                          radius: 20,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: "Email Address",
                          prefix: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email Address mustn't be empty";
                            }
                            return null;
                          },
                          generalWidgetsColor: cubitColor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: cubitColor, fontSize: 18),
                          radius: 20,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          label: "Phone",
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Phone mustn't be empty";
                            }
                            return null;
                          },
                          generalWidgetsColor: cubitColor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: cubitColor, fontSize: 18),
                          radius: 20,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit
                                  .updateUserProfile(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              )
                                  .then((value) {
                                showToast(
                                    msg: "Updated Successfully",
                                    state: ToastStates.Success);
                              });
                            }
                          },
                          text: "update profile",
                          isUpper: true,
                          radius: 20,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          onPressed: () {
                            signOut(context: context);
                          },
                          text: "log out",
                          isUpper: true,
                          radius: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
