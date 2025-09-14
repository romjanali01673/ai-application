import 'package:ai_application/core/constants/constants.dart';
import 'package:ai_application/core/constants/end_points.dart';
import 'package:ai_application/data/datasources/local/authentication_data.dart';
import 'package:ai_application/data/datasources/local/user_data.dart';
import 'package:ai_application/data/datasources/remote/dio_api_services.dart';
import 'package:ai_application/data/model/user_model.dart';
import 'package:ai_application/presentation/controller/test_controller.dart';
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

          try {
            await login();
          }on DioException catch (e, s) {
            CBase cb = CBase();
            cb.setException(error: e, stackTrace: s);

            // debugPrint("AAA ${e.response?.statusCode.toString()}  ${e.message.toString()} AAA");
          }catch (e){
            // debugPrint( "AA${e.toString()}AA");
          }
          
        }, 
        child: Text("Login"),),
    );
  }

  Future<void> login()async{
    int id = 1; 
    AuthenticationLocalData  authlocaldata = AuthenticationLocalData.instance();
    UserLocalData  userLocalData =  UserLocalData.instance();
    DioApiServices dioApiServices = DioApiServices.instance;
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
    authlocaldata.setIsSignined(true);
    Get.off(()=>HelloScreen());
  }
}