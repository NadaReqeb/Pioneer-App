class Products {
  late String  idMainCategories;
  late String  price;
  late String name;
  late String imagePath;
  late String description;
  late String size;
  late String shortDescription;
  late String mainCategoriesName;
  late String path;

  Products();

  Products.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    idMainCategories = map['idMainCategories'];
    price = map['price'];
    imagePath = map['imagePath'];
    description = map['description'];
    size = map['size'];
    shortDescription = map['shortDescription'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['price'] = price;
    map['imagePath'] = imagePath;
    map['description'] = description;
    map['size'] = size;
    map['shortDescription'] = shortDescription;
    map['name'] = name;
    map['idMainCategories'] = idMainCategories;

    return map;
  }
}
