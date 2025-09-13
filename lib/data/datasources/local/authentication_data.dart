import 'package:ai_application/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationLocalData {

  bool initialized = false; 
  static AuthenticationLocalData ? _instance;
  late SharedPreferences sharedPreferences;
  AuthenticationLocalData._();

  static Future<AuthenticationLocalData> instance()async{
    _instance??= AuthenticationLocalData._();
    await _instance!.initialize();
    return _instance!;
  }

  Future<void> initialize()async{
    if(initialized) return;
    sharedPreferences = await SharedPreferences.getInstance();
    initialized = true;
  }

  bool checkIsSignined(){
    return  sharedPreferences.getBool(Constants.isSignined)??false;
  }

  void setIsSignined(bool value ){
    sharedPreferences.setBool(Constants.isSignined, value);
  }
}