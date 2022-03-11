import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pionner_app_admin/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/user_model.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_button_main.dart';
import 'package:pionner_app_admin/widgets/app_search_field.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';


class ChangeName extends StatefulWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> with Helpers {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late TextEditingController _username;
  late User _user;
  late String url;

  // ImagesGetxController controller = Get.put(ImagesGetxController());
  // FbStoreController storeController = FbStoreController();

  @override
  void initState() {
    // TODO: implement initState
    _user = FbAuthController().user;
    _username = TextEditingController(text: _user.displayName ?? 'No Name');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backButtonArrow,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xffDC180F),
            ),
          ),
          title: Text(
            'تغير الاسم',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.right,
          ),

          //actions: [Icon(Icons.arrow_back)],
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50, vertical: 80),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  DecoratedBox(
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
                              borderRadius:
                              BorderRadius.circular(50)),
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
                  SizedBox(width:10),
                  Text(
                    "Add Image",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
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
              'Update Name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            AppTextField1(hint: "user name", controller: _username),
            SizedBox(height: 20),
            AppButtonMain(
                onPressed: () async {
                  await performUpdateNameImage();
                },
                title: 'save'),
            SizedBox(height: 10),
            AppButtonMain(
                onPressed: () {
                  Navigator.pop(context);
                },
                title: 'cancel'),
            SizedBox(height: 10),
            // LinearProgressIndicator(
            //   value: _currentValue,
            // ),
          ]),
        ),
      ),
    );
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
                    title: new Text('Photo Library'),
                    onTap: () {
                      pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
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
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      await uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
      setState(() {});
      // upload();
      await uploadImage();
    }
  }

  Future<void> performUpdateNameImage() async {
    if (checkData()) {
      if (await updateDisplayName()) {}
      Navigator.pushReplacementNamed(context,'/profile_settings');
    }
  }

  bool checkData() {
    if (pickedImage != null) {
      return true;
    }
    showSnackBar(
        context: context, content: 'please pick image and enter your name',error:true);
    return false;
  }

  //   showSnackBar(context: context, content: 'Enter required data',error: true);
  //   return false;
  // }
  Future<bool> updateDisplayName() async {
    bool status =
    await FbAuthController().updateDisplayName(name: _username.text);
    if (status) {
      bool createUser = await FbStoreController()
          .createUser(userData: userData, collectionName: 'Users');
      if (createUser) {
        showSnackBar(context: context, content: 'updated successfully');

        return true;
      }
    }
    showSnackBar(context: context, content: 'updated failed');

    return false;
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
            changeCurrentIndicator(1);
            await downloadURLExample(reference: reference);
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

  // UserModel get user {
  //   UserModel userModel = UserModel();
  //   userModel.name = _username.text;
  //   userModel.imagePath = url;
  //   return user;
  // }

  UserData get userData {
    UserData userData = UserData();
    userData.name = _username.text;
    userData.ImageUrl = url;
    return userData;
  }
  Future<bool> backButtonArrow() async {
    Navigator.pushReplacementNamed(context, '/profile_settings');

    return true;
  }
}
