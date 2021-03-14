import 'package:flutter/cupertino.dart';

class NutritionInfo{
  final String fName ;
  final int fStdQty;
  final int fStdQtyCalorie;
  final int fprotiens;
  final int ffats;
  final int fcarbohydrates;

  const NutritionInfo({
    this.fName,
    this.fStdQty,
    this.fStdQtyCalorie,
    this.fprotiens,
    this.ffats,
    this.fcarbohydrates
  }); 


  Map<String,dynamic> toJson() => {
   
   'Name' : fName,
   'Quantity' : fStdQty,
   'Calorie' : fStdQtyCalorie,
   'Protiens' : fprotiens,
   'Fats' : ffats,
   'Carbohydrates' : fcarbohydrates
  };

}


final foodItems=[
  new NutritionInfo(
    fName: "Apple",
    fStdQty: 182,
    fStdQtyCalorie: 95,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 25,

  ),

  new NutritionInfo(
    fName: "Orange",
    fStdQty: 100,
    fStdQtyCalorie: 47,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 18,
  ),

  new NutritionInfo(
    fName: "Banana",
    fStdQty: 118,
    fStdQtyCalorie: 110,
    fprotiens: 2,
    ffats: 1,
    fcarbohydrates: 27,
  ),

  new NutritionInfo(
    fName: "Dosa",
    fStdQty: 97,
    fStdQtyCalorie: 68,
    fprotiens: 4,
    ffats: 4,
    fcarbohydrates: 29,
  ),

  new NutritionInfo(
    fName: "Watermelon",
    fStdQty: 286,
    fStdQtyCalorie: 86,
    fprotiens: 2,
    ffats: 0,
    fcarbohydrates: 22,
  ),

  new NutritionInfo(
    fName: "Dates",
    fStdQty: 7,
    fStdQtyCalorie: 20,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 5,
  ),

  new NutritionInfo(
    fName: "VegSandwhich",
    fStdQty: 363,
    fStdQtyCalorie: 560,
    fprotiens: 8,
    ffats: 40,
    fcarbohydrates: 45,
  ),

  new NutritionInfo(
    fName: "Grapes",
    fStdQty: 49,
    fStdQtyCalorie: 34,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 9,
  ),
];