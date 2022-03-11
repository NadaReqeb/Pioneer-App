import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';

import 'BottomBar.dart';
class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pushNamed(context, '/home_screen');
        },
            icon: Icon(Icons.arrow_back, color: Colors.red,)),
        title: Text('صفحة العروض',
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_offers_screen');
            },
            icon: Icon(
              Icons.add,
              color: Color(0xffDC180F),
              size: 30,
            ),
          ),
        ],
        //actions: [Icon(Icons.arrow_back)],
      ),
      body: (
          StreamBuilder<QuerySnapshot>(
              stream: FbStoreController().read(collectionName: 'offers'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onLongPress: () {

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: new Text(
                                            "هل تود حذف العرض ؟",
                                            style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                                          ),
                                          actions: <Widget>[
                                            new ElevatedButton(
                                              child: new Text(
                                                "حذف",
                                                style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                                              ),
                                              onPressed: () async {
                                                await deleteOffer(
                                                    path: data[index].id);
                                                Navigator.pop(context);

                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                            ),
                                            new ElevatedButton(
                                              child: new Text(
                                                "الغاء",
                                                style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                            ),
                                          ],
                                        );
                                      }
                                  );
                              },
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 6, bottom: 16, left: 0),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(120),
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                        data[index].get('imagePath'),
                                      ),
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                ),
                                title: Text(
                                  data[index].get('title'),
                                  style: TextStyle(
                                    fontSize: 25,),
                                ),
                                subtitle: Text(
                                  data[index].get('description'),

                                ),
                                trailing: IconButton(onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/offercart');
                                },
                                  icon: Icon(Icons.arrow_forward_ios_sharp,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
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
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home_screen');
        },
        child: Icon(Icons.home, color: Colors.red,),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }

  Future<bool> deleteOffer({required String path}) async {
    bool status = await FbStoreController()
        .delete(path: path, collectionName: 'offers');
    deleteimage(path: path);

    return status;
  }

  Future<bool> deleteimage({required String path}) async {
    bool status1 = await FbStorageControlle()
        .delete(path: path);

    return status1;
  }



}
