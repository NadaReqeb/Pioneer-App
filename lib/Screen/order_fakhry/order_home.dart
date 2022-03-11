
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/admin_order.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/widgets/loading.dart';
import 'package:pionner_app_admin/widgets/no_data.dart';
import 'package:pionner_app_admin/widgets/order_widet.dart';

import 'order_details.dart';

class OrderHome extends StatefulWidget {
  const OrderHome({Key? key}) : super(key: key);

  @override
  _OrderHomeState createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  String id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(4.12).designHeight(8.70).init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xffDC180F),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          margin: EdgeInsetsDirectional.only(top: SizeConfig().scaleHeight(10)),
          child: Text(
            'الطلبيات',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig().scaleTextFont(20)),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FbStoreController().readOrder(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.length > 0) {
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.separated(
                        itemCount: documents.length,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                          getCart(documents[index])),
                                    ));
                              },
                              child: showItemOrder(
                                title: documents[index].get('email'),
                                subtitle:
                                    documents[index].get('proName').toString(),
                                index: index,
                                documents: documents,
                                url: documents[index].get('proImage'),
                                date: documents[index]
                                    .get('created')
                                    .toString()
                                    .substring(0, 16),
                                context: context,
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.transparent,
                            height: SizeConfig().scaleHeight(10),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Loading();
                    } else {
                      return NoData();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  AdminOrder getCart(DocumentSnapshot snapshot) {
    AdminOrder cart = AdminOrder();
    cart.price = snapshot.get('price');
    cart.proName = snapshot.get('proName');
    cart.userName = snapshot.get('userName');
    cart.proImage = snapshot.get('proImage');
    cart.email = snapshot.get('email');
    cart.created = snapshot.get('created');
    cart.path = snapshot.id;
    return cart;
  }
}
