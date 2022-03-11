import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pionner_app_admin/Screen/Recipe/ModelRecipe.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/product_model.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class UpdateRecpieScreen extends StatefulWidget {
  late RecipeModel recipeModel;

  UpdateRecpieScreen({required this.recipeModel});

  @override
  _UpdateRecpieScreenState createState() => _UpdateRecpieScreenState();
}

class _UpdateRecpieScreenState extends State<UpdateRecpieScreen>
    with Helpers {
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController cookingTime;
  late TextEditingController ingredients;
  // late TextEditingController prepare;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String? url;

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController(text: widget.recipeModel.title);
    description = TextEditingController(text: widget.recipeModel.description);
    cookingTime = TextEditingController(text: widget.recipeModel.cookingTime);
    ingredients = TextEditingController(text: widget.recipeModel.ingredients);
    // prepare = TextEditingController(text: widget.recipeModel.prepare);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    description.dispose();
    cookingTime.dispose();
    ingredients.dispose();
    // prepare.dispose();
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
          'تعديل المنتجات',
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
                                        NetworkImage(widget.recipeModel.imgPath),
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
                   'اسم الوصفة',
                   style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
                 ),
                 SizedBox(height: 10),
                 AppTextField1(hint: "اسم الوصفة ", controller: title),
                 SizedBox(height: 20),
                 Text(
                   'وصف المنتج ',
                   style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
                 ),
                 SizedBox(height: 10),
                 AppTextField1(hint: "وصف المنتج", controller: description),
                 SizedBox(height: 20),
                 Text(
                   'الوقت الازم ',
                   style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
                 ),
                 SizedBox(height: 10),
                 AppTextField1(
                   hint: "الوقت الازم",
                   controller: cookingTime,
                 ),
                  SizedBox(height: 20),
                  Text(
                    'المقادير ',
                    style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
                  ),
                  SizedBox(height: 10),
                  AppTextField1(
                    hint: "المقادير ",
                    controller: ingredients,
                  ),
                  SizedBox(height: 20),
                 AppButtonMain(
                     onPressed: () async {
                       if (await performUpdateProducts()) {
                         Navigator.pop(context);
                       } else {
                         showSnackBar(
                             context: context,
                             content: 'حدث خطأ في اضافة المنتج',
                             error: true);
                       }
                     },
                     title: 'تحديث'),
                 SizedBox(height: 10),
                 AppButtonMain(
                     onPressed: () {
                       Navigator.pop(context);
                     },
                     title: 'الغاء'),
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
      await FbStoreController().updateRecipe(
          recipe: recipe,
          collectionName: 'recipe',
          path: widget.recipeModel.path);

      return true;
    }
    return false;
  }

  bool checkData() {
    if (title.text.isNotEmpty &&
        description.text.isNotEmpty &&
        cookingTime.text.isNotEmpty &&
        description.text.isNotEmpty) {
      if (pickedImage == null) {
        url = widget.recipeModel.imgPath;

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
      url = widget.recipeModel.imgPath;
    } else {
      url = urlGet;
    }

    // Within your widgets:
    // Image.network(downloadURL);
  }

  RecipeModel get recipe {
    RecipeModel recipe = RecipeModel();
    recipe.title = title.text;
    recipe.description = description.text;
    recipe.cookingTime = cookingTime.text;
    recipe.ingredients = ingredients.text;
    // recipe.prepare = prepare.text;
    recipe.imgPath = url!;
    return recipe;
  }
}
