import 'package:flutter/material.dart';

class AppTextField1 extends StatefulWidget {
  late String hint;
  late TextEditingController controller;
  late Widget? prefixIcon = prefixIcon;
  late TextInputType textInputType = TextInputType.text;
  late bool obscure = false;

  AppTextField1(
      {required this.hint,
      required this.controller,
      this.prefixIcon,
      this.obscure = false,
      this.textInputType = TextInputType.text});

  @override
  _AppTextField1State createState() => _AppTextField1State();
}

class _AppTextField1State extends State<AppTextField1> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.textInputType,
      obscureText: widget.obscure,
      controller: widget.controller,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'NotoNaskhArabic',
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        hintStyle: TextStyle(
          color: Color(0XFFF303030).withOpacity(.50),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'NotoNaskhArabic',
        ),
        fillColor: Color(0XFFF3F3F3),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0XFFF3F3F3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0XFFD50000), width: 0.5),
        ),
      ),
    );
  }
}
