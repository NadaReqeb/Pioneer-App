import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pionner_app_admin/Screen/screen_comfort/products_comfort.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/product_model.dart';
import 'package:pionner_app_admin/model/product_model_comfort.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class UpdateProductsComfort extends StatefulWidget {
  late Products products;

  UpdateProductsComfort({required this.products});

  @override
  _UpdateProductsComfortState createState() => _UpdateProductsComfortState();
}

class _UpdateProductsComfortState extends State<UpdateProductsComfort>
    with Helpers {
  late TextEditingController productsName;
  late TextEditingController shortDescription;
  late TextEditingController description;
  late TextEditingController price;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String? url;

  @override
  void initState() {
    // TODO: implement initState
    productsName = TextEditingController(text: widget.products.name);
    shortDescription =
    TextEditingController(text: widget.products.shortDescription);
    description = TextEditingController(text: widget.products.description);
    price = TextEditingController(text: widget.products.price);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productsName.dispose();
    shortDescription.dispose();
    description.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: Text(
          '?????????? ????????????????',
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.black.withOpacity(0.61),
                          blurRadius: 6,
                        ),
                      ],
                    ),
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
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        NetworkImage(widget.products.imagePath),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Add Image",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoNaskhArabic'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                '?????? ????????????',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(height: 10),
              AppTextField1(hint: "?????? ???????????? ", controller: productsName),
              SizedBox(height: 20),
              Text(
                '?????? ???????? ????????????',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(height: 10),
              AppTextField1(
                  hint: "?????? ???????? ????????????", controller: shortDescription),
              SizedBox(height: 20),
              Text(
                '?????? ???????????? ',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(height: 10),
              AppTextField1(hint: "?????? ????????????", controller: description),
              SizedBox(height: 20),
              Text(
                '?????????? ',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(height: 10),
              AppTextField1(
                hint: "??????????",
                controller: price,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 10),
              AppButtonMain(
                  onPressed: () async {
                    if (await performUpdateProducts()) {
                      Navigator.pop(context);
                    } else {
                      showSnackBar(
                          context: context,
                          content: '?????? ?????? ???? ?????????? ????????????',
                          error: true);
                    }
                  },
                  title: '??????????'),
              SizedBox(height: 10),
              AppButtonMain(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: '??????????'),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: _currentValue,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<bool> performUpdateProducts() async {
    if (checkData()) {
      await FbStoreController().updateProductscomfort(
          productsComfort: products,
          collectionName: 'ProductsComfort',
          path: widget.products.path);

      return true;
    }
    return false;
  }

  bool checkData() {
    if (productsName.text.isNotEmpty &&
        price.text.isNotEmpty &&
        shortDescription.text.isNotEmpty &&
        description.text.isNotEmpty) {
      if (pickedImage == null) {
        url = widget.products.imagePath;

        // showSnackBar(context: context, content: 'select pick image true');
        return true;
      } else {
        return true;
      }
      showSnackBar(
          context: context, content: 'please select an image', error: true);
      return false;
    }
    showSnackBar(
        context: context, content: 'please enter required data', error: true);
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
                    onTap: () async {
                      await pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    'Camera',
                    style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                  ),
                  onTap: () async {
                    await pickImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> pickImageCamera() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {});
      await uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
      setState(() {});
      await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    _currentValue = null;
    if (pickedImage != null) {
      FbStorageControlle().upload(
        pickedFile: File(pickedImage!.path),
        eventsHandler: (bool status, String message, TaskState state,
            {Reference? reference}) async {
          if (status) {
            showSnackBar(context: context, content: message);
            await downloadURLExample(reference: reference);

            changeCurrentIndicator(1);
          } else {
            if (status == TaskState.running) {
              print(' running  ');
              changeCurrentIndicator(0);
            } else {
              showSnackBar(context: context, content: message, error: true);
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
    String urlGet = await reference!.getDownloadURL();
    if (urlGet == null) {
      url = widget.products.imagePath;
    } else {
      url = urlGet;
    }

    // Within your widgets:
    // Image.network(downloadURL);
  }

  ProductsComfort get products {
    ProductsComfort products = ProductsComfort();
    products.name = productsName.text;
    products.shortDescription = shortDescription.text;
    products.description = description.text;
    products.price = price.text;
    products.imagePath = url!;
    products.idMainCategories = widget.products.idMainCategories;

    return products;
  }
}
