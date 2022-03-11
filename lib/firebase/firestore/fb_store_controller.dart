import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pionner_app_admin/Screen/Recipe/ModelRecipe.dart';
import 'package:pionner_app_admin/model/main_categories.dart';
import 'package:pionner_app_admin/model/main_categories_comfort.dart';
import 'package:pionner_app_admin/model/news_model.dart';
import 'package:pionner_app_admin/model/offers_model.dart';
import 'package:pionner_app_admin/model/product_model.dart';
import 'package:pionner_app_admin/model/product_model_comfort.dart';
import 'package:pionner_app_admin/model/user_model.dart';


class FbStoreController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot> readOrder() async*{
    yield* _firebaseFirestore.collection('adminOrder').snapshots();
  }

  Future<bool> create(
      {required MainCategories mainCategories,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(mainCategories.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> update(
      {required String path,
        required MainCategories mainCategories,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(mainCategories.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> delete(
      {required String path, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> save(
      {required UserData userData,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(userData.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  Stream<QuerySnapshot> read({required String collectionName}) async*{
    yield*_firebaseFirestore.collection(collectionName).snapshots();
  }
  Stream<QuerySnapshot> readUserData({required String collectionName}) async*{
    yield*_firebaseFirestore.collection(collectionName).snapshots();
  }
  Future<bool> createUser({
    required UserData userData,
    required String collectionName,
  }) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(firebaseUser!.uid)
        .set({"ImageUrl": userData.ImageUrl, "name": userData.name})
        .then((value) => true)
        .catchError((error) => false);
  }
  // Future<bool> createUser({
  //   required UserData userData,
  //   required String collectionName,
  // }) async {
  //   return await _firebaseFirestore
  //       .collection("Admins")
  //       .doc(firebaseUser!.uid)
  //       .set({"ImageUrl": userData.ImageUrl, "name": userData.name})
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }

  // Future<String?> getUser({
  //   required String collectionName,
  // }) async {
  //   // var firebaseUser =  FirebaseAuth.instance.currentUser;
  //   return await _firebaseFirestore
  //       .collection(collectionName)
  //       .doc(firebaseUser!.uid)
  //       .get()
  //       .then((value) => UserData.fromMap(value.data()!));
  // }



  Future<bool> createProduct(
      {required Products products, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }



  Future<bool> updateProducts(
      {required String path,
      required Products products,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> createNews(
      {required News news, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(news.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> updateNews(
      {required String path,
      required News news,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(news.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> createOffer(
      {required Offers offers, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(offers.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }



  Future<bool> updateOffer(
      {required String path,
      required Offers offers,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(offers.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }


  //
  // Future<QuerySnapshot> readDataUser({required String collectionName}) async* {
  //   yield* _firebaseFirestore.collection(collectionName).snapshots();
  // }

  Future<bool> addProductCart({required Products products}) async {
    return await _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid).collection('productId').doc(products.path)
        .set({"imagePath":products.imagePath, "name": products.name,'price':products.price,})
        .then((value) => true)
        .catchError((error) => false);
  }



  Stream<QuerySnapshot> readUserProductCart() async*{
    yield*_firebaseFirestore.collection('ItemCart').doc(firebaseUser!.uid).collection('productId').snapshots();
  }

  Future<bool> deleteProducts({required String path}) async {
    return await _firebaseFirestore.collection('ItemCart').doc(firebaseUser!.uid).collection('productId')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> createRecipe(
      {required RecipeModel recipe,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(recipe.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateRecipe(
      {required String path,
        required RecipeModel recipe,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(recipe.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
// ______________________________________________________________________

  Future<bool> addProductComfortCart({required ProductsComfort productsComfort}) async {
    return await _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid).collection('productId').doc(productsComfort.path)
        .set({"imagePath":productsComfort.imagePath, "name": productsComfort.name,'price':productsComfort.price,})
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> updateComfort(
      {required String path,
        required MainCategoriesComfort mainCategoriesComfort,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(mainCategoriesComfort.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> createProductComfort(
      {required ProductsComfort productsComfort, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(productsComfort.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateProductscomfort(
      {required String path,
        required ProductsComfort productsComfort,
        required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(productsComfort.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

}
