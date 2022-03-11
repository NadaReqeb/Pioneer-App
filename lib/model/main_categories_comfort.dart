class MainCategoriesComfort {

  late String path;
  late String name ;
  late String imagePath ;

  MainCategoriesComfort();
  MainCategoriesComfort.fromMap(Map<String,dynamic>map){
    name= map['name'];
    imagePath = map['imagePath'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['name']= name;
    map['imagePath'] = imagePath;

    return map;
  }


}