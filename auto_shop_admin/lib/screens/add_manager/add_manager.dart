
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../add_shop/components/customTextField.dart';


class AddManager extends StatefulWidget {
  const AddManager({super.key});

  @override
  State<AddManager> createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final _nameTextEditingController = TextEditingController();
  final _locationTextEditingController = TextEditingController();
  final _coordinatesTextEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          key: scaffoldkey,
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              "Enter Manager details below",
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.local_print_shop,
                        hintText: "id@manager.com",
                        labelText: "Manager Id",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _locationTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        data: Icons.email_outlined,
                        hintText: "Password",
                        labelText: "Password",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                    ],
                  ),
                ),

                const SizedBox(height: 15),

                //--------------------Create Button-----------------------//
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.deepOrange),
                    ),

                    onPressed: () async {
                      //-------------Internet Connectivity--------------------//


                      //----------------checking textfield--------------------//
                      if (_nameTextEditingController.text.length < 4) {
                        var snackBar = const SnackBar(
                          content: Text( "Name must be at least 4 characters",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Name must be at least 4 characters");
                        return;
                      }
                      if (_locationTextEditingController.text.isEmpty) {
                        var snackBar = const SnackBar(
                          content: Text( "Location cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // showSnackBar("Please provide a valid email address");
                        return;
                      }


                      databaseRef.child("managers").child(_nameTextEditingController.text.trim().
                      replaceAll(RegExp('[^A-Za-z]'), '')).set({
                        'id': _nameTextEditingController.text.trim(),
                        'password': _locationTextEditingController.text.trim(),

                      });

                      var snackBar = const SnackBar(
                        content: Text( "Manager created successfully",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //
                      // // Navigator.pushReplacement(
                      // //   context,
                      // //   MaterialPageRoute(
                      // //     builder: (c) => const LoginScreen(),
                      // //   ),
                      // );
                    },
                    child: Text(
                      "Create".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),


                const SizedBox(height: 10),
              ],
            ),
          )
      ),
    );
  }
}
