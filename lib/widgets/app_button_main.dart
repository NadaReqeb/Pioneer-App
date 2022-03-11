import 'package:flutter/material.dart';

class AppButtonMain extends StatelessWidget {
  void Function() onPressed;
  String title;

  AppButtonMain({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffDC180F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'NotoNaskhArabic',
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            primary: Colors.transparent),
      ),
    );
  }
}
