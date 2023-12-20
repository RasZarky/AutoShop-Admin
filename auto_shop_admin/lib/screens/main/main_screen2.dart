import 'package:hostel_finder_admin/controllers/MenuAppController.dart';
import 'package:hostel_finder_admin/responsive.dart';
import 'package:hostel_finder_admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard_screen2.dart';
import 'components/side_menu.dart';
import 'components/side_menu2.dart';

class MainScreen2 extends StatelessWidget {
  final String id;
  MainScreen2({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu2(id: id,),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu2(id: id,),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen2(id: id,),
            ),
          ],
        ),
      ),
    );
  }
}
