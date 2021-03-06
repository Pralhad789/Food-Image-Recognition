import 'dart:ui';
import 'package:FoodNutrition/foodloglist.dart';
import 'package:FoodNutrition/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:FoodNutrition/home.dart';
import 'package:splashscreen/splashscreen.dart';


class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}


class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
      //navigateAfterSeconds: Home(),  
      navigateAfterSeconds: Login(),    
      title: Text('Food Image Recognition',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.white,
      ),
      ),
      image: Image.asset(''),  //can add image icon here
      gradientBackground:LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,stops: [0.004,1],colors: [Color(0xFFa8e063), Color(0xFF56ab2f)]),     
      photoSize: 50,
      loaderColor: Colors.white,

    );
  }
}