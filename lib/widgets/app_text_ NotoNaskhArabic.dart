import 'package:flutter/material.dart';

class AppTexMontseratBlack extends StatelessWidget {
  late String titleOfButton;

  AppTexMontseratBlack({required this.titleOfButton});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleOfButton,
      style: TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 42,
          fontWeight: FontWeight.w900,
          color: Colors.black),
    );
  }
}
