import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'successLogin/sceen.dart';
import 'user.dart';
import 'deneme.dart';
import 'profile.dart';
List toDoList = [];
List<List> tepkilerList = [];
userInfo myInfo = userInfo();
List<Deneme> DENEME_DUMMY = [];
UserSettings set =UserSettings();
User MyUser=User("","");
/*
class datalarDatalar with ChangeNotifier{
  List GETtoDoList(){
    return toDoList;

  }

  List<List> GETtepkilerList(){
    return tepkilerList;
  }

  userInfo GETmyInfo(){
    return myInfo;
  }



  List<Deneme> GET_DENEME_DUMMY(){
    return DENEME_DUMMY;
  }

  UserSettings GETset(){
    return set;
  }

  User GETMyUser(){
    return MyUser;
  }
}
*/

class tryings //with ChangeNotifier
{

  void dbContact() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
   // users = FirebaseFirestore.instance.collection('users');
  }
  tryings(User myUser){
   // DENEME_DUMMY = [];

    dbContact();
    takeTrying(myUser);
    //notifyListeners();
  }

  takeTrying(User myUser) async {

   // print("//////////////////////////////////////////");
    await FirebaseFirestore.instance
        .collection('tryings').where("username", isEqualTo: myUser.username).orderBy("time", descending: true).limit(15)
        .get()
        .then((QuerySnapshot querySnapshot) {
          try{

            var mapList = querySnapshot.docs.asMap();

            mapList.forEach((key, value) {
              try {
                if(DENEME_DUMMY.length < mapList.length){
                String denemeAdi = value["denemeAdi"];
                int matD = value["matD"];
                int matY = value["matY"];
                int turkD = value["turkD"];
                int turkY = value["turkY"];
                int fenD = value["fenD"];
                int fenY = value["fenY"];
                int sosD = value["sosD"];
                int sosY = value["sosY"];
                DENEME_DUMMY.add(Deneme(
                    name: denemeAdi,
                    fenD: fenD,
                    matD: matD,
                    sosD: sosD,
                    turkD: turkD,
                    fenY: fenY,
                    matY: matY,
                    sosY: sosY,
                    turkY: turkY,
                   id: value.id
                ),);
              }
              } catch (e) {
                print(e);
              }
            });


          }catch(e){

            print(e);
          }

    });

  }


  List<Deneme> getTryings(){
    return DENEME_DUMMY;
  }

}

class profileInfo{
  void dbContact() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    users = FirebaseFirestore.instance.collection('users');
  }
  profileInfo(){
    take();
  }
  Future<void> profileInfo2() async{
    take();
  }
  take() async{
    try{
     await FirebaseFirestore.instance
          .collection('users')
          .doc(MyUser.username)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {

          MyUser.role = documentSnapshot.get("role");
          MyUser.email = documentSnapshot.get("email");
         await setCek();


        }});
    }catch(e){

    }
  }
  Future<void> setCek() async{
    dbContact();
    try{
      await FirebaseFirestore.instance
          .collection('settings')
          .doc(MyUser.username)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {

          set.bio = documentSnapshot.get("bio");
          set.bioShow = documentSnapshot.get("bioShow");
          set.bolumName = documentSnapshot.get("bolumName");
          set.girisSesi = documentSnapshot.get("loginVoice");
          set.motivasyonBildirimi = documentSnapshot.get("motivateNotification");
          set.profilTepkisi = documentSnapshot.get("profileCom");
          set.uniName = documentSnapshot.get("uniName");
          set.uniShow = documentSnapshot.get("uniShow");
          set.resimURL = documentSnapshot.get("resimURL");


        }});
    }catch(e){

    }
  }
}
class userInfo{
  BuildContext? context;
  userInfo({this.context = null}) {
    whatwhat();
  }

  bool a = false;
  String username = controlUsername.text;

  String resimURL="";
  String bio     ="";
  bool bioBool   =false;
  bool hedefBool =false;
  String uniName ="";
  String bolumName="";
  bool profilTepki=false;
  void dbContact() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  Future<bool> varMi() async{
    dbContact();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        a = true;
      }
    });
    return a;
  }
  Future<void> whatwhat() async{
    dbContact();
    if(await varMi()){
      Fluttertoast.showToast(
          msg: "Kullanıcı bulundu.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.greenAccent,
          fontSize: 16.0
      );
      try{

        await FirebaseFirestore.instance
            .collection('settings')
            .doc(username)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {

            bio = documentSnapshot.get("bio");
            bioBool = documentSnapshot.get("bioShow");
            bolumName = documentSnapshot.get("bolumName");
            // profilTepkisi = documentSnapshot.get("profileCom");
            uniName = documentSnapshot.get("uniName");
            hedefBool = documentSnapshot.get("uniShow");
            resimURL = documentSnapshot.get("resimURL");
            profilTepki = documentSnapshot.get("profileCom");

          }});



      }catch(e){

      }
      if(username !="" && context != null){
        await Navigator.of(context!).pushNamed(
          '\\uyeara',
        );
      }
    }else{
      Fluttertoast.showToast(
          msg:"Kullanıcı bulunamadı.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }


  }
}

class tepkiCek{
  tepkiCek(){
      tepkiCekk();
  }
tepkiCekk() async {

    // print("//////////////////////////////////////////");
    await FirebaseFirestore.instance
        .collection('profiltepkileri').where("alan", isEqualTo: MyUser.username).orderBy("time", descending: true).limit(10)
        .get()
        .then((QuerySnapshot querySnapshot) {
      try{

          var mapList = querySnapshot.docs.asMap();
          if(tepkilerList.length < mapList.length) {
            tepkilerList.clear();
          }
          mapList.forEach((key, value) {
            if(tepkilerList.length < mapList.length) {
            try {
              tepkilerList.add(
                  [value.get("veren"), value.get("tepki"), value.get("time")]);
            } catch (e) {
              print(e);
            }
          } });

      }catch(e){

        print(e);
      }

    });

  }
}