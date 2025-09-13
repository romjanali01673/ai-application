import 'package:ai_application/core/constants/constants.dart';

class UserModel {
  int id;
  String name;
  String website;
  String username;
  String email;
  String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.website,
    required this.username,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
      id: map[Constants.id], 
      name: map[Constants.name], 
      website: map[Constants.website], 
      username: map[Constants.username], 
      email: map[Constants.email], 
      phone: map[Constants.phone],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      Constants.id       : id, 
      Constants.name     : name, 
      Constants.website  : website, 
      Constants.username : username, 
      Constants.email    : email, 
      Constants.phone    : phone,
    };
  }

  UserModel copyWith({
  int? id,
  String? name,
  String? website,
  String? username,
  String? email,
  String? phone,
  }){
    return UserModel(
      id: id??this.id, 
      name: name??this.name, 
      website: website??this.website, 
      username: username??this.username, 
      email: email??this.email, 
      phone: phone??this.phone,
    );
  }

}