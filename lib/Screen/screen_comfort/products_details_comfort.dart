import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/product_model.dart';
import 'package:pionner_app_admin/model/product_model_comfort.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/utils/helpers.dart';

import '../CustomisizeButton.dart';
import '../Customize.dart';


class ProductDetailsComfort extends StatefulWidget {
  late Products products;
  ProductDetailsComfort({required this.products});

  @override
  _ProductDetailsComfortState createState() => _ProductDetailsComfortState();
}

class _ProductDetailsComfortState extends State<ProductDetailsComfort>
    with Helpers {
  int qty = 1;
  void add() {
    setState(() {
      qty += 1;
    });
  }

  void remove() {
    setState(() {
      if (qty > 1) qty -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        iconTheme: IconThemeData(color: Color(0xffDC180F)),
        title: Text(
          'تفاصيل المنتج',
          style: TextStyle(
              fontSize: SizeConfig().scaleTextFont(28),
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoNaskhArabic'),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.products.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          widget.products.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig().scaleTextFont(25),
                              fontFamily: 'NotoNaskhArabic'
                              //  fontFamily: 'OpenSans'
                              ),
                        ),
                        SizedBox(
                          width: SizeConfig().scaleWidth(250),
                        ),
                        Text(
                          ('\$${widget.products.price}'),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig().scaleTextFont(30),
                              fontFamily: 'NotoNaskhArabic'
                              //  fontFamily: 'OpenSans'
                              ),
                        ),
                      ],
                    ),
                    Text(
                      widget.products.description,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig().scaleTextFont(20),
                          fontFamily: 'NotoNaskhArabic'
                          //  fontFamily: 'OpenSans'
                          ),
                    ),
                    SizedBox(
                      height: SizeConfig().scaleHeight(10),
                    ),
                    Text(
                      "الحجم",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig().scaleTextFont(18),
                          fontFamily: 'NotoNaskhArabic'),
                    ),
                    Row(children: [
                      Customize(size: '50', active: false),
                      Customize(size: '150', active: true),
                      Customize(size: '250', active: false),
                      Customize(size: '450', active: false),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'الكمية',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig().scaleTextFont(20),
                          fontFamily: 'NotoNaskhArabic'
                          //fontFamily: 'OpenSans'
                          ),
                    ),
                    Row(
                      children: [
                        CustomisizeButton(
                          onTap: add,
                          iconData: Icons.add_sharp,
                        ),
                        boxQuantity(qty),
                        CustomisizeButton(
                          onTap: remove,
                          iconData: Icons.minimize_sharp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height:SizeConfig().scaleHeight(10),
                    ),
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        'اضف الى السلة',
                        style: TextStyle(
                            color: Color(0xffDC180F),
                            fontSize: SizeConfig().scaleTextFont(15),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoNaskhArabic'),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 9, horizontal: 100),
                          primary: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Products getProduct(QueryDocumentSnapshot snapshot) {
    Products products = Products();
    products.path = snapshot.id;
    products.name = snapshot.get('name');
    products.price = snapshot.get('price');
    products.imagePath = snapshot.get('imagePath');
    products.description = snapshot.get('description');
    products.shortDescription = snapshot.get('shortDescription');
    products.mainCategoriesName = widget.products.name;
    products.idMainCategories = widget.products.path;

    return products;
  }

  Future<void> AddToCart(Products products) async {
    bool status = await FbStoreController().addProductCart(products: products);
    if (status) {
      showSnackBar(context: context, content: 'تمت بنجاح اضافة سلة');
    } else {
      showSnackBar(context: context, content: 'خطأفي الاضافة سلة', error: true);
    }
  }
}

Widget _quantity(void Function() add, void Function() remove, int qty) {
  return Column(
    children: [
      Text(
        'الكمية',
        style: TextStyle(fontFamily: 'NotoNaskhArabic'),
      ),
      Row(
        children: [
          CustomisizeButton(
            onTap: add,
            iconData: Icons.add_sharp,
          ),
          boxQuantity(qty),
          CustomisizeButton(
            onTap: remove,
            iconData: Icons.minimize_sharp,
          ),
        ],
      ),
    ],
  );
}

Widget boxQuantity(int qty) {
  return Container(
    width: 180,
    height: 40,
    alignment: Alignment.center,
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        color: Colors.white,
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    child: Text(
      qty.toString(),
      style: TextStyle(
          fontSize: SizeConfig().scaleTextFont(20)
          , color: Colors.white, fontFamily: 'NotoNaskhArabic'),
    ),
  );
}
