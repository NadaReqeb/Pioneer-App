import 'package:flutter/material.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

class Customize extends StatelessWidget {
  const Customize({Key? key, required this.size, required this.active})
      : super(key: key);
  final String size;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: active ? Colors.amberAccent : Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        size,
        style: TextStyle(
            fontSize: SizeConfig().scaleTextFont(20),
            fontWeight: FontWeight.bold,
            color: active ? Color(0xffDC180F) : Colors.redAccent,
            fontFamily: 'NotoNaskhArabic'),
      ),
    );
  }
}
