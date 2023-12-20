import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  bool isObsecure = true;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.data,
    required this.hintText,
    required this.isObsecure,
    required this.textInputType,
    required this.labelText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Icon(
            data,
            color: Theme.of(context).primaryColor,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
