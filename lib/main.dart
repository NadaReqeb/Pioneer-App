import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pionner_app_admin/Screen/comfort_control_panel/add_products_comfort.dart';
import 'package:pionner_app_admin/Screen/home_screen.dart';
import 'Screen/AboutAs.dart';
import 'Screen/Cart.dart';
import 'Screen/LaunchScreen.dart';
import 'Screen/News.dart';
import 'Screen/Order/Tracking.dart';
import 'Screen/Recipe/NewRecpie.dart';
import 'Screen/Settings/ProfileSetting.dart';
import 'Screen/Settings/change_email.dart';
import 'Screen/Settings/change_name.dart';
import 'Screen/choice_screen.dart';
import 'Screen/comfort_control_panel/add_category_comfort.dart';
import 'Screen/contact_screen.dart';
import 'Screen/control_panel/add_category_screen.dart';
import 'Screen/control_panel/add_news_screen.dart';
import 'Screen/control_panel/add_offers_screen.dart';
import 'Screen/control_panel/add_recpie_screen.dart';
import 'Screen/offerspage.dart';
import 'Screen/order_fakhry/order_home.dart';
import 'Screen/order_screen.dart';
import 'Screen/register/create_account_screen.dart';
import 'Screen/register/forget_password_screen.dart';
import 'Screen/register/login_screen.dart';
import 'Screen/screen_comfort/home_screen_comfort.dart';
import 'firebase/firestore/fb_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  // await FacebookAuthController().getAccessToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [Locale('ar','AE')],
        locale:Locale ('ar','AE'),

        debugShowCheckedModeBanner: false,
        initialRoute:'/Launch_screen' ,
        routes: {
          '/Launch_screen': (context) => LaunchScreen(),
          '/create_account_screen': (context) => CreateAccountScreen(),
          '/login_screen': (context) => LoginScreen(),
          '/forget_password_screen': (context) => ForgetPassword(),
          '/home_screen': (context) => HomeScreen(),
          '/ProfileScreen': (context) => ProfileScreen(),
          '/about_screen': (context) => AboutAs(),
          '/add_category_screen': (context) => AddCategoryScreen(),
          '/news_screen': (context) => MyNews(),
          '/add_news_screen': (context) => AddNewsScreen(),
          '/recpie_screen': (context) => NewRecipe(),
          '/add_recpie_screen': (context) => AddRecpieScreen(),
          '/cart_screen': (context) => Cart(),
          '/contact_screen': (context) => ContactScreen(),
          '/offers_screen': (context) => OffersPage(),
          '/add_offers_screen': (context) => AddOffersScreen(),
          '/order_screen': (context) => OrderScreen(),
          '/choice_screen': (context) => ChoiceScreen(),
          '/tracking_screen':(context)=>Tracking(),
          '/order_screen1':(context)=>OrderHome(),
          '/change_Email':(context)=>ChangeEmail(),
          '/change_Name':(context)=>ChangeName(),
// ______________________________________________________________________________________
          '/Home_comfort':(context)=>HomeScreenComfort(),
          '/add_category_comfort':(context)=>AddCategoryComfort(),

        }
    );
  }
}


