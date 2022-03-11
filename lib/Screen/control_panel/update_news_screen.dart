import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/model/news_model.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:pionner_app_admin/widgets/app_text_field.dart';

class UpdateNewsScreen extends StatefulWidget {
  late News news;

  UpdateNewsScreen({required this.news});

  @override
  _UpdateNewsScreenState createState() => _UpdateNewsScreenState();
}

class _UpdateNewsScreenState extends State<UpdateNewsScreen> with Helpers {
  late TextEditingController title;
  late TextEditingController description;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String? url;

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController(text: widget.news.title);
    description = TextEditingController(text: widget.news.description);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    description.dispose();
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
          'تعديل الخبر',
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
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
                                    image: NetworkImage(widget.news.imagePath),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "تعديل صورة",
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
                'تعديل عنوان الخبر',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(height: 10),
              AppTextField1(hint: "عنوان الخبر ", controller: title),
              SizedBox(height: 20),
              Text(
                'تعديل الخبر ',
                style: TextStyle(fontSize: 20, fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(height: 10),
              AppTextField1(hint: "تعديل الخبر", controller: description),
              SizedBox(height: 20),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffDC180F),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60)),
                      onPressed: () async {
                        if (await performUpdatNews()) {
                          Navigator.pop(context);
                        } else {
                          showSnackBar(
                              context: context,
                              content: 'حدث خطأ في اضافة الخبر',
                              error: true);
                        }
                      },
                      child: Text(
                        'تحديث',
                        style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffDC180F),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60)),
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
          ),
        ),
      ),
    );
  }

  Future<bool> performUpdatNews() async {
    if (checkData()) {
      await FbStoreController().updateNews(
          news: news, collectionName: 'News', path: widget.news.path);

      return true;
    }
    return false;
  }

  bool checkData() {
    if (title.text.isNotEmpty && description.text.isNotEmpty) {
      if (pickedImage == null) {
        url = widget.news.imagePath;

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
        context: context,
        content: 'الرجاء ادخال البيانات المطلوبة',
        error: true);
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
                    title: new Text('Photo Library'),
                    onTap: () async {
                      await pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
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
      url = widget.news.imagePath;
    } else {
      url = urlGet;
    }

    // Within your widgets:
    // Image.network(downloadURL);
  }

  News get news {
    News news = News();
    news.title = title.text;
    news.description = description.text;
    news.imagePath = url!;
    return news;
  }
}
