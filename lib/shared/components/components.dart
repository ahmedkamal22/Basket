import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';

navigateTo({required BuildContext context, required Widget widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

navigateAndFinish({required context, required widget}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

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
