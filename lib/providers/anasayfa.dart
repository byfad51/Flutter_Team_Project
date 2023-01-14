import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'auth_page.dart';
import 'questions_page.dart';
import 'results_summary_page.dart';
import 'schedule_page.dart';
import 'tests_page.dart';
import "package:provider/provider.dart";
import 'package:girisapp/data.dart';
import 'package:girisapp/soruekle/cameramain.dart' as addQuestion;
//import 'dart:convert';
//import 'package:http/http.dart';
//import 'package:girisapp/programim/database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:girisapp/denemelerim/denemelistesi.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

String username = MyUser.username;
String uni = set.uniName;
String bolum = set.bolumName;
int done = _MainMenuState().getDoneCount();

class PrototypeYKSBeklet extends StatelessWidget {

  const PrototypeYKSBeklet({super.key});

  @override
  Widget build(BuildContext context) {
    //  cek();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthenticationDetails(placeholder: null),
        ),
        ChangeNotifierProvider.value(
          value: TestsDetails(placeholder: null),
        ),
        ChangeNotifierProvider.value(
          value: QuestionDetails(placeholder: null),
        ),
        ChangeNotifierProvider.value(
          value: SummaryDetails(placeholder: null),
        ),
        ChangeNotifierProvider.value(
          value: ScheduleDetails(placeholder: null),
        ),
      ],
      child: MaterialApp(
        title: "Ana Sayfa",
        theme: ThemeData(
          primaryColorDark: const Color.fromRGBO(25, 44, 76, 1.0),
          primaryColor: const Color.fromRGBO(76, 113, 170, 1.0),
          primaryColorLight: const Color.fromRGBO(150, 171, 203, 1.0),
          backgroundColor: const Color.fromRGBO(247, 247, 250, 1.0),
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).primaryColorDark,
          ),

        ),
        home: const MainMenu(title: "Ana Sayfa"),
        routes: {
          AuthenticationPage.routeName: (context) => const AuthenticationPage(),
          TestsPage.routeName: (context) => const TestsPage(),
          QuestionsPage.routeName: (context) => const QuestionsPage(),
          SummaryPage.routeName: (context) => const SummaryPage(),
          SchedulePage.routeName: (context) => const SchedulePage(),
        },
      ),
    );
  }
}



class _PieData {
  final String xData;
  final num yData;

  _PieData(this.xData, this.yData);
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key, required this.title});

  final String title;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  double getNetAverage() {
    double totalNet = 0;
    if (DENEME_DUMMY.length >= 2) {
      for (int i = 0; i < DENEME_DUMMY.length; i++) {
        totalNet += DENEME_DUMMY[i].getTotalNet();
      }
      return totalNet / DENEME_DUMMY.length;
    }
    else {
      return 0;
    }
  }

  double getLastDenemeNet() {
    if (DENEME_DUMMY.length >= 2) {
      return DENEME_DUMMY[DENEME_DUMMY.length - 1].getTotalNet();
    }
    else {
      return 0;
    }
  }

  String lastDenemeComparison() {
    if ((getNetAverage() > getLastDenemeNet()) && (DENEME_DUMMY.length >= 2)) {
      return "Son deneme netin ortalama netinden ${getNetAverage() - getLastDenemeNet()} net daha düşük.";
    }
    else if ((getNetAverage() < getLastDenemeNet()) && (DENEME_DUMMY.length >= 2)) {
      return "Son deneme netin ortalama netinden ${getNetAverage() - getLastDenemeNet()} net daha yüksek.";
    }
    else if ((getNetAverage() < getLastDenemeNet()) && (DENEME_DUMMY.length >= 2)) {
      return "Son deneme netin ortalama netinle eşit.";
    }
    else {
      return "Sisteme daha fazla deneme gir.";
    }
  }

  int getDoneCount()  {
    int doneCount = 0;
    for (int i = 0; i < toDoList.length; i++) {
      if (toDoList[i][1] == true) {
        doneCount++;
      }
    }
    return doneCount;
  }

  List<_PieData> pieData = [
    _PieData("Tamamlanan", 67),
    _PieData("Tamamlanmayan", 33),
  ];

  /*@override
  void initState() {
    getToDoData().then(results)
  }

  Future<void> getToDoData() async {
    var snapshotsValue = await FirebaseFirestore.instance.collection('aims').where('username', isEqualTo: MyUser).get();
    List<_PieData> list = snapshotsValue.docs.map((e) => _PieData(xData: ))
  }*/

  void cek(){
    uni =  set.uniName;
    bolum = set.bolumName;
  }
  @override
  Widget build(BuildContext context) {
    print(getDoneCount());
    print(toDoList.length);
    setState(() {
      cek();
      getDoneCount();
    });
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: MediaQuery.of(context).size.height * 0.16,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                      spreadRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child:  Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Text(
                    "Merhaba $username! Çalışmaya başla ve üniversiteleri senin için beklet!",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: MediaQuery.of(context).size.height * 0.16,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                      spreadRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Color(0x00FFFFFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3.5,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                            spreadRadius: 2,
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: SfCircularChart(
                          legend: Legend(isVisible: false),
                          centerY: "%50",
                          centerX: "%50",
                          palette: [
                            Theme.of(context).backgroundColor,
                            Colors.transparent,
                          ],
                          margin: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                          series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                              dataSource: pieData,
                              xValueMapper: (_PieData data, _) => data.xData,
                              yValueMapper: (_PieData data, _) => data.yData,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 100,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Bugünkü programını %${(_MainMenuState().getDoneCount() / toDoList.length) * 100} oranında tamamladın.',
                          style:
                          const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 7.5, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.425,
                      height: MediaQuery.of(context).size.height * 0.16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                            spreadRadius: 3,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: const AlignmentDirectional(0, 0),
                      child:  Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Text(
                          '$uni\n$bolum',
                          textAlign: TextAlign.center,
                          style:
                          const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(7.5, 0, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.425,
                      height: MediaQuery.of(context).size.height * 0.16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                            spreadRadius: 3,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Text(
                          "Sisteme ${addQuestion.num} yeni soru yükledin",
                          textAlign: TextAlign.center,
                          style:
                          const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 100,
                height: MediaQuery.of(context).size.height * 0.16,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                      spreadRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 100,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          lastDenemeComparison(),
                          style:
                          const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Color(0x00FFFFFF),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: Image.asset("asset/barchart.png", color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}