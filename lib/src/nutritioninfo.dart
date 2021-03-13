import 'package:flutter/cupertino.dart';

class NutritionInfo{
  final String fName ;
  final int fStdQty;
  final int fStdQtyCalorie;

  const NutritionInfo({
    this.fName, this.fStdQty, this.fStdQtyCalorie
  }); 


  Map<String,dynamic> toJson() => {
   
   'Name' : fName,
   'Quantity' : fStdQty,
   'Calorie' : fStdQtyCalorie,
  };

}


final foodItems=[
  new NutritionInfo(
    fName: "Apple",
    fStdQty: 182,
    fStdQtyCalorie: 95,
  ),

  new NutritionInfo(
    fName: "Orange",
    fStdQty: 100,
    fStdQtyCalorie: 47
  ),

  new NutritionInfo(
    fName: "Banana",
    fStdQty: 118,
    fStdQtyCalorie: 110
  ),

  new NutritionInfo(
    fName: "Dosa",
    fStdQty: 97,
    fStdQtyCalorie: 68
  ),

  new NutritionInfo(
    fName: "Watermelon",
    fStdQty: 286,
    fStdQtyCalorie: 86
  ),

  new NutritionInfo(
    fName: "Dates",
    fStdQty: 7,
    fStdQtyCalorie: 20
  ),

  new NutritionInfo(
    fName: "VegSandwhich",
    fStdQty: 363,
    fStdQtyCalorie: 560
  ),

  new NutritionInfo(
    fName: "Grapes",
    fStdQty: 49,
    fStdQtyCalorie: 34
  ),
];