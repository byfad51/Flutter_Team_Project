import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'data.dart';
/*Navigator.of(context).pushNamed(
'\register',
);*/
/*
bool a = false;
String username = controlUsername.text;

late String resimURL;
late String bio;
late bool bioBool;
late bool hedefBool;
late String uniName;
late String bolumName;*/
TextEditingController mesajController = TextEditingController();
class uyeAraSonucScreen extends StatelessWidget {


   uyeAraSonucScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: _uyeAraSonucScreen(),

    );
  }
}

class _uyeAraSonucScreen extends StatelessWidget{

  _uyeAraSonucScreen();

  bool a = myInfo.a;
  String username = myInfo.username;

  String resimURL=myInfo.resimURL;
  String bio     =myInfo.bio;
  bool bioBool   =myInfo.bioBool;
  bool hedefBool =myInfo.hedefBool;
  String uniName =myInfo.uniName;
  String bolumName=myInfo.bolumName;
  bool tepkiAl = myInfo.profilTepki;
  void dbContact() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

void _mesajEkle(){
  dbContact();
  String isim = MyUser.username + "-"+username;
  FirebaseFirestore.instance
      .collection('profiltepkileri').doc(isim).set({
    "alan":username,
    "veren":MyUser.username,
    "tepki":mesajController.text,
    "okunduMu":false,
    "time":Timestamp.fromDate(DateTime.now()),
  });
  Fluttertoast.showToast(
      msg: "Mesajınız eklendi.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.greenAccent,
      fontSize: 16.0
  );
}
@override
Widget build(BuildContext context) {
  if (a) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(63, 114, 175,1),
          title: Text(username),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 125,
          width: 125,
          child: Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Image.network(resimURL)

          ),
        ),
        Container(child: Column(children: [
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(
              username, style: TextStyle(fontSize: 25, color: Colors.brown),),),

        ])),
        Visibility(
          child: Card(
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                ListTile(

                  leading: Icon(Icons.short_text_sharp),
                  title: Text(bio),

                ),

              ],
            ),
          ),
          // maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: bioBool,
        ),
        Visibility(
          child: Card(
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(

                  leading: Icon(Icons.school),
                  title: Text(uniName),

                  subtitle: Text(bolumName),

                ),

              ],
            ),
          ),
          // maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: hedefBool,
        )
        ,
        Visibility(
          child: Card(
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(

                  title:  Text("Yorum bırak:"),
                  subtitle:  TextField(maxLines: 1,controller: mesajController,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(icon: Icon(Icons.message),hintText: "Mesajınız:", labelText: "Mesajınız"),),
                   ),
                TextButton.icon(onPressed: () {
                      _mesajEkle();
                }, icon: Icon(Icons.send), label: Text("Mesajı Gönder")),
                Text("Sadece bir mesaj gönderebilirsiniz, yeni gönderdiğiniz mesaj, eskisiyle güncellenecektir.", style: TextStyle(color: Colors.red),)
              ],
            ),
          ),
          // maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: tepkiAl,
        )
      ],
    )));
  }else{
    searchUser();
    return Scaffold(appBar: AppBar(
      backgroundColor: Color.fromRGBO(63, 114, 175,1),
      title: Text("Kullanıcı ara"),
    ),backgroundColor: Colors.white, body:

    Center(child:Text("Kullanıcı bulunamadı. @$username", style: TextStyle(fontSize: 16),)));
  }
}


  Future<void> searchUser() async {
    dbContact();
    /*await FirebaseFirestore.instance.collection('users').where('username', isGreaterThan: username).get().then((QuerySnapshot querySnapshot) {
      var mapList = querySnapshot.docs.asMap();
      mapList.forEach((key, value) {
        print(value["username"]);
      });

    });*/
    //return Text("");
  }
}


