import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/utils/helpers.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),

        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffDC180F),
            )),
        title: Text(
          ' السلة',
          style: TextStyle(
              color: Color(0xffDC180F), fontFamily: 'NotoNaskhArabic'),
          textAlign: TextAlign.right,
        ),

        //actions: [Icon(Icons.arrow_back)],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.only(topEnd: Radius.circular(40)),
        ),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FbStoreController().readUserProductCart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    List<QueryDocumentSnapshot> data = snapshot.data!.docs;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: IconButton(
                                        onPressed: () async {
                                          await deleteItem(data[index].id);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            data[index].get('imagePath'),
                                          ),
                                          height: 80,
                                          width: 80,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index].get('name'),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'NotoNaskhArabic'),
                                              ),
                                              // SizedBox(height: 10,),
                                              // Text('2 weight',style: TextStyle(
                                              //   fontSize: 15,color: Colors.grey,
                                              // ),),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${data[index].get('price')}\$',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0XFFFF8236),
                                                    fontFamily:
                                                        'NotoNaskhArabic'),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: EdgeInsets.only(top: 30),
                                        //   child: SizedBox(
                                        //     height: 50,
                                        //     child: Card(
                                        //       shape: RoundedRectangleBorder(
                                        //           borderRadius: BorderRadius.circular(
                                        //               5),
                                        //           side: BorderSide(
                                        //               color: Colors.grey,
                                        //               width: 2
                                        //           )
                                        //       ),
                                        //       child: Row(
                                        //         children: [
                                        //           IconButton(onPressed: () {},
                                        //             icon: Icon(Icons.minimize),),
                                        //           VerticalDivider(color: Colors.grey,
                                        //             thickness: 2,),
                                        //           Text('2kg', style: TextStyle(
                                        //               color: Colors.grey,
                                        //               fontSize: 14),),
                                        //           VerticalDivider(color: Colors.grey,
                                        //             thickness: 2,),
                                        //           IconButton(onPressed: () {},
                                        //             icon: Icon(Icons.add),),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Card(
                elevation: 10,
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(40),
                    topStart: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' السعر :',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoNaskhArabic'),
                          ),
                          Text(
                            ' 21.00',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoNaskhArabic'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' سعر التوصيل :',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoNaskhArabic'),
                          ),
                          Text(
                            ' 05.00',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoNaskhArabic',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' المجموع الكلي :',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xffFF8236),
                                fontFamily: 'NotoNaskhArabic',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' 26.00',
                            style: TextStyle(
                                fontFamily: 'NotoNaskhArabic',
                                fontSize: 15,
                                color: Color(0xffFF8236),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/map_screen');
                        },
                        child: Text(
                          'تأكيد الطلب',
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            primary: Color(0xffDC180F)),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteItem(String path) async {
    bool status = await FbStoreController().deleteProducts(path: path);
    if (status) {
      showSnackBar(context: context, content: 'تم حذف المنتج من السلة');
    } else {
      showSnackBar(
          context: context, content: 'فشل حذف المنتج من السلة', error: true);
    }
  }
}
