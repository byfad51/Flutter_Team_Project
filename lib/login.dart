import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:girisapp/programim/database.dart';
import 'successLogin/sceen.dart';
import 'needed.dart';
import 'user.dart';
import 'data.dart';


class login {
  void sesCal() async{
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
    audioPlayer.open(
      Audio('asset/acilis_ses.mp3'),
      autoStart: true,
    );

  }

  String username = "";
  String password = "";
  void dbContact() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    users = FirebaseFirestore.instance.collection('users');
  }
  login(TextEditingController controlUsername, TextEditingController controlPassword){
    loginn( controlUsername,  controlPassword);
  }
  void loginn(TextEditingController controlUsername, TextEditingController controlPassword){
    username = controlUsername.text;
    password = generateMd5(controlPassword.text).passw;
    MyUser = User("","");
    if(username.isEmpty || password.isEmpty){
      Fluttertoast.showToast(
          msg: "Hatalı giriş. Lütfen kutuları boş bırakmayınız.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }else{
      dbContact();
      FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username).where("password", isEqualTo: generateMd5(password).passw)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        if(querySnapshot.size > 0){
          MyUser = User(username,password);

          String email="";
          await FirebaseFirestore.instance
              .collection('users')
              .doc(username)
              .get()
              .then((DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {


              email = documentSnapshot.get("email");
              MyUser.email = email;

              ToDoDataBase();

            }});



          await Fluttertoast.showToast(
              msg: "Giriş başarılı.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.greenAccent,
              fontSize: 16.0
          );


          if(set.girisSesi){
            sesCal();
          }
          tepkiCek();
          tryings(MyUser);
          await profileInfo().profileInfo2().then((value) => runApp(logedScreen())) ;
          //  runApp(logedScreen()) ;


        }else{
          Fluttertoast.showToast(
              msg: "Login denied.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.red,
              fontSize: 16.0
          );
        }


      }
      );
    }

  }

}