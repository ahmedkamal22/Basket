// BlocConsumer<ShopCubit, ShopStates>
// (
// listener: (
// context, state) {},
// builder: (
// context, state) {
// var cubit = ShopCubit.get(context);
// var userModel = ShopCubit
//     .get(context)
//     .userModel!
//     .data;
// nameController.text = userModel!.name!;
// emailController.text = userModel.email!;
// phoneController.text = userModel.phone!;
// Color cubitColor =
// cubit.isDark ? Colors.white : Colors.black.withOpacity(.6);
// return Padding(
// padding: const EdgeInsets.all(20.0),
// child: SingleChildScrollView(
// child: Center(
// child: Form(
// key: formKey,
// child: Column(
// children: [
// if (state is ShopUpdateProfileLoadingState)
// Column(
// children: [
// LinearProgressIndicator(),
// SizedBox(
// height: 60,
// ),
// ],
// ),
// defaultFormField(
// controller: nameController,
// keyboardType: TextInputType.name,
// label: "Name",
// prefix: Icons.person,
// validate: (value) {
// if (value!.isEmpty) {
// return "Name mustn't be empty";
// }
// return null;
// },
// generalWidgetsColor: cubitColor,
// style: Theme
//     .of(context)
//     .textTheme
//     .bodyText1!
//     .copyWith(color: cubitColor, fontSize: 18),
// radius: 20,
// ),
// SizedBox(
// height: 20.0,
// ),
// defaultFormField(
// controller: emailController,
// keyboardType: TextInputType.emailAddress,
// label: "Email Address",
// prefix: Icons.email_outlined,
// validate: (value) {
// if (value!.isEmpty) {
// return "Email Address mustn't be empty";
// }
// return null;
// },
// generalWidgetsColor: cubitColor,
// style: Theme
//     .of(context)
//     .textTheme
//     .bodyText1!
//     .copyWith(color: cubitColor, fontSize: 18),
// radius: 20,
// ),
// SizedBox(
// height: 20.0,
// ),
// defaultFormField(
// controller: phoneController,
// keyboardType: TextInputType.phone,
// label: "Phone",
// prefix: Icons.phone,
// validate: (value) {
// if (value!.isEmpty) {
// return "Phone mustn't be empty";
// }
// return null;
// },
// generalWidgetsColor: cubitColor,
// style: Theme
//     .of(context)
//     .textTheme
//     .bodyText1!
//     .copyWith(color: cubitColor, fontSize: 18),
// radius: 20,
// ),
// SizedBox(
// height: 20.0,
// ),
// defaultButton(
// onPressed: () {
// if (formKey.currentState!.validate()) {
// cubit.updateUserProfile(
// name: nameController.text,
// email: emailController.text,
// phone: phoneController.text,
// ).then((value) {
// showToast(msg: "Updated Successfully",
// state: ToastStates.Success);
// });
// }
// },
// text: "update profile",
// isUpper: true,
// radius: 20,
// ),
// SizedBox(
// height: 20.0,
// ),
// defaultButton(
// onPressed: () {
// signOut(context: context);
// },
// text: "log out",
// isUpper: true,
// radius: 20,
// ),
// ],
// ),
// ),
// ),
// ),
// );
// },
// )
//
//
//
//
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Ahlan! Nice to meet you",
// style: Theme.of(context).textTheme.bodyText1!.copyWith(
// height: 1.3,
// color: cubitColor
// ),
// ),
// Text(
// "The region's favourite online marketplace",
// style: Theme.of(context).textTheme.bodyText1!.copyWith(
// height: 1.3,
// color: Colors.grey,
// fontSize: 15.0,
// ),
// ),
// SizedBox(
// height: 15,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Column(
// children: [
// CircleAvatar(
// radius: 25,
// backgroundColor: defaultColor,
// child: IconButton(
// onPressed: () {
// navigateTo(
// context: context,
// widget: LoginScreen());
// },
// icon: Icon(Icons.person)),
// ),
// SizedBox(height: 5,),
// Text(
// "Sign In",
// style: Theme.of(context).textTheme.bodyText1!.copyWith(
// color: cubitColor,
// fontSize: 15.0,
// ),
// ),
// ],
// ),
// SizedBox(
// width: 130,
// ),
// Column(
// children: [
// CircleAvatar(
// radius: 25,
// backgroundColor: defaultColor,
// child: IconButton(
// onPressed: () {
// navigateTo(
// context: context,
// widget: RegisterScreen());
// },
// icon: Icon(Icons.person_add_alt)),
// ),
// SizedBox(height: 5,),
// Text(
// "Sign Up",
// style: Theme.of(context).textTheme.bodyText1!.copyWith(
// color: cubitColor,
// fontSize: 15.0,
// ),
// ),
// ],
// ),
// ],
// ),
// SizedBox(
// height: 20,
// ),
// ],
// )
