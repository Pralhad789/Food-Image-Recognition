import 'dart:io';
import 'package:FoodNutrition/home.dart';
import 'package:FoodNutrition/totalhistorylist.dart';
import 'package:FoodNutrition/widgets/NavDrawer.dart';
import 'package:FoodNutrition/widgets/speeddialwidget.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:intl/intl.dart';
import 'package:FoodNutrition/foodloglist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FoodNutrition/loginpage.dart';


class SummaryHome extends StatefulWidget {
  SummaryHome({Key key}) : super(key: key);

  @override
  _SummaryHomeState createState() => _SummaryHomeState();
}

class _SummaryHomeState extends State<SummaryHome> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Query fooditemslist = FirebaseFirestore.instance
      .collection("UserData")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("FoodItems")
      .orderBy("Timestamp", descending: true);
  List userfooditemlist = [];
  DocumentSnapshot documentSnapshot;
  User firebaseUser;
  User user;
  bool isloggedin= false; 
  String sumcalorie,sumprotien,sumcarb,sumfat;

  @override
  void initState() {
    super.initState();
    checkAuthentification(); 
    checkCurrentDateExists();   
    fetchUserItemList();
    fetchtotalsumlist();
      
    
      
  }

  //## Check user authentication
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
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

  //## Check if a document of current date exists on firestore
  checkCurrentDateExists() async {
    DateTime date = Timestamp.now().toDate();
    String currentdate = DateFormat('dd-MM-yyyy').format(date);
    try {
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("TotalTally")
          .doc(currentdate)
          .get()
          .then((doc) {
        if (!doc.exists) {
          FirebaseFirestore.instance
              .collection("UserData")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection("TotalTally")
              .doc("$currentdate")
              .set({"Date": currentdate, "TotalValue": 0,
                     "CarbohydrateTotal": 0,
                     "FatTotal":0,
                     "ProtienTotal":0});
          print("A NEW DOCUMENT SUCCESSFULLY CREATED");
        } else {
          print("DOCUMENT NOT CREATED");
        }
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUserData() async {
    List itemsList = [];
    int calorietotal = 0;
    int protientotal = 0;
    int carbtotal = 0;
    int fattotal = 0;

    DateTime date = Timestamp.now().toDate();
    String currentdate = DateFormat('dd-MM-yyyy').format(date);
    print("The CURRENT DATE FROM FOODLOG LIST IS:");
    print(currentdate);

    //## Retrieve list from firestore and also calculate the total calorie values

    try {
      await fooditemslist.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
        for (var i = 0; i < itemsList.length; i++) {
          if (itemsList[i]['DateTime'] == currentdate) {
            calorietotal = calorietotal + itemsList[i]['Calorie'];
            protientotal = protientotal + itemsList[i]['Protiens'];
            carbtotal = carbtotal + itemsList[i]['Carbohydrates'];
            fattotal = fattotal + itemsList[i]['Fats'];
            
            print(calorietotal);
            print("THE DATE FETCHED FROM FIRESTORE :");
            print(itemsList[i]['DateTime']);
          } else {
            print("No Addition of data");
          }
        }
        print("THE foodloglist CALORIE TOTAL VALUE IS :");
        print(calorietotal);
        print(protientotal);
        print(carbtotal);
        print(fattotal);

        //## Update the "calorietotal" variable value to firestore to TotalTally collection
        String uid = _auth.currentUser.uid;
        FirebaseFirestore.instance
            .collection("UserData")
            .doc(uid)
            .collection("TotalTally")
            .doc(currentdate)
            .update({"Date": currentdate, "TotalValue": calorietotal,
                      "ProtienTotal" : protientotal,
                      "CarbohydrateTotal" : carbtotal,
                      "FatTotal" : fattotal}).then(
                (_) {
          print("Success");
        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchUserItemList() async {    
    dynamic resultant = await getUserData();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userfooditemlist = resultant;
        print('name of food item : -${userfooditemlist[0]}');
      });
    }
  }

  final Query totaltallylist = FirebaseFirestore.instance.collection("UserData")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection("TotalTally")                            
                            .orderBy("Date",descending: true);
  
  List historytotallist = [];

  Future gethistorydata() async {
    List retrievedlist = [];

    try{

      await totaltallylist.get().then((QuerySnapshot){
        QuerySnapshot.docs.forEach((element){
          retrievedlist.add(element.data());
        });
      });
      return retrievedlist;

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  fetchtotalsumlist() async {
    dynamic resultant = await gethistorydata();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        historytotallist = resultant;   
        sumcalorie = historytotallist[0]['TotalValue'].toString();
        sumprotien = historytotallist[0]['ProtienTotal'].toString();
        sumcarb = historytotallist[0]['CarbohydrateTotal'].toString();
        sumfat = historytotallist[0]['FatTotal'].toString();
      });
      print('DISPLAY TOTAL : ');
        print(historytotallist[0]['TotalValue']);
        print(historytotallist[0]['ProtienTotal']);
        print(historytotallist[0]['CarbohydrateTotal']);
        print(historytotallist[0]['FatTotal']);
        
    }
  }

  Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
      ],
    ),
  ) ??
      false;
}
   
  Future navigatetofoodloglist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home())).whenComplete(fetchUserItemList());
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home())).whenComplete(fetchtotalsumlist());
  }

  Future navigatetoscanImage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home())).whenComplete(fetchUserItemList());
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home())).whenComplete(fetchtotalsumlist());
  }


  Future navigatetohistorylist(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => totalhistorylist()));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: _onBackPressed,
       child: Scaffold(    
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Your food, At a glance!'),
            centerTitle: true,            
            // leading: IconButton(
              
            //   icon:Icon(Icons.list),
            //   onPressed: (){
            //      // NavDrawer();
            //   },
            //  ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.add_circle), onPressed: (){}),
              IconButton(icon: Icon(Icons.backspace_rounded), onPressed: (){}),
              
            ],
            pinned: true,
            floating: true,
            expandedHeight: 210.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(top: 120, bottom: 5),
                width: MediaQuery.of(context).size.width,
                height: 100.0,                
                child: ListView(
                  
                  scrollDirection:Axis.horizontal,
                  children:<Widget>[
                    Container(
                      height: 50,
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text('CALORIES'),
                          //subtitle: num(historytotallist[0]['TotalValue']),
                          subtitle: Text('$sumcalorie'),
                        ),
                      )
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text('PROTEINS'),
                          subtitle: Text('$sumprotien'),
                        ),
                      )
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text('CARBOHYDRATES'),
                          subtitle: Text('$sumcarb'),
                        ),
                      )
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text('FATS'),
                          subtitle: Text('$sumfat'),
                        ),
                      )
                    ),
                  ]
                ),
              ),

            ),
          ),
          SliverList(            
            delegate: SliverChildBuilderDelegate(                                                        
              (BuildContext context, int index){
                return Card(
                  child: Container(
                 height: 65,                 
                 child: ListTile(
                   title: Text(userfooditemlist[index]['FoodName'].toString()),
                   subtitle: Text("Calorie :\t" + userfooditemlist[index]['Calorie'].toString()+"\t\t"+
                   "Protiens :\t"+userfooditemlist[index]['Protiens'].toString()+"\t\n"+
                   "Carbohydrates :\t"+userfooditemlist[index]['Carbohydrates'].toString()+"\t\t"+
                   "Fats :\t"+userfooditemlist[index]['Fats'].toString()
                   ),
                   leading: CircleAvatar(
                     child: Image(
                       image: AssetImage('assets/foodlisticon.png'),
                     ),
                   ),
                  trailing: Text('${userfooditemlist[index]['Calorie'].toString()}'),

                 ),
               ),
                );
              },
              childCount: userfooditemlist.length,
            ),
          )
        ],
      ),
      // floatingActionButton: SpeedDialWidget(), 
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigatetoscanImage(context);
          },
      ),     
      drawer: NavDrawer(),
     ),
    );
    
  }
}