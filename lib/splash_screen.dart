

import 'package:ai_application/data/datasources/local/authentication_data.dart';
import 'package:ai_application/presentation/pages/hello_screen.dart';
import 'package:ai_application/presentation/pages/login_screen.dart';
import 'package:ai_application/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/route_manager.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkIsLogin();
    
    return Center(
      child: Text("Loading...", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600),),
    );
  }

  void checkIsLogin(){
    WidgetsBinding.instance.addPostFrameCallback((_){

      AuthenticationLocalData authLocalData = AuthenticationLocalData.instance();
      // await Future.delayed(Duration(milliseconds: 0));
      if(false ||authLocalData.checkIsSignined()){
      // await Future.delayed(Duration(seconds: 1));
        Get.offAll(()=>HelloScreen());
        showInfoToast(description: "Navigating To Hello Screen...");
      }
      else{
        showInfoToast(description: "Navigating To Login Screen...");
        Get.offAll(()=>LoginScreen());
      }
    });
  }
}