import 'dart:io';
import 'package:FoodNutrition/foodloglist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:FoodNutrition/loginpage.dart';
import 'src/nutritioninfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading=true;
  File _image;
  List _output;
  final picker =ImagePicker();
  User firebaseUser;

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    loadModel().then((value){
      setState(() {

      });
    });
  }

  // Firebase authentication to check if user is logged in or not

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;

  checkAuthentification() async{

    _auth.authStateChanges().listen((user) { 

      if(user ==null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
      }
    });
  }

  getUser() async{

    firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if(firebaseUser !=null)
    {
      setState(() {
        this.user =firebaseUser;
        this.isloggedin=true;
      });
    }
  }

  signOut()async{
    _auth.signOut();
  }

  Future<String> getCurrentUID() async {
    return (_auth.currentUser.uid);
  }

  //******************************************/
  
  List<NutritionInfo> _foodItems=foodItems;
  List<NutritionInfo> _filteredFoodItems;

  final NutritionInfo nutrition = NutritionInfo();
  
  classifyImage(File image) async{
    var output=await Tflite.runModelOnImage(path: image.path, numResults: 8,
    threshold: 0.2, imageMean: 127.5, imageStd: 127.5,
    );

    print("The output is : $output");

    _filteredFoodItems = _foodItems.where((e) => e.fName == output[0]['label']).toList();
    print('name of food item : -${_filteredFoodItems[0].fName}');
    print('Standard quantity of food item : -${_filteredFoodItems[0].fStdQty}');
    print('Calorie count item of food item : -${_filteredFoodItems[0].fStdQtyCalorie}');

    //Send data to firebase
    String uid = _auth.currentUser.uid;
    FirebaseFirestore.instance.collection("UserData").doc(uid).collection("FoodItems").add({
      'FoodName' : _filteredFoodItems[0].fName,
      'Quantity' : _filteredFoodItems[0].fStdQty,
      'Calorie'  : _filteredFoodItems[0].fStdQtyCalorie
    });


    setState(() {
      _output=output;
      _loading=false;
    });
  }
  loadModel() async{
    await Tflite.loadModel(model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }
  pickImage() async{
    var image= await picker.getImage(source: ImageSource.camera);
    if(image==null){
      return null;
    }
    setState(() {
      _image=File(image.path);
    });
    classifyImage(_image);
  }
  pickGalleryImage() async{
    var image= await picker.getImage(source: ImageSource.gallery);
    if(image==null){
      return null;
    }
    setState(() {
      _image=File(image.path);
    });
    classifyImage(_image);
  }

  Future navigatetofoodloglist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => foodloglist()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.004,1],
            colors: [Color(0xFFa8e063),Color(0xFF56ab2f),]
            )
        ),
        child: !isloggedin? CircularProgressIndicator():
         Container(
          padding: EdgeInsets.symmetric(horizontal:24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,
              ),
              Text('Predict Food Items', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 28
              ),),
              Text('Custom Tensorflow CNN', style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
              SizedBox(height: 40,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), spreadRadius: 5,blurRadius: 7)],

                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: _loading ? Container(
                          width: 300,
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/nutrition.png'),
                              SizedBox(height: 30,),
                            ],
                          ),
                        ): Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(_image),
                                ),
                              ),
                              SizedBox(height: 20,),
                              _output!=null? Text('Prediction is: ${_output[0]['label']}\n Info: Qty: ${_filteredFoodItems[0].fStdQty} Calorie:${_filteredFoodItems[0].fStdQty}',
                              style: TextStyle(color: Colors.black,
                              fontSize: 20),):Container(

                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children:<Widget> [
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: MediaQuery.of(context).size.width-180,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal:24,vertical: 17),
                              decoration: BoxDecoration(color: Color(0xFF56ab2f),
                              borderRadius: BorderRadius.circular(6)
                              ),
                              child:Text('Take a photo',style: TextStyle(color: Colors.white,fontSize: 18),) ,
                            ),
                          ),
                          SizedBox(height: 5,
                          ),
                          GestureDetector(
                            onTap: pickGalleryImage,
                            child: Container(
                              width: MediaQuery.of(context).size.width-180,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal:24,vertical: 17),
                              decoration: BoxDecoration(color: Color(0xFF56ab2f),
                              borderRadius: BorderRadius.circular(6)
                              ),
                              child:Text('Camera Roll',style: TextStyle(color: Colors.white,fontSize: 18),) ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    child:RaisedButton(

                          padding: EdgeInsets.fromLTRB(70,10,70,10),
                          onPressed: signOut,
                          child: Text('Signout',style: TextStyle( 
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold                      
                          )),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.list),
          onPressed: () {
            navigatetofoodloglist(context);
          },
      ),
    );
  }
}