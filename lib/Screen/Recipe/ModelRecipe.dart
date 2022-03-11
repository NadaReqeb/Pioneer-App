import 'package:flutter/material.dart';

class RecipeModel {
  late String title, description,path;
  late String cookingTime;
  late // List<String> ingredients = [];
   String imgPath;
  late String ingredients;
  // late String prepare ;
  RecipeModel();
  RecipeModel.fromMap(Map<String,dynamic>map){
    title= map['title'];
    cookingTime= map['cookingTime'];
    description = map['description'];
    imgPath = map['imgPath'];
    ingredients = map['ingredients'];
    // prepare  = map['prepare'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['title']= title;
    map['description']= description;
    map['cookingTime']= cookingTime;
    map['imgPath'] = imgPath;
    map['ingredients'] = ingredients;
    // map['prepar'] = prepare ;
    return map;
  }
}
