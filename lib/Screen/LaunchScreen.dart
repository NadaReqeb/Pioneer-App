import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {


  @override
  void initState(){
  super.initState();
    Future.delayed(Duration(seconds:3), () {
      // || FacebookAuthController().isLoggedIn
        String route = FbAuthController().isLoggedIn ? '/choice_screen' : '/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }


  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.13).init(context);
    return Scaffold(
      backgroundColor: Color(0xffffffff),

        body: Center(

          child: Image(
            image: AssetImage('images/logo.png'),

          ),
        ),

    );
  }
}
