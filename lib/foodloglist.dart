import 'package:FoodNutrition/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class foodloglist extends StatefulWidget {
  @override
  _foodloglistState createState() => _foodloglistState();
}

class _foodloglistState extends State<foodloglist> {


final FirebaseAuth _auth = FirebaseAuth.instance;
final Query fooditemslist = FirebaseFirestore.instance.collection("UserData")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection("FoodItems")                            
                            .orderBy("DateTime",descending: true);
List userfooditemlist = [];


@override
  void initState() {
    super.initState();
    checkAuthentification();
    fetchUserItemList();    
  }



  checkAuthentification() async{

    _auth.authStateChanges().listen((user) { 

      if(user ==null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
      }
    });
  }

    
  Future getUserData() async{
    List itemsList = [];
    int calorietotal = 0;
    DateTime date = Timestamp.now().toDate();
    String currentdate = DateFormat('dd-MM-yyyy').format(date);
    print("The CURRENT DATE FROM FOODLOG LIST IS:");
    print(currentdate);
    
    try{
       await fooditemslist.get().then((QuerySnapshot){
         QuerySnapshot.docs.forEach((element){
           itemsList.add(element.data());
         });
       for(var i=0;i<itemsList.length;i++)
       {
         if(itemsList[i]['DateTime'] == currentdate)
         {
              calorietotal = calorietotal + itemsList[i]['Calorie'];
              print(calorietotal);
              print("THE DATE FETCHED FROM FIRESTORE :");
              print(itemsList[i]['DateTime']);
              // print(DateTime.now().toString());
        }
         else
         {
           print("No Addition of data");
         }
           
       }
       print("THE foodloglist CALORIE TOTAL VALUE IS :");
       print(calorietotal);
       
       });
      return itemsList;
    }
    catch(e){
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
        print('name of food item : -${userfooditemlist[1]}');

      });
    }
  }

  
    @override
    Widget build(BuildContext){
      return Scaffold(
       appBar: AppBar(
         title: Text('Food Log list'),
         backgroundColor: Colors.redAccent,
       ),

       body: Container(
         child: ListView.builder(
           itemCount: userfooditemlist.length,
           itemBuilder: (context,index){
             return Card(
               child: ListTile(
                 title: Text(userfooditemlist[index]['FoodName'].toString()),
                 subtitle: Text("Calorie:" + userfooditemlist[index]['Calorie'].toString()+
                 "  Quantity:"+userfooditemlist[index]['Quantity'].toString()
                 ),
                 leading: CircleAvatar(
                   child: Image(
                     image: AssetImage(''),
                   ),
                 ),
                trailing: Text('${userfooditemlist[index]['Calorie'].toString()}'),
               ),
             );
           },
         ),
       ),

      );

    }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Food Log list'),
  //       backgroundColor: Colors.redAccent,
  //     ),
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection("UserData").doc(FirebaseAuth.instance.currentUser.uid).collection("FoodItems").snapshots(),
  //       builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
  //         if(!snapshot.hasData){
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }

  //         return ListView(
  //           children: snapshot.data.docs.map((DocumentSnapshot doc){
  //             return Center(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width/1.2,
  //                 height: MediaQuery.of(context).size.height/6,
  //                 child: Text("Data :" + doc.data()['Name'] + doc.data()['Calorie']),
  //               ),
  //             );

  //           }).toList(),
  //         );
      

  //       },
  //     ),
  //   );
  // }
}