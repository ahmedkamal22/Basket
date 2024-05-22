import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';

navigateTo({required BuildContext context, required Widget widget}) =>
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            }));

navigateAndFinish({required context, required widget}) =>
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            }),
        (route) => false);

defaultTextButton({
  required VoidCallback onPressed,
  TextStyle? style,
  required String text,
  bool isUpper = false,
}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: style,
        ));

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  double radius = 0.0,
  required VoidCallback onPressed,
  required String text,
  bool isUpper = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            isUpper ? text.toUpperCase() : text,
            style: TextStyle(color: Colors.white),
          )),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  required Color? generalWidgetsColor,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  VoidCallback? onTap,
  TextStyle? style,
  IconData? suffix,
  double radius = 0.0,
  bool isUpper = false,
  VoidCallback? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      validator: validate,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: isPassword,
      style: style,
      //this for changing input color
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: generalWidgetsColor!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: generalWidgetsColor,
          ),
        ),
        //this for changing border color
        fillColor: generalWidgetsColor,
        //this for changing border color
        labelText: isUpper ? label.toUpperCase() : label,
        labelStyle: style,
        //this for changing label color
        prefixIcon: Icon(
          prefix,
          color: generalWidgetsColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: generalWidgetsColor,
                ),
              )
            : null,
      ),
    );

Widget lineDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
    );

Widget testScreen({
  required String text,
  TextStyle? style,
}) =>
    Center(
      child: Text("$text", style: style),
    );

showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { Success, Error, Warning }

changeColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

signOut({
  required context,
}) {
  CacheHelper.signOut(key: "token").then((value) {
    navigateAndFinish(context: context, widget: LoginScreen());
  });
}

Widget customDrawer({required context, required Function() settingsNavigation}) =>
    Drawer(
        width: MediaQuery.of(context).size.width / 1.5,
        shadowColor: Colors.white,
        backgroundColor: HexColor("333739"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(20),
            bottomEnd: Radius.circular(10),
          ),
        ),
        child: Column(children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            curve: Curves.fastEaseInToSlowEaseOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  defaultColor,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(.5),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 48,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Basket",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          defaultListTile(
            context: context,
            icon: Icons.settings,
            text: "Settings",
            onTap: settingsNavigation,
          ),
        ]));

Widget defaultListTile({
  required context,
  required IconData icon,
  required String text,
  required Function()? onTap,
}) =>
    ListTile(
      leading: Icon(icon,
          size: 30, color: Colors.white),
      title: Text(text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
      hoverColor: Colors.blue,
      onTap: onTap,
    );

Widget defaultSwitchListTile({
  required context,
  required bool value,
  required Function(bool)? onChanged,
  required String text,
  required String subtitle,
}) =>
    SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ShopCubit.get(context).isDark?Colors.white:Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: ShopCubit.get(context).isDark?Colors.white:Colors.black,
            fontSize: 16
        ),
      ),
      activeColor: defaultColor,
      contentPadding: const EdgeInsetsDirectional.only(
        start: 34,
        end: 22,
      ),
    );

