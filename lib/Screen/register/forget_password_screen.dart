import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with Helpers {
  late TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        leadingWidth: 80,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffDC180F),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        // decoration: BoxDecoration(
        //   color: Color(0XFFffffff),
        //   image: DecorationImage(
        //       image: AssetImage('images/background.png'), fit: BoxFit.cover),
        // ),

        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Image.asset("images/reset_password.png"),
            Text(
              'تذكر كلمة المرور',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontFamily: 'NotoNaskhArabic'),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextField1(
              hint: 'ادخل البريد الالكتروني',
              controller: _email,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            AppButtonMain(
                onPressed: () async {
                  await performForgetPassword();
                },
                title: 'استرجاع ')
          ],
        ),
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, content: 'Enter required data!', error: true);
    return false;
  }

  Future<void> forgetPassword() async {
    bool status =
        await FbAuthController().forgetPassword(context, email: _email.text);
    if (status) {
      showSnackBar(
          context: context,
          content: 'Reset email sent successfully, check and confirm');
      Navigator.pop(context);
    }
  }
}
