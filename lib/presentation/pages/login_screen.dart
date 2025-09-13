import 'package:ai_application/core/constants/constants.dart';
import 'package:ai_application/core/constants/end_points.dart';
import 'package:ai_application/data/datasources/local/authentication_data.dart';
import 'package:ai_application/data/datasources/local/user_data.dart';
import 'package:ai_application/data/datasources/remote/dio_api_services.dart';
import 'package:ai_application/data/model/user_model.dart';
import 'package:ai_application/presentation/pages/hello_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: ()async{
          int id = 1; 
          AuthenticationLocalData  authlocaldata = await AuthenticationLocalData.instance();
          UserLocalData  userLocalData = await UserLocalData.instance();
          DioApiServices dioApiServices = DioApiServices.instance;

          try {
            Response<dynamic> response = await dioApiServices.makeRequest(
              method: HTTPMethod.get,
              // EndPoints.user+"sdfa$id",
              EndPoints.user+"$id",
            );

            if(response.statusCode ==200){
              UserModel userModel = UserModel.fromMap((response.data));
              debugPrint(userModel.toMap().toString());
              await userLocalData.setProfileLocally(userModel);
            }
          }on DioException catch (e) {

            debugPrint("AAA ${e.response?.statusCode.toString()}  ${e.message.toString()} AAA");
          }catch (e){
            debugPrint( "AA${e.toString()}AA");
          }
          
          authlocaldata.setIsSignined(true);
          Get.off(()=>HelloScreen());
        }, 
        child: Text("Login"),),
    );
    
  }
}