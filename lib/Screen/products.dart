import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/Screen/products_details.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/main_categories.dart';
import 'package:pionner_app_admin/model/product_model.dart';
import 'package:pionner_app_admin/utils/helpers.dart';

import 'control_panel/add_products_screen.dart';
import 'control_panel/update_products_screen.dart';

class ProductsScreen  extends StatefulWidget {
 late MainCategories mainCategories;
 ProductsScreen({required this.mainCategories});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen > with Helpers {
  late String? _value;
  late bool inCart = false;
  late int? tappedIndex ;

  String role = 'admin';


  late Iterable<QueryDocumentSnapshot> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = null;
    tappedIndex = 0;
    inCart = false;

  }
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
          Visibility(
            visible: role == 'admin',
            child:  IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductsScreen(
                          idMainCategories: widget.mainCategories.path,
                        )
                    )
                );
              },
              icon: Icon(
                Icons.add,
                color:Color(0xffDC180F),
                size: 30,
              ),
            ),

          ),
        ],
        title: Text(
          widget.mainCategories.name,
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
          right: 15,
          left: 15,
          bottom: 13,
        ),

        child: StreamBuilder<QuerySnapshot>(
            stream: FbStoreController().read(collectionName: 'Products'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData &&
                  snapshot.data!.docs.isNotEmpty) {
                  data = _value != null
                    ? snapshot.data!.docs.where((element) =>
                (element.get('idMainCategories') ==
                    widget.mainCategories.path) &&
                    (element.get('name') == _value))
                    : snapshot.data!.docs.where((element) =>
                element.get('idMainCategories') ==
                    widget.mainCategories.path);
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15,
                      childAspectRatio: (164) /
                          (310),
                    ),

                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(

                                products: getProduct(
                                  data.elementAt(index),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image.asset(
                              //   'images/softdrink.jpg',
                              //   fit: BoxFit.cover,
                              //   height: SizeConfig().scaleHeight(196),
                              //   width: double.infinity,
                              // ),
                              Hero(
                                tag:'hero',
                                child: Image(
                                  height: 200,
                                  width: double.infinity,
                                  image: NetworkImage(
                                    data.elementAt(index).get('imagePath'),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ),
                                child: Text(
                                  data.elementAt(index).get('name'),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  text: data
                                      .elementAt(index)
                                      .get('shortDescription'),
                                ),
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 15,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      data.elementAt(index).get('price') +
                                          '\$',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color(0XFFFDBC02),
                                    ),
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateProductsScreen(
                                                products: getProduct(
                                                  data.elementAt(index),
                                                ),
                                              ),
                                        ),
                                      );
                                    },
                                  ),

                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0XFFFDBC02),
                                    ),
                                    onPressed: () async {
                                      await deleteProducts(
                                          path: data.elementAt(index).id);
                                    },
                                  ),
                                  Visibility(
                                    visible: role == 'user',
                                    child: IconButton(
                                      onPressed: () async {
                                        await AddToCart(getProduct(data.elementAt(index)));
                                        setState(() {
                                          tappedIndex=index;
                                          inCart = !inCart;
                                          // inCart = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.shopping_cart,
                                        // color: tappedIndex == index ? Colors.blue : Colors.grey,
                                        color: inCart ? Colors.red : Colors.black,

                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length
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
            }),
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
    products.mainCategoriesName = widget.mainCategories.name;
    products.idMainCategories = widget.mainCategories.path;

    return products;
  }

  Future<bool> deleteProducts({required String path}) async {
    bool status = await FbStoreController()
        .delete(path: path, collectionName: 'Products');

    return status;
  }
  Future<void> AddToCart(Products products) async {
    bool status = await FbStoreController().addProductCart(products: products);
    if(status){
      showSnackBar(context: context, content: 'تم الإضافة الى السلة بنجاح');
    }
    else{
      showSnackBar(context: context, content: 'حدث خطأ في الإضافة الى السلة',error: true);
    }

  }
}

