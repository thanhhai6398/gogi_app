import 'package:gogi/screens/checkout/checkout_screen.dart';
import 'package:gogi/screens/contact/contact_screen.dart';
import 'package:gogi/screens/about/about_screen.dart';
import 'package:gogi/screens/cart/cart_screen.dart';
import 'package:gogi/screens/customers/customers_screen.dart';
import 'package:gogi/screens/details/details_screen.dart';
import 'package:gogi/screens/favourite/favourite_screen.dart';
import 'package:gogi/screens/forgot_password/forgot_password_screen.dart';
import 'package:gogi/screens/home/home_screen.dart';
import 'package:gogi/screens/menu/menu_screen.dart';
import 'package:gogi/screens/order_detail/order_detail_screen.dart';
import 'package:gogi/screens/profile/profile_screen.dart';
import 'package:gogi/screens/order/order_screen.dart';
import 'package:gogi/screens/reset_password/reset_password_screen.dart';
import 'package:gogi/screens/sign_in/sign_in_screen.dart';
import 'package:gogi/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:gogi/screens/store/store_screen.dart';
import 'package:gogi/screens/voucher/voucher_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MenuScreen.routeName:  (context) => MenuScreen(),
  StoreScreen.routeName: (context) => StoreScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
  ContactScreen.routeName: (context) => ContactScreen(),
  OrderScreen.routeName:(context) => OrderScreen(),
  OrderDetailScreen.routeName: (context) => OrderDetailScreen(),
  FavouriteScreen.routeName: (context) => FavouriteScreen(),
  VoucherScreen.routeName: (context) => VoucherScreen(),
  CustomersScreen.routeName: (context) => CustomersScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen()
};

