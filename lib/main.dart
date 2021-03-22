import 'package:FoodNutrition/homesummary.dart';
import 'package:FoodNutrition/loginpage.dart';
import 'package:FoodNutrition/signuppage.dart';
import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:FoodNutrition/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Detection',
      home: MySplash(),
      //home: SummaryHome(),
      debugShowCheckedModeBanner: false,

      routes: <String, WidgetBuilder>{
        "Login" : (BuildContext context) => Login(),
        "Signup" : (BuildContext context) => SignUp(),
      },
    );
  }
}

// Command for SHA1 certificate key :
//keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android