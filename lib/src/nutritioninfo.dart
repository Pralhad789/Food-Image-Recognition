import 'package:flutter/cupertino.dart';

class NutritionInfo{
  final String fName ;
  final int fStdQty;
  final int fStdQtyCalorie;

  const NutritionInfo({
    this.fName, this.fStdQty, this.fStdQtyCalorie
  }); 
}

final foodItems=[
  new NutritionInfo(
    fName: "Apple",
    fStdQty: 100,
    fStdQtyCalorie: 20,
  ),

  new NutritionInfo(
    fName: "Orange",
    fStdQty: 80,
    fStdQtyCalorie: 10
  )
];