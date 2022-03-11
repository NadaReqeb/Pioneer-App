
class Offers {
  late String  idMainCategories;
  late String path;
  late String imagePath;
  late String title;
  late String description;
  late String price;
Offers();
  Offers.fromMap(Map<String,dynamic>map){
    title= map['title'];
    description = map['description'];
    imagePath = map['imagePath'];
    price = map['price'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['title']= title;
    map['description']= description;
    map['imagePath'] = imagePath;
    map['price'] = price;
    return map;
  }

}
