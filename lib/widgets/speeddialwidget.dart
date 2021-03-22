import 'dart:async';

import 'package:FoodNutrition/foodloglist.dart';
import 'package:FoodNutrition/home.dart';
import 'package:FoodNutrition/homesummary.dart';
import 'package:FoodNutrition/totalhistorylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialWidget extends StatefulWidget {
  @override
  _SpeedDialWidgetState createState() => _SpeedDialWidgetState();
}

class _SpeedDialWidgetState extends State<SpeedDialWidget> {

  
  Future navigatetoscanImage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future navigatetofoodloglist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => foodloglist()));
  }

  Future navigatetohistorylist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => totalhistorylist()));
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial( 
      animatedIcon: AnimatedIcons.menu_close, 
      animatedIconTheme: IconThemeData(size: 28.0), 
      backgroundColor: Colors.green[900], 
      visible: true, 
      curve: Curves.bounceInOut, 
      children: [ 
        SpeedDialChild( 
          child: Icon(Icons.chrome_reader_mode, color: Colors.white), 
          backgroundColor: Colors.green, 
          onTap: () {navigatetoscanImage(context);},
          //onTap: () => print('Pressed Read Later'), 
          label: 'Food Log List', 
          labelStyle: 
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white), 
          labelBackgroundColor: Colors.black, 
        ), 
        SpeedDialChild( 
          child: Icon(Icons.create, color: Colors.white), 
          backgroundColor: Colors.green, 
          onTap: () {navigatetofoodloglist(context);},
          //onTap: () => print('Pressed Write'), 
          label: 'History List', 
          labelStyle: 
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white), 
          labelBackgroundColor: Colors.black, 
        ),         
      ], 
    ); 
  }
}