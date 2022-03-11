import 'package:flutter/material.dart';

class CustomisizeButton extends StatelessWidget {
  const CustomisizeButton(
      {Key? key, required this.iconData, required this.onTap})
      : super(key: key);
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Icon(
          iconData,
          size: 20,
          color: Color(0xffDC180F),
        ),
      ),
    );
  }
}
