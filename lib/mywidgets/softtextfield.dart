import 'package:flutter/material.dart';

class SoftUiTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function validator;
  final bool autofocus;
  SoftUiTextField(
      {this.hintText,
      this.obscureText = false,
      this.validator,
      this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Color(0XFFEFF3F6), boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(-6, -2),
            blurRadius: 6.0,
            spreadRadius: 3.0),
        BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            offset: Offset(6, 2),
            blurRadius: 6.0,
            spreadRadius: 3.0)
      ]),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
        validator: validator, autofocus: autofocus,
        // autovalidate: autovalidate,
      ),
    );
  }
}
