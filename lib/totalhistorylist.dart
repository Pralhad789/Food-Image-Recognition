import 'package:FoodNutrition/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class totalhistorylist extends StatefulWidget {
  @override
  _totalhistorylistState createState() => _totalhistorylistState();
}

class _totalhistorylistState extends State<totalhistorylist> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Query totaltallylist = FirebaseFirestore.instance.collection("UserData")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection("TotalTally")                            
                            .orderBy("Date",descending: true);
  
  List historytotallist = [];

  @override
  void initState() {
    super.initState();
    checkAuthentification();
    fetchlist();  

  }

  checkAuthentification() async{

    _auth.authStateChanges().listen((user) { 

      if(user ==null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
      }
    });
  }

  //## Retrieve data from TotalTally collection
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


  fetchlist() async {
    dynamic resultant = await gethistorydata();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        historytotallist = resultant;
        print('Display Date : -$historytotallist');

      });
    }
  }


  @override
  Widget build(BuildContext){
      return Scaffold(
       appBar: AppBar(
         title: Text('History list'),
         backgroundColor: Colors.redAccent,
       ),

       body: Container(
         child: ListView.builder(
           itemCount: historytotallist.length,
           itemBuilder: (context,index){
             return Card(
               child: ListTile(
                 title: Text(historytotallist[index]['Date']),
                //  subtitle: Text("Calorie:" + historytotallist[index]['Calorie'].toString()+
                //  "  Quantity:"+historytotallist[index]['Quantity'].toString()
                //  ),
                 leading: CircleAvatar(
                   child: Image(
                     image: AssetImage(''),
                   ),
                 ),
                trailing: Text('${historytotallist[index]['TotalValue'].toString()}'),
               ),
             );
           },
         ),
       ),

      );

    }
}