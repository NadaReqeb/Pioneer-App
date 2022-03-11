import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/main_categories.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class AddCategoryComfort extends StatefulWidget {
  const AddCategoryComfort({Key? key}) : super(key: key);

  @override
  _AddCategoryComfortState createState() => _AddCategoryComfortState();
}

class _AddCategoryComfortState extends State<AddCategoryComfort> with Helpers {
  late TextEditingController _categoryTextController;
  late TextEditingController _desccategoryTextController;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late TextEditingController _username;
  late User _user;
  late String url;

  @override
  void initState() {
    // TODO: implement initState
    _categoryTextController = TextEditingController();
    _desccategoryTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryTextController.dispose();
    _desccategoryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'الاصناف',
          style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
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
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          shrinkWrap: true,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                "اضافة صورة",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoNaskhArabic',
                ),
              ),
            ]),
            Divider(
              color: Colors.white70,
              indent: 10,
              endIndent: 10,
              height: 40,
            ),
            Text(
              'اضافة صنف جديد',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'NotoNaskhArabic',
              ),
            ),
            SizedBox(height: 20),
            AppTextField1(
                hint: "اضافة الصنف", controller: _categoryTextController),
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
                      await performSaveCategories();
                      Navigator.pop(context);
                    },
                    child: Text('إضافة'),
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
                      'إلغاء',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'NotoNaskhArabic'),
                    ),
                  ),
                ],
              ),
            ),
            // LinearProgressIndicator(
            //   value: _currentValue,
            // ),
          ]),
    );
  }

  Future<bool> performSaveCategories() async {
    if (checkData()) {
      await FbStoreController().create(
          mainCategories: mainCategories, collectionName: 'MainCategoriesComfort');
      return true;
    }
    return false;
  }

  bool checkData() {
    if (_categoryTextController.text.isNotEmpty) {
      if (pickedImage != null) {
        // showSnackBar(context: context, content: 'select pick image true');
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
  }

  MainCategories get mainCategories {
    MainCategories mainCategories = MainCategories();
    mainCategories.name = _categoryTextController.text;
    mainCategories.imagePath = url;
    return mainCategories;
  }
  // void clear(){
  //   _categoryTextController.text = '';
  //   _desccategoryTextController.text = '';
  // }
// Future<void> pickImage()async{
//   _pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//   if(_pickedFile != null){
//     setState(() {
//
//     });
//   }
// }
// void uploadImage(){
// if(_pickedFile != null){
//   FbStorageControlle().upload(
//     pickedFile: File(_pickedFile!.path),
//     eventsHandler: (bool status,
//         TaskState state,
//         String message,{Reference?reference}){
//       if(status){
//         showSnackBar(context: context, content: message);
//       }else {
//         if (status == TaskState.running) {
//           //
//         } else {
//           showSnackBar(context: context, content: message, error: true);
//         }
//       }
//     },
//   );
// }else{
//   showSnackBar(context: context, content: 'Pick image to upload', error: true);
//
// }
// }
}
