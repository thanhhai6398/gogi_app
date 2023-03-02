import 'package:gogi/screens/cart/cart_screen.dart';
import 'package:gogi/screens/customer_profile/customer_profile_screen.dart';
import 'package:gogi/screens/details/details_screen.dart';
import 'package:gogi/screens/forgot_password/forgot_password_screen.dart';
import 'package:gogi/screens/home/home_screen.dart';
import 'package:gogi/screens/login_success/login_success_screen.dart';
import 'package:gogi/screens/menu/menu_screen.dart';
import 'package:gogi/screens/otp/otp_screen.dart';
import 'package:gogi/screens/profile/profile_screen.dart';
import 'package:gogi/screens/sign_in/sign_in_screen.dart';
import 'package:gogi/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CustomerProfileScreen.routeName: (context) => CustomerProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MenuScreen.routeName:  (context) => MenuScreen(),
};
