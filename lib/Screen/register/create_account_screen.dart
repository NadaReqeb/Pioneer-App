import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/user_model.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> with Helpers{
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: Text('انشاء حساب',
              style: TextStyle(
                  fontSize:SizeConfig().scaleTextFont(30),
                  fontWeight: FontWeight.w800,
                  color: Colors.black
                   ,
                fontFamily: 'NotoNaskhArabic'
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(40),
          ),
          AppTextField1(hint: 'اسم المستخدم', controller: _username,
            prefixIcon: Icon(Icons.account_circle,color: Color(0XFFF303030).withOpacity(.30),),

          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          AppTextField1(hint: 'البريد الاكتروني', controller: _email,textInputType: TextInputType.emailAddress,
            prefixIcon: Icon(Icons.email,color: Color(0XFFF303030).withOpacity(.50),),

          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          AppTextField1(hint: 'كلمة المرور', controller: _password,obscure: true,
            prefixIcon: Icon(Icons.lock,color: Color(0XFFF303030).withOpacity(.50),),

          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          AppTextField1(
            hint: 'تأكيد كلمة المرور', controller: _confirmPassword,obscure: true,
            prefixIcon: Icon(Icons.lock,color: Color(0XFFF303030).withOpacity(.50),),

          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          AppButtonMain(onPressed:() async {
            await performCreateAccount();

          } ,title:"تسجيل دخول",),
          // RichText(text: TextSpan(
          //   style: TextStyle(color: Color(0XFF9391A4),
          //   fontSize: 18,
          //   ),
          //   text: 'هل لديك حساب؟',
          //   children: <InlineSpan>[
          //     TextSpan(
          //       text:'تسجيل دخول',
          //       style: TextStyle(
          //         fontSize: 18,
          //         color: Color(0xff23283f),
          //         fontWeight: FontWeight.bold
          //       )
          //     )
          //   ]
          // )),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login_screen');
            },
            child: Text(
              'هل لديك حساب؟ تسجيل دخول',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0XFFD50000),
                fontSize: SizeConfig().scaleTextFont(18),

                fontFamily: 'NotoNaskhArabic'
                ),
            ),
          ),
          // Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: Divider(
          //           color: Color(0XFFD50000),
          //           height: SizeConfig().scaleHeight(50),
          //         ),
          //       ),

          //       Text("أو"),
          //
          //       Expanded(
          //         child: Divider(
          //           color: Color(0XFFD50000),
          //           height: SizeConfig().scaleHeight(50),
          //         ),
          //       ),
          //     ]
          // ),
          // ElevatedButton.icon(
          // style: ElevatedButton.styleFrom(
          //     primary:Colors.white,
          //     onPrimary: Colors.black,
          //   minimumSize: Size(double.infinity,40),
          //     ),
          // icon:FaIcon(FontAwesomeIcons.facebook,color: Colors.blueAccent,),
          // label:Text('Sign Up with Facebook'),
          // onPressed: ()async {
          //    await facebookLogin();
          //
          // },
          // ),
        ],

      // ),
    // ]
      ),
      );

  }
  Future<void> performCreateAccount() async {
    if (checkData()) {
      await createAccount();
    }

  }

  bool checkData() {
    if (_email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _confirmPassword.text.isNotEmpty &&
        _username.text.isNotEmpty) {
      if (_password.text == _confirmPassword.text) {
        return true;
      }
      showSnackBar(
          context: context,
          content: 'password is not equal to confirm password',
          error: true);
    }
    showSnackBar(
        context: context,
        content: 'Enter email & password &username',
        error: true);
    return false;
  }

  Future<void> createAccount() async {
    bool status = await FbAuthController()
        .createAccount(context, email: _email.text, password: _password.text);

    if(status){
      await FbStoreController().save(userData: userData, collectionName: 'user');
      Navigator.pushNamed(context,'/login_screen');

    }
  }

  // Future createAccountFB() async {
  //   bool status = await FacebookAuthController()
  //       .facebookLogin();
  //   if(status){
  //     Navigator.pushNamed(context,'/login_screen');
  //
  //   }
  // }

//   Future<void> facebookLogin() async {
//     final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//     if (result.status == LoginStatus.success) {
//       // you are logged
//       final AccessToken accessToken = result.accessToken!;
//       var userData = await FacebookAuth.instance.getUserData();
//
//     }
//   }
  UserData get userData {
    UserData userData = UserData();
    userData.email = _email.text;
    userData.password = _password.text;
    userData.name = _username.text;
    userData.type = 'user';
    return userData;
  }
}
// Row(
//   children: [
//     GestureDetector(
//       onTap: (){
//         Navigator.pushNamed(context, '/ProfileScreen');
//       },
//       child: Image.asset('images/googleLogo2.png',
//         width:121,
//         height: 120,),
//     ),
//     GestureDetector(
//       onTap: (){
//         Navigator.pushNamed(context, '/ProfileScreen');
//       },
//       child: Image.asset('images/googleLogo2.png',
//         width:120,
//         height: 120,),
//     ),
//   ],
// ),
