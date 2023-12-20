import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_finder_admin/constants.dart';
import 'package:hostel_finder_admin/controllers/MenuAppController.dart';
import 'package:hostel_finder_admin/screens/login/login_screen.dart';
import 'package:hostel_finder_admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MenuAppController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Auto Shop Admin',
          theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
              textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
             canvasColor: secondaryColor,

          ),
          home: const LoginScreen(),
        ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Auto Shop Admin',
    //   theme: ThemeData.dark().copyWith(
    //     scaffoldBackgroundColor: bgColor,
    //     textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
    //         .apply(bodyColor: Colors.white),
    //     canvasColor: secondaryColor,
    //   ),
    //   home: MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(
    //         create: (context) => MenuAppController(),
    //       ),
    //     ],
    //     child: MainScreen(),
    //   ),
    // );
  }
}
