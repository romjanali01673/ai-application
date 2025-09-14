import 'dart:convert';

import 'package:ai_application/core/constants/constants.dart';
import 'package:ai_application/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData{
  bool initialized = false;
  static UserLocalData? _instance;
  late SharedPreferences _sharedPreferences;

  // constractor
  UserLocalData._();

  static UserLocalData instance(){
    
    _instance??= UserLocalData._();
    _instance!.initialize();
    return _instance!;
  }


  // shared preferences initialization.
  Future<void> initialize()async{
    if(initialized) return;
    _sharedPreferences = await SharedPreferences.getInstance();
    initialized = true;
  }

  // store data
  Future<void> setProfileLocally(UserModel userModel)async{
   await _sharedPreferences.setString(Constants.profile, jsonEncode(userModel.toMap()));
  }

  // get data
  Future<UserModel?> getProfileLocally()async{
    String? data = await _sharedPreferences.getString(Constants.profile);

    if(data==null){
      return null;
    }
    // decode and return 
    return UserModel.fromMap(jsonDecode(data));
  }

  // clear user profile data
  Future<void> clearUserProfile()async{
    await _sharedPreferences.remove(Constants.profile);
  }
  
}