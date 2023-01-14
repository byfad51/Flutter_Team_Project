import 'package:flutter/material.dart';
import 'package:girisapp/deneme.dart';
import 'package:girisapp/denemelerim/deneme_description.dart';
import 'package:girisapp/user.dart';
import 'package:girisapp/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../login.dart';

class Denemelerim extends StatefulWidget {
  final User userim;
  Denemelerim(this.userim);
  @override
  State<Denemelerim> createState() => _DenemelerimState(userim);
}

class _DenemelerimState extends State<Denemelerim> {
  final User userim;
  _DenemelerimState(this.userim);
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    tryings(MyUser);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(17, 45, 78, 1),
        onPressed: (){
          Navigator.of(context).pushNamed(
            '/denemeEkle',
          );
        },
        child: Icon(Icons.add),
      ),
      /*appBar: AppBar(
        title: Text("Denemeler"),
        backgroundColor: Color.fromRGBO(17, 45, 78, 1),
      ),*/
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(5),
        child: Container(
          height: devicesize.height * 0.8,
          margin: EdgeInsetsDirectional.all(2),
          padding: EdgeInsetsDirectional.all(5),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: DENEME_DUMMY.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(index.toString()),
                onDismissed: (dismissdirection){

                  FirebaseFirestore.instance.collection('tryings').
                  doc(DENEME_DUMMY[index].id)
                      .delete()
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "Deneme silindi",
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


                    DENEME_DUMMY.removeAt(index);



                },


                background: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.delete),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  padding: EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                   // shape: RoundedRectangleBorder(side: BorderSide.none,borderRadius: BorderRadius.circular(15)),
                   //collapsedShape: RoundedRectangleBorder(side: BorderSide.none,borderRadius: BorderRadius.circular(15)),
                    collapsedBackgroundColor: Color.fromRGBO(63, 114, 175, 1),
                    iconColor: Colors.white,
                    backgroundColor: Color.fromRGBO(63, 114, 175, 1),
                    title: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(63, 114, 175, 0.70),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        padding: EdgeInsets.all(7.5),
                        height: devicesize.width * 0.42,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                              child: Text(
                                DENEME_DUMMY[index].name,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20, overflow: TextOverflow.clip),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        "Türkçe: ${(DENEME_DUMMY[index].turkD-(DENEME_DUMMY[index].turkY/4)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        "Sosyal: ${(DENEME_DUMMY[index].sosD-(DENEME_DUMMY[index].sosY/4)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        "Matematik: ${(DENEME_DUMMY[index].matD-(DENEME_DUMMY[index].matY/4)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        "Fen: ${(DENEME_DUMMY[index].fenD-(DENEME_DUMMY[index].fenY/4)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Text(
                                "Total: ${DENEME_DUMMY[index].getTotalNet().toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            /*
                            Spacer(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.arrow_right_alt_outlined)
                            )
                            */
                          ],
                        ),
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(63, 114, 175, 0.70),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        padding: EdgeInsets.all(7.5),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Ders:",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Türkçe",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Sosyal",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Matematik",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Fen",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Doğru:",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].turkD}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].sosD}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].matD}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].fenD}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("Yanlış:",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].turkY}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].sosY}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].matY}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text("${DENEME_DUMMY[index].fenY}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
