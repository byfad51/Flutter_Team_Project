import 'package:flutter/material.dart';
import 'package:girisapp/deneme.dart';
import 'package:girisapp/user.dart';
import 'package:girisapp/data.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget showDenemeDescription(inx){
  return DenemeDescription(index: inx);
}

class DenemeDescription extends StatelessWidget{
  final int index;
  DenemeDescription({required this.index});
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("DenemeDescription"),
      ),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Column(
            children: [
              Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      width: deviceSize.width * 0.95,
                      child: LinearPercentIndicator(
                        lineHeight: 20,
                        alignment: MainAxisAlignment.center,
                        barRadius: Radius.circular(15),
                        progressColor: Colors.blue,
                        //fillColor: Colors.blue,
                        backgroundColor: Colors.red,
                        animation: true,
                        animationDuration: 1500,
                        percent: DENEME_DUMMY[index].turkD / 40,
                        leading: Container(
                          width: deviceSize.width * 0.2,
                          child: Text("Türkçe D/Y Oranı:",
                            style: TextStyle(
                              decorationStyle: TextDecorationStyle.wavy,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      width: deviceSize.width * 0.95,
                      child: LinearPercentIndicator(
                        lineHeight: 20,
                        alignment: MainAxisAlignment.center,
                        barRadius: Radius.circular(15),
                        progressColor: Colors.blue,
                        //fillColor: Colors.blue,
                        backgroundColor: Colors.red,
                        animation: true,
                        animationDuration: 1500,
                        percent: DENEME_DUMMY[index].sosD / 20,
                        leading: Container(
                          width: deviceSize.width * 0.2,
                          child: Text("Sosyal D/Y Oranı:",
                            style: TextStyle(
                              decorationStyle: TextDecorationStyle.wavy,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      width: deviceSize.width * 0.95,
                      child: LinearPercentIndicator(
                        lineHeight: 20,
                        alignment: MainAxisAlignment.center,
                        barRadius: Radius.circular(15),
                        progressColor: Colors.blue,
                        //fillColor: Colors.blue,
                        backgroundColor: Colors.red,
                        animation: true,
                        animationDuration: 1500,
                        percent: DENEME_DUMMY[index].matD / 40,
                        leading: Container(
                          width: deviceSize.width * 0.2,
                          child: Text("Matematik D/Y Oranı:",
                            style: TextStyle(
                              decorationStyle: TextDecorationStyle.wavy,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      width: deviceSize.width * 0.95,
                      child: LinearPercentIndicator(
                        lineHeight: 20,
                        alignment: MainAxisAlignment.center,
                        barRadius: Radius.circular(15),
                        progressColor: Colors.blue,
                        //fillColor: Colors.blue,
                        backgroundColor: Colors.red,
                        animation: true,
                        animationDuration: 1500,
                        percent: DENEME_DUMMY[index].fenD / 40,
                        leading: Container(
                          width: deviceSize.width * 0.2,
                          child: Text("Fen D/Y Oranı:",
                            style: TextStyle(
                              decorationStyle: TextDecorationStyle.wavy,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.orange,
                          onTap: () {},
                          child: Container(
                              height: deviceSize.height * 0.2,
                              width: deviceSize.width * 0.6,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue,
                                        Colors.blueAccent.shade100
                                      ])
                              ),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Something"),
                                ],
                              )
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.orange,
                          onTap: () {},
                          child: Container(
                              height: deviceSize.height * 0.2,
                              width: deviceSize.width * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue,
                                        Colors.blueAccent.shade100
                                      ])
                              ),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Something"),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.orange,
                          onTap: () {},
                          child: Container(
                              height: deviceSize.height * 0.2,
                              width: deviceSize.width * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue,
                                        Colors.blueAccent.shade100
                                      ])
                              ),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Something"),
                                ],
                              )
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.orange,
                          onTap: () {},
                          child: Container(
                              height: deviceSize.height * 0.2,
                              width: deviceSize.width * 0.6,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue,
                                        Colors.blueAccent.shade100
                                      ])
                              ),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Something"),

                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: deviceSize.width * 0.35,
                                      child: Image.network(
                                          "https://pixselle.com/wp-content/uploads/2020/08/en-guzel-kolay-resimler-4.jpg"))
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }}