import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:girisapp/deneme.dart';
import 'package:girisapp/denemelerim/deneme_description.dart';
import 'package:girisapp/user.dart';
import 'package:girisapp/data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DenemeEkle extends StatefulWidget {
  @override
  State<DenemeEkle> createState() => DenemeEkleState();
}
TextEditingController baslikcontrol=TextEditingController();
TextEditingController turdcontrol=TextEditingController();
TextEditingController turycontrol=TextEditingController();
TextEditingController matdcontrol=TextEditingController();
TextEditingController matycontrol=TextEditingController();
TextEditingController sosdcontrol=TextEditingController();
TextEditingController sosycontrol=TextEditingController();
TextEditingController fendcontrol=TextEditingController();
TextEditingController fenycontrol=TextEditingController();

class DenemeEkleState extends State<DenemeEkle> {
  DenemeEkleState(){
    turdcontrol.text = "";
    matdcontrol.text = "";
    sosdcontrol.text = "";
    fendcontrol.text = "";
    turycontrol.text = "0";
    matycontrol.text = "0";
    sosycontrol.text = "0";
    fenycontrol.text = "0";
  }

  void ekleOnay(Deneme deneme) async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseFirestore.instance.collection('tryings')
        .add({
      'denemeAdi': deneme.name,
      'matD': deneme.matD,
      'matY': deneme.matY,
      'turkD': deneme.turkD,
      'turkY': deneme.turkY,
      'fenD': deneme.fenD,
      'fenY': deneme.fenY,
      'sosD': deneme.sosD,
      'sosY': deneme.sosY,
      'username': MyUser.username,
      'time': Timestamp.fromDate(DateTime.now())
    })
        .then((value) {Fluttertoast.showToast(
        msg: "Deneme eklendi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.greenAccent,
        fontSize: 16.0
    );
        setState(() {
          DENEME_DUMMY.add(
            Deneme(
              name: deneme.name,
              id: value.id,
              matD: deneme.matD,
              matY: deneme.matY,
              turkD: deneme.turkD,
              turkY: deneme.turkY,
              fenD: deneme.fenD,
              fenY: deneme.fenY,
              sosD: deneme.sosD,
              sosY: deneme.sosY,
            )
          );
          tryings(MyUser);
        });
    Navigator.pop(context, 'Çık');
        })
        .catchError((error) {
      Fluttertoast.showToast(
          msg: "Bilinmeyen bir hata oluştu.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    });
  }

 void denemeEkleM() {
    if (baslikcontrol.text.isEmpty || matdcontrol.text.isEmpty ||turdcontrol.text.isEmpty ||fendcontrol.text.isEmpty ||sosdcontrol.text.isEmpty || matycontrol.text.isEmpty ||turycontrol.text.isEmpty ||fenycontrol.text.isEmpty ||sosycontrol.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Tüm alanları doldurunuz.",
        gravity: ToastGravity.BOTTOM_LEFT,
        textColor: Colors.white,
        backgroundColor: Color.fromRGBO(17, 45, 78, 1),
      );
    }else {
      try {
        var matd = int.parse(matdcontrol.text);
        var maty = int.parse(matycontrol.text);
        var turd = int.parse(turdcontrol.text);
        var tury = int.parse(turycontrol.text);
        var fend = int.parse(fendcontrol.text);
        var feny = int.parse(fenycontrol.text);
        var sosd = int.parse(sosdcontrol.text);
        var sosy = int.parse(sosycontrol.text);
        if((matd<=0 || matd>=40) || (turd<=0 || turd>=40) || (fend<=0 || fend>=20) || (sosd<=0 || sosd>=20) || (matd+maty<=0 || matd+maty>=40) || (turd+tury<=0 || turd+tury>=40) || (fend+feny<=0 || fend+feny>=20) || (sosd+sosy<=0 || sosd+sosy>=20)){
          Fluttertoast.showToast(
            msg: "Lütfen Netleri Doğru Giriniz.",
            gravity: ToastGravity.BOTTOM_LEFT,
            textColor: Colors.white,
            backgroundColor: Color.fromRGBO(17, 45, 78, 1),
          );
        }
        else{


          var newDeneme =   Deneme(name: baslikcontrol.text,matD: matd,matY: maty,fenD: fend,fenY: feny,sosD: sosd,sosY: sosy,turkD: turd,turkY: tury,id: "");


          ekleOnay(newDeneme);

        }
      }catch (e) {
        Fluttertoast.showToast(
          msg: "Lütfen Sayı Değerleri Giriniz.",
          gravity: ToastGravity.BOTTOM_LEFT,
          textColor: Colors.white,
          backgroundColor: Color.fromRGBO(17, 45, 78, 1),
        );
        throw e;
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;

    return Scaffold(
   /*   floatingActionButton: FloatingActionButton(
        onPressed: (){


        },
        child: const Icon(Icons.check),
        backgroundColor: Color.fromRGBO(17, 45, 78, 1),
      ),*/
      appBar: AppBar(
        title: Text("Deneme Ekle"),
        backgroundColor: Color.fromRGBO(17, 45, 78, 1),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: devicesize.width*0.95,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(63, 114, 175, 0.70),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: devicesize.width*0.2,
                        child: Text(
                            "Başlık:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                    ),
                    Container(
                      width: devicesize.width*0.6,
                      child: TextField(
                          controller: baslikcontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Listede Görünecek İsim",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  width: devicesize.width*0.95,
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(63, 114, 175, 0.70),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: devicesize.width*0.35,
                          child: Text(
                            "Matematik:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                      ),
                      Container(
                          width: devicesize.width*0.25,
                          child: TextField(
                        controller: matdcontrol,
                        keyboardAppearance: Brightness.light,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Doğru",
                          hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                        ),
                      ),
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: matycontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Yanlış",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  width: devicesize.width*0.95,
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(63, 114, 175, 0.70),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: devicesize.width*0.35,
                          child: Text(
                            "Türkçe:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: turdcontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Doğru",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: turycontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Yanlış",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  width: devicesize.width*0.95,
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(63, 114, 175, 0.70),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: devicesize.width*0.35,
                          child: Text(
                            "Fen:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: fendcontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Doğru",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: fenycontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Yanlış",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  width: devicesize.width*0.95,
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(63, 114, 175, 0.70),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: devicesize.width*0.35,
                          child: Text(
                            "Sosyal:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: sosdcontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Doğru",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),
                      Container(
                        width: devicesize.width*0.25,
                        child: TextField(
                          controller: sosycontrol,
                          keyboardAppearance: Brightness.light,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Yanlış",
                            hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 12,),
                          ),
                        ),
                      ),

                    ],
                  )
              ),
              /*    backgroundColor: Color.fromRGBO(17, 45, 78, 1),*/
              TextButton.icon(onPressed: () {
                denemeEkleM();
              }, icon: Icon(Icons.check), label: Text("YENİ DENEME EKLE")),
            ],
          ),
        ),
      ),
    );
  }
}