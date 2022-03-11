class AdminOrder {
  String path = '';
  String created = DateTime.now().toString();
  String userName = '';
  String proName = '';
  String price = '';
  String userImage = '';
  String proImage = '';
  String email = '';
  String quantity = '';
  String size = '';

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['userName'] = userName;
    map['proName'] = proName;
    map['userImage'] = userImage;
    map['proImage'] = proImage;
    map['price'] = price;
    map['email'] = email;
    map['created'] = created;
    map['quantity'] = quantity;
    map['size'] = size;
    return map;
  }
}
