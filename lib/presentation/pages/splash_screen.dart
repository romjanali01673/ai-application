import 'package:ai_application/data/datasources/local/authentication_data.dart';
import 'package:ai_application/presentation/pages/hello_screen.dart';
import 'package:ai_application/presentation/pages/login_screen.dart';
import 'package:ai_application/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key}){}

  @override
  Widget build(BuildContext context) {
    checkIsLogin(context);
    return Center(
      child: Text("Loading...", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600),),
    );
  }

  void checkIsLogin(BuildContext context)async{
    await Future.delayed(Duration(seconds: 1));
    AuthenticationLocalData authLocalData = await AuthenticationLocalData.instance();
    if(authLocalData.checkIsSignined()){
      Get.off(()=>HelloScreen());
      showInfoToast(context: context, description: "Navigating To Hello Screen...");
    }
    else{
      showInfoToast(context: context, description: "Navigating To Login Screen...");
      Get.off(()=>LoginScreen());
    }
  }
}