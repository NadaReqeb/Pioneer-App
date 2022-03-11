import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> with Helpers {
  late TextEditingController _email;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FbAuthController().user;

    _email = TextEditingController(text: _user.email);
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xffDC180F),
          ),
        ),
        title: Text(
          'تغير البريد الالكتروني',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),

        //actions: [Icon(Icons.arrow_back)],
      ),
      body: Container(

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadiusDirectional.only(
        //     topEnd: Radius.circular(40),
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.only(top:200),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              Text(
                'تغير البريد الالكتروني',
                style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              AppTextField1(
                hint: 'Enter new Email',
                controller: _email,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 18,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Color(0XFF273246),
                          Color(0XFF181D29),
                        ])),
                child: ElevatedButton(
                  onPressed: () async {
                    await performChangeEmail();
                  },
                  child: Text(
                    'change',
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performChangeEmail() async {
    if (checkData()) {
      await changeEmail();
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

  Future<void> changeEmail() async {
    bool status =
        await FbAuthController().updateEmail(context, email: _email.text);
    if (status) {
      showSnackBar(
          context: context,
          content: 'Verification email sent, please check and confirm');
      FbAuthController().signOut();
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }
}
