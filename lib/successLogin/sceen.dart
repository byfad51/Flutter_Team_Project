import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:girisapp/denemelerim/deneme_description.dart';
import 'package:girisapp/denemelerim/deneme_ekle.dart';
import 'package:girisapp/denemelerim/denemelistesi.dart';
import 'package:girisapp/main.dart';
import 'package:girisapp/programim/home_page.dart';
import 'package:girisapp/providers/anasayfa.dart';
import 'package:girisapp/search_profile.dart';
import 'package:girisapp/soruekle/cameramain.dart';
import 'package:girisapp/successLogin/settings.dart';
import 'package:girisapp/profile.dart';
import 'package:girisapp/data.dart';
import '../user.dart';

late CollectionReference users;
String username = MyUser.username;
String password = MyUser.password;
int role = MyUser.role;
enum Menu {settings,logout}
class logedScreen extends StatelessWidget {


   const logedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    myUser = MyUser;
    profileInfo();
    tryings(MyUser);
   // tryings(MyUser);
    return MaterialApp(
        title: 'BEKLET',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'BEKLET'),
        routes: {
          '/denemeEkle': (ctx) => DenemeEkle(),
          '/denemelist': (ctx) => Denemelerim(MyUser),
          '/denemedesc': (ctx) => DenemeDescription(index: 0),
          'settings': (ctx) => const MySettingsPage(),
          '\\uyeara': (ctx) => uyeAraSonucScreen(),
        }
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {



int seciliSayfa = 0;
void sayfaDegistir(int index){
  setState(() {

    seciliSayfa = index;
    sayfaGoster(seciliSayfa);
  });
}
Widget yapimda(){
  return const Text("YAPILIYORRR");
}
Widget sayfaGoster(int seciliSayfa){
 // final dataProvider = Provider.of<tryings>(context);
  if(seciliSayfa == 0){
    return MyAppCamera();
  }else if(seciliSayfa == 1){
    return const HomePageProgram();
  }else if(seciliSayfa == 2){
    return const PrototypeYKSBeklet();
  }else if(seciliSayfa == 3){

    //return denemelerim(context, MyUser);
    return Denemelerim(MyUser);
  }else {
    return const profile();
  }
}
  @override
  Widget build(BuildContext context) {
setState(() {
  myUser = MyUser;
  profileInfo();
  tryings(MyUser);
});

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Gitmek istediğinize emin misiniz?'),
          content: const Text("Çıkmak için çıkış'a basınız"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Çık');

                },
              child: const Text('Geri Dön'),
            ),
            TextButton(
              onPressed: () {
              DENEME_DUMMY.clear();
              MyUser = User("","");
              toDoList.clear();
              tepkilerList.clear();
              set =UserSettings();
              runApp(const MyApp());
                },
              child: const Text('Çıkış Yap'),
            ),
          ],
        ),
      );
    }


    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 247, 247,1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(63, 114, 175,1),
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<Menu>(
              onSelected: (Menu item) {
                if(item.name =="settings"){
                  Navigator.of(context).pushNamed(
                    '\settings',
                  );
                }else if(item.name =="logout"){
                  _showMyDialog();

                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.settings,
                  child: Text('Settings'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.logout,
                  child: Text('Logout'),
                ),
              ]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: seciliSayfa,
        onTap: sayfaDegistir,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark_outlined),
              label: "Sorularım",
              backgroundColor: Color.fromRGBO(63, 114, 175,1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda_outlined),
              label: "Programım",
              backgroundColor: Color.fromRGBO(63, 114, 175,1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Anasayfa",
              backgroundColor: Color.fromRGBO(63, 114, 175,1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.try_sms_star_outlined),
              label: "Denemelerim",
              backgroundColor: Color.fromRGBO(63, 114, 175,1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "Profil",
              backgroundColor: Color.fromRGBO(63, 114, 175,1)),
        ],
        backgroundColor: const Color.fromRGBO(63, 114, 175,1),
      ),
body: sayfaGoster(seciliSayfa),

    );
  }
}
