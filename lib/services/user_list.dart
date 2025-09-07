
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class Users{
  List<Map<String, dynamic>> _userList =[];
  List<Map<String, dynamic>> get  getUserList => _userList;


  Future<void> getUserListFromServer()async{
    final response = await http.get(Uri.parse("https://dummyjson.com/users"));

    if(response.statusCode ==200){
      _userList = (jsonDecode(response.body)["users"] as List<dynamic>)
      .map((x){
        return x as Map<String, dynamic>;
      }).toList();

      debugPrint(getUserList[0]["firstName"]);
    }
    else{
      debugPrint("data FAtch error: ${response.statusCode}");
    }

  }
}