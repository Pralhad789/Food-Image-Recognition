import 'package:FoodNutrition/loginpage.dart';
import 'package:FoodNutrition/totalhistorylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class foodloglist extends StatefulWidget {
  @override
  _foodloglistState createState() => _foodloglistState();
}

class _foodloglistState extends State<foodloglist> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Query fooditemslist = FirebaseFirestore.instance
      .collection("UserData")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("FoodItems")
      .orderBy("Timestamp", descending: true);
  List userfooditemlist = [];
  DocumentSnapshot documentSnapshot;

  @override
  void initState() {
    super.initState();
    checkAuthentification();
    checkCurrentDateExists();
    fetchUserItemList();
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
              .set({"Date": currentdate, "TotalValue": 0});
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
            print(calorietotal);
            print("THE DATE FETCHED FROM FIRESTORE :");
            print(itemsList[i]['DateTime']);
          } else {
            print("No Addition of data");
          }
        }
        print("THE foodloglist CALORIE TOTAL VALUE IS :");
        print(calorietotal);

        //## Update the "calorietotal" variable value to firestore to TotalTally collection
        String uid = _auth.currentUser.uid;
        FirebaseFirestore.instance
            .collection("UserData")
            .doc(uid)
            .collection("TotalTally")
            .doc(currentdate)
            .update({"Date": currentdate, "TotalValue": calorietotal}).then(
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

  Future navigatetohistorylist(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => totalhistorylist()));
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
                       image: AssetImage(''),
                     ),
                   ),
                  trailing: Text('${userfooditemlist[index]['Calorie'].toString()}'),

                 ),
               ),
             );
           },
         ),
       ),
       floatingActionButton: FloatingActionButton(
          child: Icon(Icons.list),
          onPressed: () {
            navigatetohistorylist(context);
          },
      ),
      );

    }

}
