import 'package:flutter/material.dart';
import 'package:kapdabazzarsellers/const.dart';

class SoftUiTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function validator;
  final bool autofocus;
  final Function onSaved;
  final TextInputType keyboardType;
  final Function onChanged;

  // final KeyboardType

  SoftUiTextField(
      {this.hintText,
      this.onSaved,
      this.obscureText = false,
      this.validator,
      this.autofocus = false,
      this.keyboardType,
      this.onChanged});

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
        // maxLines: maxLines,
        onChanged: onChanged,
        keyboardType: keyboardType,
        onSaved: onSaved,
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

class MyTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final int maxlines;
  final String initialValue;
  final TextInputType keyboardType;
  final Function onSaved;
  final FormFieldValidator validator;
  MyTextField(
      {this.title,
      this.icon,
      this.validator,
      this.hintText,
      this.maxlines,
      this.initialValue,
      this.keyboardType,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          onSaved: onSaved,
          cursorColor: mycolor,
          keyboardAppearance: Brightness.light,
          maxLines: maxlines,
          decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(),
            hintText: hintText,
            icon: Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          // autofocus: true,
          // autovalidate: true,
          validator: validator),
    );
  }
}
