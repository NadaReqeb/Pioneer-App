import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

import '../BottomBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  late String? pathImage;
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FbAuthController().user;
    // pathImage = null;
    // asyncInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),

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
          'الملف الشخصي',
          style: TextStyle(color: Colors.black, fontFamily: 'NotoNaskhArabic'),
          textAlign: TextAlign.right,
        ),

        //actions: [Icon(Icons.arrow_back)],
      ),
      body: Stack(children: [
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: (_firebase.collection('Users').doc(currentUser!.uid)).get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.data() != null) {
                var dataDocs = snapshot.data!.data();

                // List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                // Iterable<QueryDocumentSnapshot> data = snapshot.data!.docs
                //     .where((element) =>
                // element.id == FbAuthController().user.uid);
                return Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Container(
                    child: Center(
                      child: Column(
                          children: [

                            Container(
                              clipBehavior: Clip.antiAlias,
                              width: 150,
                              // width: SizeConfig().scaleWidth(150),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                              ),
                              child: Image(
                                image: NetworkImage(dataDocs!['ImageUrl']),

                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Text(
                                    dataDocs['name'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        fontFamily: 'NotoNaskhArabic'),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width:SizeConfig().scaleWidth(200),
                                  ),
                                  IconButton(onPressed: ( ){
                                    Navigator.pushReplacementNamed(context, '/change_Name');

                                  }, icon: Icon(Icons.edit)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig().scaleHeight(9),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Text(
                                    _user.email ?? 'No Email',
                                    style: TextStyle(
                                        fontSize: SizeConfig().scaleTextFont(14),
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade400,
                                        fontFamily: 'NotoNaskhArabic'),
                                  ),
                                  SizedBox(
                                    width:SizeConfig().scaleWidth(130),
                                  ),
                                  IconButton(onPressed: ( ){
                                    Navigator.pushReplacementNamed(context, '/change_Email');
                                    }, icon: Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top:40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: SizeConfig().scaleHeight(22),
                        ),
                        Center(
                          child: Image(
                            image: AssetImage('images/avatar_user.png'),
                            width:SizeConfig().scaleWidth(120),
                            height: SizeConfig().scaleHeight(150),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig().scaleHeight(22),
                        ),
                        SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:SizeConfig().scaleWidth(30),
                              ),
                              Text(
                                _user.displayName ?? 'No Name',
                                style: TextStyle(
                                  color: Color(0XFF303030),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'NotoNaskhArabic',
                                  fontSize: SizeConfig().scaleTextFont(16),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width:SizeConfig().scaleWidth(260),
                              ),
                              IconButton(onPressed: ( ){
                                Navigator.pushReplacementNamed(context, '/change_Name');

                              }, icon: Icon(Icons.edit)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig().scaleHeight(9),
                        ),
                        SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              SizedBox(
                                width:SizeConfig().scaleWidth(30),
                              ),
                              Text(
                                _user.email ?? 'No Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NotoNaskhArabic',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              SizedBox(
                                width:SizeConfig().scaleWidth(180),
                              ),
                              IconButton(onPressed: ( ){
                                Navigator.pushReplacementNamed(context, '/change_Email');

                              }, icon: Icon(Icons.edit)),
                            ],
                          ),
                        ),
                      ]),
                );
              }
            }),
        Row(
          children: [],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home_screen');
        },
        child: Icon(
          Icons.home,
          color: Color(0xffDC180F),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}

/*
 body: Stack(children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: SizeConfig().scaleHeight(196)),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig().scaleWidth(20),
                ),
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig().scaleHeight(114),
                  ),
                  Text(
                    'GENERAL',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Color(0XFF303030),
                      fontSize: SizeConfig().scaleTextFont(16),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(10),
                  ),
                  ListTileSettings(
                    title: 'Profile Settings',
                    subTitle: 'Update and modify your profile',
                    leadingIconData: Icons.settings,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/change_profile');
                    },
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(20),
                  ),
                  ListTileSettings(
                    title: 'Privacy',
                    subTitle: 'Change your password',
                    leadingIconData: Icons.lock,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/change_password');
                    },
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(20),
                  ),
                  ListTileSettings(
                    title: 'Change Email',
                    subTitle: 'Change your email settin..',
                    leadingIconData: Icons.email,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/change_Email');
                    },
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(20),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 236,
              margin: EdgeInsetsDirectional.only(top: 37, start: 20, end: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 6),
                    spreadRadius: 2,
                    blurRadius: 12,
                  ),
                ],
              ),
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: (_firebase.collection('Users').doc(currentUser!.uid))
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.data() != null) {
                      print('yes have data ');
                      var dataDocs = snapshot.data!.data();
                      // Iterable<QueryDocumentSnapshot> data = snapshot.data!.docs
                      //     .where((element) =>
                      // element.id == FbAuthController().user.uid);
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: SizeConfig().scaleHeight(20),
                              ),
                              Image(
                                image: NetworkImage(dataDocs!['ImageUrl']),
                                width: SizeConfig().scaleWidth(98),
                                height: SizeConfig().scaleHeight(98),
                              ),
                              SizedBox(
                                height: SizeConfig().scaleHeight(22),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dataDocs['name'],
                                    style: TextStyle(
                                      color: Color(0XFF303030),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig().scaleTextFont(16),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.verified,
                                    color: Color(0XFFFDBC02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig().scaleHeight(9),
                              ),
                              Text(
                                _user.email ?? 'No Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ]),
                      );
                    } else {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: SizeConfig().scaleHeight(20),
                              ),
                              Image(
                                image: AssetImage('images/girl.png'),
                                width: SizeConfig().scaleWidth(98),
                                height: SizeConfig().scaleHeight(98),
                              ),
                              SizedBox(
                                height: SizeConfig().scaleHeight(22),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _user.displayName ?? 'No Name',
                                    style: TextStyle(
                                      color: Color(0XFF303030),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig().scaleTextFont(16),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.verified,
                                    color: Color(0XFFFDBC02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig().scaleHeight(9),
                              ),
                              Text(
                                _user.email ?? 'No Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ]),
                      );
                    }
                  }),
            ),
          ])
 */
