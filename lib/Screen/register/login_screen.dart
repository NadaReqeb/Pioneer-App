import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _email;
  late TextEditingController _password;
  bool _value = false;
  bool _passwordVisible = true;
  bool isAdmin = false;
  bool _isRembemerMe = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Text(
                'تسجيل دخول',
                style: TextStyle(
                    fontSize: SizeConfig().scaleTextFont(30),
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontFamily: 'NotoNaskhArabic'),
              ),
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(50),
            ),
            AppTextField1(
              hint: 'البريد الاكتروني',
              controller: _email,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email,
                color: Color(0XFFF303030).withOpacity(.50),
              ),
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(10),
            ),
            TextField(
              controller: _password,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                hintText: 'كلمة المرور',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0XFFF303030).withOpacity(.50),
                ),
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(0XFFF303030).withOpacity(.50),
                  ),
                ),
                hintStyle: TextStyle(
                    color: Color(0XFFF303030).withOpacity(.50),
                    fontSize: SizeConfig().scaleTextFont(16),
                    fontWeight: FontWeight.w500),
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
                  borderSide: BorderSide(color: Color(0XFFD50000), width: .5),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(10),
            ),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color(0XFFF303030).withOpacity(.50),
              title: RichText(
                text: TextSpan(
                  text: 'تذكر كلمة المرور',
                  style: TextStyle(
                    fontSize: SizeConfig().scaleTextFont(16),
                    color: Colors.black,
                    fontFamily: 'NotoNaskhArabic',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              value: _isRembemerMe,
              onChanged: (bool? status) {
                if (status != null){
                  setState(() {
                    _isRembemerMe = status;
                  });
                }
              },
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(5),
            ),
            AppButtonMain(
                onPressed: () async {
                  await performSignIn();
                },
                title: 'تسجيل دخول'),
            SizedBox(
              height: SizeConfig().scaleHeight(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_account_screen');
                    },
                    child: Text(
                      '  انشاء حساب      ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0XFFD50000),
                        fontSize:SizeConfig().scaleTextFont(16),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    indent: 8,
                    endIndent: 8,
                    thickness: 1,
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forget_password_screen');
                    },
                    child: Text(
                      '  نسيت كلمة المرور؟ ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0XFFD50000),
                          fontSize:SizeConfig().scaleTextFont(16),
                          fontFamily: 'NotoNaskhArabic'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performSignIn() async {
    if (checkData()) {
      await signIn();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, error: true, content: 'Enter required data!');
    return false;
  }

  Future<void> signIn() async {
    bool status = await FbAuthController()
        .signIn(context, email: _email.text, password: _password.text);
    if (status) {
      Navigator.pushReplacementNamed(context, '/choice_screen');
    }
  }

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  // UserData get user {
  //   return UserData(
  //     email: _email.text,
  //      password: _password.text,
  //   );
  // }

// Future<void> _validate(BuildContext context) async {
  //
  //     if(Provider.of<AdminMode>(context).isAdmin){
  //       if(_password == adminPassword){
  //         bool status = await FbAuthController()
  //             .signIn(context, email: _email.text, password: _password.text);
  //         if (status) {
  //           Navigator.pushReplacementNamed(context, '/ProfileScreen');
  //
  //       }else{
  //         showSnackBar(context: context,error: true, content: 'Enter correct data!');
  //
  //       }
  //       }
  //     }else{
  //         await performSignIn();
  //
  //   }

}
