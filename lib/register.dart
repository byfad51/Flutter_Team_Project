import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'successLogin/sceen.dart';
import 'needed.dart';
late CollectionReference settings;
class register {
  void dbContact() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    users = FirebaseFirestore.instance.collection('users');
    settings = FirebaseFirestore.instance.collection('settings');
  }
  register(TextEditingController giris,TextEditingController controlUsername, TextEditingController controlEmail, TextEditingController controlEmail2, TextEditingController controlPassword, TextEditingController controlPassword2, BuildContext context) {
    dbContact();
    String username = controlUsername.text;
    String email = controlEmail.text;
    String email2 = controlEmail2.text;
    String password = controlPassword.text;
    String password2 = controlPassword2.text;


    if(username=="" ||email == "" ||email2 == ""||password == ""||password2 == "") {
      Fluttertoast.showToast(
          msg: "Kutuları doldurunuz.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
      //exit(1);

      print(EmailValidator.validate(email));
    }else if(username.contains(" ") || email.contains(" ") || password.contains(" ")){
      Fluttertoast.showToast(
          msg: "Boşluk kullanmayınız.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }else if(EmailValidator.validate(email)==false){
      Fluttertoast.showToast(
          msg: "E-posta reddedildi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }else if(email != email2){
      Fluttertoast.showToast(
          msg: "E-postalar eşleşmiyor.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }else if(password != password2){
      Fluttertoast.showToast(
          msg: "Şifreler eşleşmiyor.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );



    }else{

      FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .get()
          .then((DocumentSnapshot documentSnapshot1) {
          FirebaseFirestore.instance
          .collection('deletedUsers')
          .doc(username)
          .get()
          .then((DocumentSnapshot documentSnapshot2) {
        if (documentSnapshot1.exists||documentSnapshot2.exists) {
          //   print(documentSnapshot.data());
          // print(documentSnapshot.get("email"));

          Fluttertoast.showToast(
              msg: "Kullanıcı adı kayıtlı.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.red,
              fontSize: 16.0
          );

        }else{
          FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get()
              .then((QuerySnapshot querySnapshot) {

            if(querySnapshot.size > 0){
              Fluttertoast.showToast(
                  msg: "E-posta kayıtlı.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.red,
                  fontSize: 16.0
              );

            }else{
              users.doc(username).set({"username":username,
                "email":email,
                "password": generateMd5(generateMd5(password).passw).passw,
                "role": 0,
              });
              settings.doc(username).set({
                "bio": "It is bio field.",
                "uniName": "Add a university from settings",
                "resimURL": "https://www.wpdurum.com/uploads/thumbs/profil-resmi-kravatli-adam.jpg",
                "bolumName" : "Add an aim from settings",
                "bioShow": true,
                "uniShow" : true,
                "loginVoice":true,
                "profileCom":true,
                "motivateNotification":true,
                "motivateNotification":false,


              });

              Fluttertoast.showToast(
                  msg: "Kayıt başarılı.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blueGrey,
                  textColor: Colors.greenAccent,
                  fontSize: 16.0
              );
            giris.text = username;
              Navigator.pop(context);

            }
          });
        }
      });});







    }
//users.doc("asdsadasdasfgh11").set({"username":"byfad51","email":"byfad51@gmail.com"});
    // users.add({"kullanici":"denemeonay"});
    //users.add({"username":"fatih"});
  }


}