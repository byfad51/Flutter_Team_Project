import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:girisapp/data.dart';

class ToDoDataBase {

  ToDoDataBase(){
    createInitialData();
  }
  // reference our box
  //final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    List<QueryDocumentSnapshot> list = await FirebaseFirestore.instance
        .collection('aims')
        .where('username', isEqualTo: MyUser.username)
        .get()
        .then((snapshot) => snapshot.docs);

    for(var value in list) {
      toDoList.add([value.get("aimName"),value.get("didIt"), value.id]);
     // print(value.id);
    }

    /*await FirebaseFirestore.instance
        .collection('aims').where("username", isEqualTo: MyUser.username).orderBy("time", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      try{
        //querySnapshot.docs.
      //  List<DocumentSnapshot> list
        //  querySnapshot.docs.
        var mapList = querySnapshot.docs.asMap();
        mapList.forEach((key, value) {
          try {
            if(toDoList.length < mapList.length){
              toDoList.add([value["aimName"],value["didIt"]]);
            }
          } catch (e) {
            print("////////////////////------------------------------------------");
            print(e);
          }
        });


      }catch(e){

        print(e);
      }

    });*/
  }

 /* void createInitialData() {

    toDoList = [

    ];
  }*/

  // load the data from database
  void loadData() {
    createInitialData();
  }

  // update the database
  void updateDataBase() {
  //  _myBox.put("PROGRAMIM", toDoList);
    createInitialData();
  }
}
