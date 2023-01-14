import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data.dart';
import 'dialog_box.dart';
import 'todo_tile.dart';


class HomePageProgram extends StatefulWidget {
  const HomePageProgram({super.key});

  @override
  State<HomePageProgram> createState() => _HomePageState();
}
class _HomePageState extends State<HomePageProgram> {
  void deleteTask(int index) async {


    FirebaseFirestore.instance.collection('aims').
        doc(toDoList[index][2])
        .delete()
        .then((value) {
      Fluttertoast.showToast(
            msg: "Hedef silindi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );

    })
        .catchError((error) => Fluttertoast.showToast(
        msg: "Bilinmeyen bir hata oluştu",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.red,
        fontSize: 16.0
    ));


    setState(() {
      toDoList.removeAt(index);

    });

  }


  final _controller = TextEditingController();
  Future<void> updateAim(int index){
   /* WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();*/
    return FirebaseFirestore.instance.collection('aims')
        .doc(toDoList[index][2])
        .update({'didIt': !toDoList[index][1]})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  void checkBoxChanged(bool? value, int index) { // checkbox was tapped
    setState(() {
      updateAim(index);
      toDoList[index][1] = !toDoList[index][1];
    });

  }
  void saveNewTask() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var timeWhat = Timestamp.fromDate(DateTime.now());
 FirebaseFirestore.instance.collection('aims')
        .add({
      'username': MyUser.username,
      'aimName': _controller.text,
      'didIt': false,
      'time': timeWhat
    })
        .then((value) {Fluttertoast.showToast(
        msg: "Yeni görev eklendi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.greenAccent,
        fontSize: 16.0);
    } );
  // String id ="";
    List<QueryDocumentSnapshot> list = await FirebaseFirestore.instance
        .collection('aims')
        .where('time', isEqualTo: timeWhat).where('username', isEqualTo: MyUser.username)
        .get()
        .then((snapshot) => snapshot.docs);
    setState(()  {
list.forEach((element) {
  toDoList.add([_controller.text, false, element.id]);
});


      _controller.clear();
    });
   Navigator.of(context).pop();

  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  /*void deleteTask(int index) {
    setState(() {

    });

  }*/
  @override
  Widget build(BuildContext context) {
    setState(() {
      //toDoList = toDoListCek;
    });

    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
