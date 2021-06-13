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
  //1
  new NutritionInfo(
    fName: "Apple",
    fStdQty: 182,
    fStdQtyCalorie: 95,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 25,

  ),
  //2
  new NutritionInfo(
    fName: "Oranges",
    fStdQty: 100,
    fStdQtyCalorie: 47,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 18,
  ),
  //3
  new NutritionInfo(
    fName: "Banana",
    fStdQty: 118,
    fStdQtyCalorie: 110,
    fprotiens: 2,
    ffats: 1,
    fcarbohydrates: 27,
  ),
  //4
  new NutritionInfo(
    fName: "Dosa",
    fStdQty: 97,
    fStdQtyCalorie: 68,
    fprotiens: 4,
    ffats: 4,
    fcarbohydrates: 29,
  ),
  //5
  new NutritionInfo(
    fName: "Watermelon",
    fStdQty: 286,
    fStdQtyCalorie: 86,
    fprotiens: 2,
    ffats: 0,
    fcarbohydrates: 22,
  ),
  //6
  new NutritionInfo(
    fName: "Dates",
    fStdQty: 7,
    fStdQtyCalorie: 20,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 5,
  ),
  //7
  new NutritionInfo(
    fName: "VegSandwhich",
    fStdQty: 363,
    fStdQtyCalorie: 560,
    fprotiens: 8,
    ffats: 40,
    fcarbohydrates: 45,
  ),
  //8
  new NutritionInfo(
    fName: "Grapes",
    fStdQty: 49,
    fStdQtyCalorie: 34,
    fprotiens: 1,
    ffats: 0,
    fcarbohydrates: 9,
  ),
  //9
  new NutritionInfo(
    fName: "BreadButter",
    fStdQty: 39,
    fStdQtyCalorie: 168,
    fprotiens: 3,
    ffats: 12,
    fcarbohydrates: 12,
  ),
  //10
  new NutritionInfo(
    fName: "Dhokla",
    fStdQty: 58,
    fStdQtyCalorie: 152,
    fprotiens: 6,
    ffats: 7,
    fcarbohydrates: 16,
  ),
  //11
  new NutritionInfo(
    fName: "EggOmelette",
    fStdQty: 122,
    fStdQtyCalorie: 221,
    fprotiens: 14,
    ffats: 17,
    fcarbohydrates: 1,
  ),
  //12
  new NutritionInfo(
    fName: "Idli",
    fStdQty: 39,
    fStdQtyCalorie: 58,
    fprotiens: 2,
    ffats: 1,
    fcarbohydrates: 12,
  ),
  //13
  new NutritionInfo(
    fName: "Mango",
    fStdQty: 336,
    fStdQtyCalorie: 202,
    fprotiens: 3,
    ffats: 1,
    fcarbohydrates: 50,
  ),
  //14
  new NutritionInfo(
    fName: "Misal Pav",
    fStdQty: 226,
    fStdQtyCalorie: 224,
    fprotiens: 10,
    ffats: 8,
    fcarbohydrates: 42,
  ),
  //15
  new NutritionInfo(
    fName: "Pancakes",
    fStdQty: 80,
    fStdQtyCalorie: 182,
    fprotiens: 6,
    ffats: 8,
    fcarbohydrates: 23,
  ),
  //16
  new NutritionInfo(
    fName: "PavBhaji",
    fStdQty: 404,
    fStdQtyCalorie: 390,
    fprotiens: 12,
    ffats: 11,
    fcarbohydrates: 63,
  ),
  //17
  new NutritionInfo(
    fName: "Pohe",
    fStdQty: 139,
    fStdQtyCalorie: 158,
    fprotiens: 3,
    ffats: 1,
    fcarbohydrates: 35,
  ),
  //18
  new NutritionInfo(
    fName: "Samosa",
    fStdQty: 100,
    fStdQtyCalorie: 262,
    fprotiens: 4,
    ffats: 17,
    fcarbohydrates: 24,
  ),
  //19
  new NutritionInfo(
    fName: "Tea",
    fStdQty: 243,
    fStdQtyCalorie: 62,
    fprotiens: 3,
    ffats: 3,
    fcarbohydrates: 5,
  ),
  //20
  new NutritionInfo(
    fName: "Upma",
    fStdQty: 155,
    fStdQtyCalorie: 132,
    fprotiens: 3,
    ffats: 4,
    fcarbohydrates: 21,
  ),

  
];