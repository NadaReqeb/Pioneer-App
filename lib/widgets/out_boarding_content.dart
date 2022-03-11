import 'package:flutter/material.dart';

class OutBoardingContent extends StatelessWidget {
  final int imageNumber;
  final String title;
  final String description;

  OutBoardingContent(
      {required this.imageNumber,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/out_boarding_$imageNumber.png'),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF23203F),
              fontFamily: 'NotoNaskhArabic',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 21),
          Text(
            description,
            // maxLines: 1,
            // overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoNaskhArabic',
              fontSize: 17,
              color: Color(0xFF716F87),
            ),
          ),
        ],
      ),
    );
  }
}
