import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/Screen/comfort_control_panel/update_category_comfort.dart';
import 'package:pionner_app_admin/Screen/products.dart';
import 'package:pionner_app_admin/Screen/screen_comfort/products_comfort.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_notifications.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/main_categories.dart';
import 'package:pionner_app_admin/model/main_categories_comfort.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/list_tile_drawer.dart';
import '../BottomBar.dart';
import '../BottomBarComfort.dart';

class HomeScreenComfort extends StatefulWidget {
  const HomeScreenComfort({Key? key}) : super(key: key);

  @override
  _HomeScreenComfortState createState() => _HomeScreenComfortState();
}

class _HomeScreenComfortState extends State<HomeScreenComfort> with FbNotifications , Helpers{
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  late User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    _user = FbAuthController().user;
    print('Uid is ' + currentUser!.uid);
  }
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // void _checkRole() async {
  //   User? user = _firebaseAuth.currentUser;
  //   final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
  //
  //   setState(() {
  //     role = snap['type'];
  //   });
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(

        centerTitle: true,
        elevation: 1,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
           ),
        ),
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color:Color(0xffDC180F)),


        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_category_comfort');
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),


        ],
        title: Text(
          'الاصناف',
          style: TextStyle(
            fontSize:SizeConfig().scaleTextFont(28),
            color: Colors.black,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      // drawer: buildDrawer(context),
      drawer: Drawer(
        child: Container(
          color: Color(0XFFffffff),
          child: ListView(
            shrinkWrap: true,
            children: [

              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future:
                (_firebase.collection('user').doc(currentUser!.uid)).get(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    print('error no  data ');
                    return Text('Error = ${snapshot.error}');
                  }
                  else if (snapshot.hasData&& snapshot.data!.data()!= null) {
                    var data = snapshot.data!.data();
                    // var value = data['name']; // <-- Your value
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(data!['ImageUrl']),
                      ),
                      title: Text(
                        data['name'],
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(16),
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        _user.email ?? 'No Email',
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(12),
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }
                  else {
                    print('no data ');

                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/Home_comfort');

                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('images/avatar_user.png'),
                      ),
                      title: Text(
                        _user.displayName ?? 'No Name',
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(16),
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        _user.email ?? 'No Email',
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(12),
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }
                },
              ),

              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              Divider(
                indent: 0,
                endIndent: 50,
                thickness: 1,
                color: Colors.grey.shade300,
              ),

              DrawerListTile(
                title: 'الصفحة الرئيسية',
                iconData: Icons.home_rounded,

                onTap: () {
                  Navigator.pushNamed(context, '/Home_comfort');

                },
              ),

              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              DrawerListTile(
                title: 'قسم بيونير',
                iconData: Icons.article,

                onTap: () {
                  Navigator.pushNamed(context, '/home_screen');

                },
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              DrawerListTile(
                title: 'الاخبار',
                iconData: Icons.article,

                onTap: () {
                  Navigator.pushNamed(context, '/news_screen');

                },
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              DrawerListTile(
                title: 'السلة',
                iconData: Icons.shopping_cart,
                onTap: () {
                  Navigator.pushNamed(context, '/order_screen');
                },
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              DrawerListTile(
                title: 'العروض',
                iconData: Icons.local_offer,
                onTap: () {
                  Navigator.pushNamed(context, '/offers_screen');
                },
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),

              DrawerListTile(
                title: 'ضبط',
                iconData: Icons.settings,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/ProfileScreen');
                },
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              DrawerListTile(
                title: 'نبذه عن الشركة',
                iconData: Icons.info,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/about_screen');
                },
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
              DrawerListTile(
                  iconData: Icons.logout,
                  title: 'تسجيل خروج',
                  onTap: () async {
                    await logout();
                    showSnackBar(
                        context: context, content: 'Logout successfully');
                  }),
              SizedBox(
                height:SizeConfig().scaleHeight(30),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FbStoreController().read(collectionName: 'MainCategoriesComfort'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.only(top: 10,left: 10,right:3,bottom: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: SizeConfig().scaleWidth(10),
                    crossAxisSpacing: SizeConfig().scaleHeight(10),
                    childAspectRatio: SizeConfig().scaleWidth(120) / SizeConfig().scaleHeight(150),

                  ),
                  shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsScreenComfort(mainCategoriesComfort:
                                  getMainCategories(snapshot: data[index]),
                                  ),
                              // SubCategoriesScreen(mainCategories:
                              // getMainCategories(snapshot: data[index]),),

                            ),
                          );
                        },
                        child:Column(
                          children: [
                            Container(
                                  alignment: AlignmentDirectional.bottomStart,
                              height: SizeConfig().scaleHeight(200),
                              width:  SizeConfig().scaleWidth(200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        data[index].get('imagePath'),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      color: Colors.black54,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(

                                        children: [
                                          Text(
                                            data[index].get('name'),
                                            style: TextStyle(
                                              fontSize:SizeConfig().scaleTextFont(18),
                                              color: Colors.white,
                                            ),
                                          ),
                                      SizedBox(
                                        width:SizeConfig().scaleWidth(27),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await deleteCategories(
                                              path: data[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateCategoryComfort(
                                                      mainCategoriesComfort:
                                                      getMainCategories(
                                                          snapshot:
                                                          data[index]),
                                                    )),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.red,
                                        ),
                                      ),



                                      ],
                                      ),
                                    ),
                                  ),
                                ),


                                ],

                     ));
                    },
                    itemCount: data.length,
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 85,
                    ),
                    Text(
                      'No Data',
                      style: TextStyle(fontSize:SizeConfig().scaleTextFont(22),
                          color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Home_comfort');

        },
        child: Icon(Icons.home,color: Colors.red,),
        backgroundColor:Colors.white ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomBarComfort(),
    );

  }



Future logout()async{
    if(FbAuthController().isLoggedIn){
      await FbAuthController().signOut();
    }
    Navigator.pushReplacementNamed(context, '/login_screen');
}


Future<bool> deleteCategories({required String path}) async {
  bool status = await FbStoreController()
      .delete(path: path, collectionName: 'MainCategoriesComfort');
  deleteimage(path: path);

  return status;

}
Future<bool> deleteimage({required String path}) async {

  bool status1 = await FbStorageControlle()
      .delete(path: path);

  return status1;
}
  MainCategoriesComfort getMainCategories({required QueryDocumentSnapshot snapshot}) {
  MainCategoriesComfort mainCategoriesComfort
  = MainCategoriesComfort();
  mainCategoriesComfort.path = snapshot.id;
  mainCategoriesComfort.name = snapshot.get('name');
  mainCategoriesComfort.imagePath = snapshot.get('imagePath');

  return mainCategoriesComfort;
}
// void _showDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: new Text("هل تريد حذف الصنف؟ "),
//           actions: <Widget>[
//             new ElevatedButton(
//               child: new Text("موافق"),
//               onPressed: () async {
//             await deleteCategories(
//             path: data[index].id);
//               },
//             ),
//             new ElevatedButton(
//               child: new Text("الغاء"),
//               onPressed: ()  {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       }
//   );
// }
}