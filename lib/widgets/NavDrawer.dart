import 'package:FoodNutrition/foodloglist.dart';
import 'package:FoodNutrition/home.dart';
import 'package:FoodNutrition/loginpage.dart';
import 'package:FoodNutrition/totalhistorylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //String uid = _auth.currentUser.uid;
  final CollectionReference userdatalist = FirebaseFirestore.instance
                                .collection("UserData")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection("UserInfo");

  List userinfolist = [];
  int index = 0;
  String username;
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkAuthentification();
    fetchUserInfo();
  }

  Future navigatetodashboard(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => totalhistorylist()));
  }

  Future navigatetoscanimage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future navigatetofoodlog(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => foodloglist()));
  }

  Future navigatetohistorylist(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => totalhistorylist()));
  }
 
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }


  Future getUserInfo() async{
    List userlist = [];

    try{
      await userdatalist.get().then((QuerySnapshot){
        QuerySnapshot.docs.forEach((element){
          userlist.add(element.data());
        });
      });
      return userlist;  
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  
  fetchUserInfo() async{
    dynamic resultant = await getUserInfo();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userinfolist = resultant;
        username = userinfolist[0]['Name'];
        //print('name of user : -${userinfolist[0]}');
      });
    }
  }  
  
  signOut()async{
    _auth.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlutterLogo(
                  size: 80,
                ),
                SizedBox(height: 10),
                Text(
                  'User Name : $username',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            decoration: BoxDecoration(                
                color: Colors.orange,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(''))),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Welcome'),
            onTap: () => navigatetodashboard(context),
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Capture Image'),
             onTap: () => navigatetoscanimage(context),
            //onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Food Log'),
            onTap: () => navigatetofoodlog(context),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () => navigatetohistorylist(context),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => signOut(),            
            //onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}