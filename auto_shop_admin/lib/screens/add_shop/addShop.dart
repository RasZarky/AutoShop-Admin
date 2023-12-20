
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/customTextField.dart';

class addShop extends StatefulWidget {
  final String id;
  const addShop({super.key, required this.id});

  @override
  State<addShop> createState() => _addShopState(id: id);
}

class _addShopState extends State<addShop> {

  final String id;
  _addShopState({required this.id});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final _nameTextEditingController = TextEditingController();
  final _locationTextEditingController = TextEditingController();
  final _coordinatesTextEditingController = TextEditingController();
  final _coordinatesTextEditingController2 = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();
  String userImage = "";
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Washing Bay"), value: "Washing Bay",),
      DropdownMenuItem(child: Text("Engine Service"), value: "Engine Service",),
      DropdownMenuItem(child: Text("General Maintenance"), value: "General Maintenance",),
      DropdownMenuItem(child: Text("Paint Job"), value: "Paint Job",),
      DropdownMenuItem(child: Text("Tyre and Wheels"), value: "Tyre and Wheels",),
      DropdownMenuItem(child: Text("WindSheild and Windows"), value: "WindSheild and Windows",),
    ];
    return menuItems;
  }
  String category = "Washing Bay";
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          key: scaffoldkey,
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              "Enter shop details below",
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
                        hintText: "Shop Name",
                        labelText: "Shop Name",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _locationTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        data: Icons.email_outlined,
                        hintText: "Location",
                        labelText: "Location",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _coordinatesTextEditingController,
                        textInputType: TextInputType.text,
                        data: Icons.lock_outline,
                        hintText: "Location Latitude",
                        labelText: "Location Latitude",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      const SizedBox(height: 10,),

                      CustomTextField(
                        controller: _coordinatesTextEditingController2,
                        textInputType: TextInputType.text,
                        data: Icons.lock_outline,
                        hintText: "Location Longitude",
                        labelText: "Location Longitude",
                        isObsecure: false,
                        maxlines: null,
                        minlines: null,
                      ),

                      // const SizedBox(height: 10,),
                      //
                      // CustomTextField(
                      //   controller: _priceTextEditingController,
                      //   textInputType: TextInputType.text,
                      //   data: Icons.lock_outline,
                      //   hintText: "Price",
                      //   labelText: "Price ",
                      //   isObsecure: false,
                      //   maxlines: null,
                      //   minlines: null,
                      // ),

                      const SizedBox(height: 10,),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonFormField(
                            items: dropdownItems,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor, width: 2),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: secondaryColor,
                            ),
                            validator: (value) => value == null?"select a category":null,
                            dropdownColor: secondaryColor,
                            value: category,
                            onChanged: (String? newValue){
                              setState(() {
                                category = newValue!;
                              });
                            }
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _descriptionTextEditingController,
                        textInputType: TextInputType.multiline,
                        data: Icons.lock_outline,
                        hintText: "Shop Description",
                        labelText: "Shop Description",
                        isObsecure: false,
                        maxlines: 20,
                        minlines: 10,
                      ),
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

                      if (_coordinatesTextEditingController.text.isEmpty) {
                        var snackBar = const SnackBar(
                          content: Text( "latitude cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Password must be at least 8 characters");
                        return;
                      }
                      if (_coordinatesTextEditingController2.text.isEmpty) {
                        var snackBar = const SnackBar(
                          content: Text( "longitude cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Password must be at least 8 characters");
                        return;
                      }
                      if (_coordinatesTextEditingController.text.isEmpty) {
                        var snackBar = const SnackBar(
                          content: Text( "Price cant be empty",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //showSnackBar("Confirm Password is not match");
                        return;
                      }


                      databaseRef.child("shops").child(_nameTextEditingController.text.trim().
                          replaceAll(RegExp('[^A-Za-z]'), '')
                          + _locationTextEditingController
                          .text.trim().replaceAll(RegExp('[^A-Za-z]'), '')).set({
                        'name': _nameTextEditingController.text.trim(),
                        'location': _locationTextEditingController.text.trim(),
                        'latitude': _coordinatesTextEditingController.text.trim(),
                        'longitude': _coordinatesTextEditingController2.text.trim(),
                        'manager': id,
                        'price': '0.00',
                        'category': category,
                        'description': _descriptionTextEditingController.text.trim()
                      });

                      var snackBar = const SnackBar(
                        content: Text( "Shop created successfully",
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
