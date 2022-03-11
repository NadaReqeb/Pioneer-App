class UserData {

  late String path;
   late String name ;
  late String email ;
  late String password ;
  late String ImageUrl ;
  late String type ;
UserData();
  // UserData({required this.email,required this.password,});
  UserData.fromMap(Map<String,dynamic>map){
    name= map['name'];
    ImageUrl = map['ImageUrl'];
    type = map['type'];
    email = map['email'];
    password = map['password'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['email'] = email;
    map['password'] = password;
    // map['name'] = name;
    map['ImageUrl'] = ImageUrl;
    map['type'] = type;

    return map;
  }


}