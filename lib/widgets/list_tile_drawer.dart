import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  IconData iconData;
  String title;
  void Function() onTap;

  DrawerListTile(
      {required this.iconData, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: Color(0xffDC180F),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
          fontFamily: 'NotoNaskhArabic',
        ),
      ),
    );
  }
}
