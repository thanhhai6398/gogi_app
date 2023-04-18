import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogi/components/custom_bottom_nav_bar.dart';
import 'package:gogi/constants.dart';
import 'package:gogi/enums.dart';

import '../Contact/contact_screen.dart';
import '../about/about_screen.dart';
import '../store/store_screen.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        spacing: 10,
        icon: Icons.menu, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: kPrimaryColor, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor: Colors.deepOrangeAccent, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'), // action when menu opens
        onClose: () => print('DIAL CLOSED'), //action when menu closes

        elevation: 8.0, //shadow elevation of button
        shape: const CircleBorder(), //shape of button

        children: [
          SpeedDialChild( //speed dial child
            child: SvgPicture.asset("assets/icons/Conversation.svg", color: Colors.white),
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            label: "Liên hệ",
            labelStyle: const TextStyle(fontSize: 18.0, color: kPrimaryColor),
            onTap: () => Navigator.pushNamed(context, ContactScreen.routeName),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: SvgPicture.asset("assets/icons/Gift Icon.svg", color: Colors.white),
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            label: "Giới thiệu",
            labelStyle: const TextStyle(fontSize: 18.0, color: kPrimaryColor),
            onTap: () => Navigator.pushNamed(context, AboutScreen.routeName),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: SvgPicture.asset("assets/icons/Shop Icon.svg", color: Colors.white),
            foregroundColor: Colors.white,
            backgroundColor: kPrimaryColor,
            label: "Cửa hàng",
            labelStyle: const TextStyle(fontSize: 18.0, color: kPrimaryColor),
            onTap: () => Navigator.pushNamed(context, StoreScreen.routeName),
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),

          //add more menu item children here
        ],
      ),
      body: Body(),
      // FoldableSidebarBuilder(
      //   drawerBackgroundColor: Colors.white,
      //   drawer: SidebarDrawer(drawerClose: (){
      //     setState(() {
      //       _fsbStatus = FSBStatus.FSB_CLOSE;
      //     });
      //   },
      //   ),
      //   screenContents: Body(),
      //   status: _fsbStatus,
      // ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: kPrimaryColor,
      //     child: const Icon(Icons.menu,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       setState(() {
      //         _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN ?
      //         FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
      //       });
      //     }),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
