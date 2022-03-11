import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/news_model.dart';

import 'control_panel/update_news_screen.dart';
import 'news_details_screen.dart';

class MyNews extends StatefulWidget {
  const MyNews({Key? key}) : super(key: key);

  @override
  _MyNewsState createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(bottomRight:Radius.circular(15)),
        // ),
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xffDC180F),
            )),
        title: Text(
          ' أخبارنا',
          style: TextStyle(
              color: Color(0xffDC180F), fontFamily: 'NotoNaskhArabic'),
          textAlign: TextAlign.right,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_news_screen');
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
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              hintText: 'بحث ...',
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FbStoreController().read(collectionName: 'News'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;

                  return Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 0, left: 5.0, right: 5.0),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 642,
                        child: ListView.builder(
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: GestureDetector(
                                  onTap: () {
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailsScreen(
                                        news: getNews(snapshot: data[index]),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 250,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                data[index].get(
                                                  'imagePath',
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          left: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 65,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              color: Colors.black54,
                                            ),
                                            child: Center(
                                              child: Text(
                                                data[index].get('title'),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'NotoNaskhArabic'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    await deleteNews(
                                                        path: data[index].id);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Color(0xffDC180F),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateNewsScreen(
                                                                  news: getNews(
                                                                      snapshot:
                                                                          data[index]))),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Color(0xffDC180F),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
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
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                              fontFamily: 'NotoNaskhArabic'),
                        ),
                      ],
                    ),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

Future<bool> deleteNews({required String path}) async {
  bool status =
      await FbStoreController().delete(path: path, collectionName: 'News');
  deleteimage(path: path);

  return status;
}

Future<bool> deleteimage({required String path}) async {
  bool status1 = await FbStorageControlle().delete(path: path);

  return status1;
}

News getNews({required QueryDocumentSnapshot snapshot}) {
  News news = News();
  news.path = snapshot.id;
  news.title = snapshot.get('title');
  news.imagePath = snapshot.get('imagePath');
  news.description = snapshot.get('description');
  news.time = snapshot.get('time');

  return news;
}
