import 'package:flutter/material.dart';
import 'package:gogi/constants.dart';
import 'package:gogi/screens/sign_in/sign_in_screen.dart';
import 'package:gogi/size_config.dart';

// This is the best practice
import '../../../DBHelper.dart';
import '../../../SharedPref.dart';
import '../../home/home_screen.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DBHelper dbHelper = DBHelper();

  SharedPref sharedPref = SharedPref();
  bool login = false;
  _BodyState() {
    dbHelper.initDB();
    sharedPref.containsKey("username").then((value) => setState(() {
      login = value;
    }));
  }
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Chào mừng đến với trà sữa GOGI \nLet’s start!",
      "image": "assets/images/logo.png"
    },
    {
      "text": "Kết nối khách hàng với cửa hàng \ntrên khắp Việt Nam",
      "image": "assets/images/splash2.png"
    },
    {
      "text": "Dễ dàng tìm kiếm và đặt hàng \nkhi ở bất cứ đâu",
      "image": "assets/images/splash3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 1),
                    DefaultButton(
                      text: "Tiếp tục",
                      press: () {
                        if (login == false) {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        }
                        else {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        }
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
