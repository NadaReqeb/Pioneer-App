class Cart {
  late int productId;
  late String  price;
  late String name;
  late String imagePath;
  late String quantity;
  late String size;
  late  bool fav;

  Cart();

  Cart.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    quantity = map['quantity'];
    price = map['price'];
    imagePath = map['imagePath'];
    size = map['size'];
    fav = map['fav'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['price'] = price;
    map['imagePath'] = imagePath;
    map['name'] = name;
    map['quantity'] = quantity;
    map['size'] = size;
    map['fav'] = fav;

    return map;
  }
}
