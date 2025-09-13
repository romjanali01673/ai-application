

import 'package:ai_application/presentation/pages/hello_screen.dart';
import 'package:ai_application/presentation/pages/splash_screen.dart';
import 'package:ai_application/presentation/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  
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
      scaffoldMessengerKey: rootScaffoldMessengerKey,
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

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();