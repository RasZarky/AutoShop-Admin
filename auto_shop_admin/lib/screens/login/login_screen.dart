
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_finder_admin/screens/main/main_screen2.dart';
import '../add_shop/components/customTextField.dart';
import '../dashboard/dashboard_screen.dart';
import '../main/main_screen.dart';

import 'components/progressdialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  late String userloginemail;
  late String userloginpassword;

  bool _isManager = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Scaffold(
            key: scaffoldkey,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),

                  Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                  ),

                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepOrange,
                      fontFamily: 'Brand-Bold',
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Admin Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Brand-Regular',
                        letterSpacing: 1,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 150),

                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailTextEditingController,
                          textInputType: TextInputType.emailAddress,
                          data: Icons.email_outlined,
                          hintText: "Email",
                          labelText: "Email",
                          isObsecure: false,
                          maxlines: null,
                          minlines: null,
                        ),

                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: _passwordTextEditingController,
                          textInputType: TextInputType.text,
                          data: Icons.lock_outline,
                          hintText: "Password",
                          labelText: "Password",
                          isObsecure: true,
                          maxlines: 1,
                          minlines: null,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(child: Visibility(visible: isLoading,
                    child: Stack(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(

                          ),
                          child: Container(
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: 300.0,
                            height: 200.0,
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 50.0,
                                    width: 50.0,
                                    child: CircularProgressIndicator(
                                      value: null,
                                      strokeWidth: 7.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: Center(
                                    child: Text(
                                      "Please wait ...",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),)),

                  const SizedBox(height: 20),

                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _isManager,
                        onChanged: (value) {
                          setState(() {
                            _isManager = value!;
                          });
                        },
                      ),
                      const Text('Login as a manager', style: TextStyle(
                          color: Colors.black
                      ),),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 16),

                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.deepOrange),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      onPressed: () async {
                        //-------------check Internet Connectivity--------------------//

                        //----------------checking textfield--------------------//

                        userloginemail = _emailTextEditingController.text;
                        userloginpassword = _passwordTextEditingController.text;
                        if (!userloginemail.contains("@")) {

                          var snackBar = const SnackBar(
                              content: Text( "Please provide a valid email address",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          //showSnackBar("Please provide a valid email address");
                          return;
                        }

                        if (userloginpassword.length < 8) {

                          var snackBar = const SnackBar(
                            content: Text( "Password must be at least 8 characters",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          //showSnackBar("Password must be at least 8 characters");
                          return;
                        }

                        final email = userloginemail.trim();
                        final password = userloginpassword.trim();
                        //loginUser(email, password, context);

                        setState(() {
                          isLoading = true;
                        });

                        final databaseRef = FirebaseDatabase.instance.ref().child('managers').child(email.replaceAll(RegExp('[^A-Za-z]'), '')).child('password');

                        if (_isManager) {

                          final snapshot = await databaseRef.get();
                          if(snapshot.exists && snapshot.value.toString() == password){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  MainScreen2(id: email)),
                            );
                          }else {
                            var snackBar = const SnackBar(
                              content: Text( "Wrong details provided",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }

                          setState(() {
                            isLoading = false;
                          });

                        }else{
                          if(email == 'admin@admin.com' && password == 'admin12345'){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (c) => MainScreen(),
                              ),
                            );
                          }else {
                            var snackBar = const SnackBar(
                              content: Text( "Invalid details provided",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }

                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  Center(
                    child: Container(
                      height: 2.0,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      color: Colors.black45,
                    ),
                  ),





                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        )
    );
  }

  Future loginUser(String email, String password, BuildContext context) async {
    //------show please wait dialog----------//
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const ProgressDialog(
        status: "Login, Please wait....",
      ),
    );
}
}
