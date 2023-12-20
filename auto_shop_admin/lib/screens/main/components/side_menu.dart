import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hostel_finder_admin/screens/add_shop/addShop.dart';
import 'package:hostel_finder_admin/screens/dashboard/dashboard_screen.dart';
import 'package:hostel_finder_admin/screens/transactions/transaction.dart';
import 'package:hostel_finder_admin/screens/view_managers/view_managers.dart';

import '../../add_manager/add_manager.dart';
import '../../view_shops/view_shops.dart';
import '../../view_users/view_users.dart';
import '../main_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),

          DrawerListTile(
            title: "Add Manager",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddManager()));
            },
          ),
          DrawerListTile(
            title: "View Shop",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ViewShops()));
            },
          ),
          DrawerListTile(
            title: "View Users",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ViewUsers()));
              },
          ),
          DrawerListTile(
            title: "View Managers",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ViewManagers()));
            },
          ),

         
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
