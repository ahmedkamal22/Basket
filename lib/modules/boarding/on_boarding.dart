import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/models/boarding/on_boarding.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/locale/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      title: "Welcome to Basket!",
      body: "Your one-stop shop for everything you love.",
      image:
          "https://media.istockphoto.com/photos/shopping-basket-with-fresh-food-grocery-supermarket-food-and-eats-picture-id1216828053?k=20&m=1216828053&s=612x612&w=0&h=mMGSO8bG8aN0gP4wyXC17WDIcf9zcqIxBd-WZto-yeg=",
    ),
    OnBoardingModel(
      title: "Explore Our Categories",
      body: "From electronics to fashion, find it all.",
      image:
          "https://image.shutterstock.com/image-vector/concept-illustration-shop-supermarket-account-260nw-427049824.jpg",
    ),
    OnBoardingModel(
      title: " Exclusive Offers Just for You",
      body: "Save more with our special deals.",
      image:
          "https://media.istockphoto.com/photos/shopping-basket-with-fresh-food-grocery-supermarket-food-and-eats-picture-id1216828053?k=20&m=1216828053&s=612x612&w=0&h=mMGSO8bG8aN0gP4wyXC17WDIcf9zcqIxBd-WZto-yeg=",
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: "Boarding", value: true).then((value) {
      if (value) {
        navigateAndFinish(context: context, widget: LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: () {
              submit();
            },
            text: "skip",
            isUpper: true,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: defaultColor, fontSize: 16),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(context, boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: SlideEffect(
                      spacing: 8.0,
                      radius: 20.0,
                      dotWidth: 24.0,
                      dotHeight: 16.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 700,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  mini: true,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(context, OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage("${model.image}"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "${model.title}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 25,
                color: ShopCubit.get(context).isDark
                    ? Colors.white
                    : Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.normal,
                color: ShopCubit.get(context).isDark
                    ? Colors.white
                    : Colors.black),
          ),
        ],
      );
}
