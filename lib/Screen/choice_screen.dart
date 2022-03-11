import 'package:flutter/material.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 50),
        child: Column(
          children: [
            Text(
              'اختر قسمك',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'NotoNaskhArabic',
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset("images/choice.png"),
            SizedBox(
              height: SizeConfig().scaleHeight(20),
            ),
            AppButtonMain(
                onPressed: () {
                  Navigator.pushNamed(context, '/Home_comfort');
                },
                title: 'قسم الاجهزة الكهربائية (كمفورت)'),
            SizedBox(
              height: SizeConfig().scaleHeight(20),
            ),
            AppButtonMain(
                onPressed: () {
                  Navigator.pushNamed(context, '/home_screen');
                },
                title: 'قسم المواد الغذائية (بيونير)'),
          ],
        ),
      ),
    );
  }
}
