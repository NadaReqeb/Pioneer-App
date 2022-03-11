import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/product_model.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class AddProductsComfort extends StatefulWidget {
  late String idMainCategories;

  AddProductsComfort({required this.idMainCategories});

  @override
  _AddProductsComfortState createState() => _AddProductsComfortState();
}

class _AddProductsComfortState extends State<AddProductsComfort> with Helpers {
  late TextEditingController productsName;
  late TextEditingController shortDescription;
  late TextEditingController description;
  late TextEditingController size;
  late TextEditingController price;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String url;

  @override
  void initState() {
    // TODO: implement initState
    productsName = TextEditingController();
    shortDescription = TextEditingController();
    description = TextEditingController();
    size = TextEditingController();
    price = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productsName.dispose();
    shortDescription.dispose();
    description.dispose();
    size.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'اضافة منتج',
          style: TextStyle(
              fontSize: 26,
              color: Color(0xffDC180F),
              fontWeight: FontWeight.w500,
              fontFamily: 'NotoNaskhArabic'),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffDC180F),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
          // primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black.withOpacity(0.61),
                      blurRadius: 6,
                    )
                  ]),
                  child: GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      child: pickedImage != null
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(
                                    File(pickedImage!.path),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "اضافة صورة للمنتج",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoNaskhArabic'),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'اسم المنتج',
              style: TextStyle(fontSize: 15, fontFamily: 'NotoNaskhArabic'),
            ),
            SizedBox(height: 10),
            AppTextField1(hint: "ادخل اسم المنتج", controller: productsName),
            SizedBox(height: 15),
            Text(
              ' وصف قصير للمنتج',
              style: TextStyle(fontSize: 15, fontFamily: 'NotoNaskhArabic'),
            ),
            SizedBox(height: 10),
            AppTextField1(
                hint: "ادخل وصف قصير للمنتج", controller: shortDescription),
            SizedBox(height: 15),
            Text(
              'وصف للمنتج ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            AppTextField1(hint: "ادخل وصف للمنتج ", controller: description),
            SizedBox(height: 15),
            Text(
              ' حجم المنتج ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            AppTextField1(
              hint: "ادخل حجم المنتج ",
              controller: size,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 15),
            Text(
              ' سعر المنتج',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'NotoNaskhArabic',
              ),
            ),
            SizedBox(height: 10),
            AppTextField1(
              hint: "ادخل سعر المنتج ",
              controller: price,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 30),
            Center(
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffDC180F),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 60)),
                    onPressed: () async {
                      if (await performAddProducts()) {
                        Navigator.pop(context);
                      } else {
                        showSnackBar(
                            context: context,
                            content: 'خطأ في الاضافة',
                            error: true);
                      }
                    },
                    child: Text(
                      'اضافة',
                      style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffDC180F),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 60)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'الغاء',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }

  Future<bool> performAddProducts() async {
    if (checkData()) {
      await FbStoreController()
          .createProduct(products: products, collectionName: 'ProductsComfort');

      return true;
    }
    return false;
  }

  bool checkData() {
    if (productsName.text.isNotEmpty &&
        price.text.isNotEmpty &&
        shortDescription.text.isNotEmpty &&
        description.text.isNotEmpty &&
        size.text.isNotEmpty) {
      if (pickedImage != null) {
        // showSnackBar(context: context, content: 'select pick image true');
        return true;
      }
      showSnackBar(
          context: context, content: 'الرجاء اختيار صورة', error: true);
      return false;
    }
    showSnackBar(
        context: context, content: 'الرجاء ادخال البيانات', error: true);
    return false;
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                      'Photo Library',
                      style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                    ),
                    onTap: () {
                      pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    'Camera',
                    style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                  ),
                  onTap: () {
                    pickImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> pickImageCamera() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
      setState(() {});
      uploadImage();
    }
  }

  void uploadImage() {
    _currentValue = null;
    if (pickedImage != null) {
      FbStorageControlle().upload(
        pickedFile: File(pickedImage!.path),
        eventsHandler: (bool status, String message, TaskState state,
            {Reference? reference}) async {
          if (status) {
            showSnackBar(context: context, content: message);
            changeCurrentIndicator(1);
            downloadURLExample(reference: reference);
          } else {
            if (status == TaskState.running) {
              print('The running Downloader ');
              changeCurrentIndicator(0);
            } else {
              // showSnackBar(context: context, content: message, error: true);
              changeCurrentIndicator(null);
            }
          }
        },
      );
    } else {
      showSnackBar(
          context: context, content: 'Pick image to upload', error: true);
    }
  }

  void changeCurrentIndicator(double? currentIndicator) {
    setState(() {
      _currentValue = currentIndicator;
    });
  }

  Future<void> downloadURLExample({Reference? reference}) async {
    url = await reference!.getDownloadURL();

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Products get products {
    Products products = Products();
    products.name = productsName.text;
    products.shortDescription = shortDescription.text;
    products.description = description.text;
    products.size = size.text;
    products.price = price.text;
    products.imagePath = url;
    products.idMainCategories = widget.idMainCategories;

    return products;
  }
}
