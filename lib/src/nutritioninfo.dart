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
  )
];