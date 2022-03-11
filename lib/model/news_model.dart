
class News {
  late String  idMainCategories;
  late String path;
  late String imagePath;
  late String title;
  late String description;
  late String time;
News();
  News.fromMap(Map<String,dynamic>map){
    title= map['title'];
    description = map['description'];
    imagePath = map['imagePath'];
    time = map['time'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['title']= title;
    map['description']= description;
    map['imagePath'] = imagePath;
    map['time'] = time;
    return map;
  }

}
