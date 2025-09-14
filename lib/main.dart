

import 'package:ai_application/data/datasources/local/authentication_data.dart';
import 'package:ai_application/data/datasources/local/user_data.dart';
import 'package:ai_application/presentation/pages/hello_screen.dart';
import 'package:ai_application/splash_screen.dart';
import 'package:ai_application/presentation/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  // if we did not called the class's instance may we get an error,
  // bacause sharedPreferences instance return Future instance, 
  // it's take few moment, if i try to perform a opration after fully assign the shared preference instance, it's throw an error.
  await UserLocalData.instance().initialize();
  await AuthenticationLocalData.instance().initialize();
  // await Future.delayed(Duration(milliseconds: 10));
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CUser()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // scaffoldMessengerKey: rootScaffoldMessengerKey,
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home:  SplashScreen(),
    );
  }
}
