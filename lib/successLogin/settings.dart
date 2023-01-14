import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girisapp/data.dart';
import 'package:girisapp/main.dart';
import 'package:girisapp/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../needed.dart';
late CollectionReference setti;

/*class settingss extends StatelessWidget {
  const settingss({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: const MySettingsPage(),
    );
  }
}*/

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key});

  @override
  State<MySettingsPage> createState() => _MySettingsPage(myUser);

}


class _MySettingsPage  extends State<MySettingsPage> {
  TextEditingController controlPasswordold = TextEditingController();
  TextEditingController controlPasswordNew = TextEditingController();
  TextEditingController controlPasswordNew2 = TextEditingController();
  TextEditingController urlCont = TextEditingController();
  TextEditingController bioCont = TextEditingController();
  TextEditingController schoolCont = TextEditingController();
  TextEditingController bolumCont = TextEditingController();
late User myUser;
late  String username;
late String email;
  void dbContact() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    setti = FirebaseFirestore.instance.collection('settings');
  }
  _MySettingsPage(User user){
  myUser = user;
  username = user.username;
  email = user.email;
}

void hesapSil(){
  String password = controlPasswordold.text;

  if(password ==""){
    Fluttertoast.showToast(
        msg: "Şifrenizi giriniz.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.red,
        fontSize: 16.0
    );
  }else{
    dbContact();

    password = generateMd5(password).passw;

    FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username).where("password", isEqualTo: generateMd5(password).passw)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if(querySnapshot.size > 0){

        users
            .doc(username)
            .delete()
            .then((value) {
          FirebaseFirestore.instance.collection('deletedUsers').doc(username).set({});
        Fluttertoast.showToast(
            msg: "Hesap silindi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.red,
            fontSize: 16.0
        );
          DENEME_DUMMY.clear();
          MyUser = User("","");
          toDoList.clear();
          tepkilerList.clear();
          runApp(const MyApp());
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




      }else{
        Fluttertoast.showToast(
            msg: "Parola yanlış",
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



void sifreDegistir(){
    String oldPass = controlPasswordold.text;
    String newPass = controlPasswordNew.text;
    String newPass2 = controlPasswordNew2.text;
    if(oldPass=="" ||newPass=="" || newPass2==""){
      Fluttertoast.showToast(
          msg: "Kutuları doldurunuz.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }else if(newPass != newPass2){
      Fluttertoast.showToast(
          msg: "Yeni parolalar eşleşmiyor.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0
      );
    }else{
      dbContact();

      oldPass = generateMd5(oldPass).passw;
      newPass = generateMd5(newPass).passw;
      FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username).where("password", isEqualTo: generateMd5(oldPass).passw)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if(querySnapshot.size > 0){
          users
              .doc(username)
              .update({'password': generateMd5(newPass).passw})
              .then((value) => Fluttertoast.showToast(
              msg: "Parola değiştirildi.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.greenAccent,
              fontSize: 16.0
          ))
              .catchError((error) =>  Fluttertoast.showToast(
              msg: "Bilinmeyen bir hata oluştu.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.red,
              fontSize: 16.0
          ));




        }else{
          Fluttertoast.showToast(
              msg: "Esli parola yanlış",
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
  void save() async{
   // dbContact();
final _bio = bioCont.text;
final _school = schoolCont.text;
final _bolum = bolumCont.text;
final _resimURL = urlCont.text;
/* bioGoster
 hedefGoster
 girisSesi
 profilTepkisi
 motivasyonBildirimi
 oturumAcik */
    setti.doc(username).set({
      "bio": _bio,
      "uniName": _school,
      "bolumName" : _bolum,
      "bioShow": bioGoster,
      "uniShow" : hedefGoster,
      "resimURL" : _resimURL,
      "loginVoice":girisSesi,
      "profileCom":profilTepkisi,
      "motivateNotification":motivasyonBildirimi,
 });


    setState(() {
      set.resimURL = _resimURL;
      set.bio = _bio;
      set.uniName=_school;
      set.bolumName=_bolum;
      set.bioShow=bioGoster;
      set.uniShow=hedefGoster;
      set.girisSesi = girisSesi;
      set.profilTepkisi = profilTepkisi;
      set.motivasyonBildirimi =motivasyonBildirimi;

    });
    Fluttertoast.showToast(
        msg: "Ayarlarınız kaydedildi.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.greenAccent,
        fontSize: 16.0
    );
    profileInfo();
   //profileCheck();
  }



  @override
  Widget build(BuildContext context){
    dbContact();
    urlCont.text = set.resimURL;
    bioCont.text = set.bio;
    schoolCont.text = set.uniName;
    bolumCont.text = set.bolumName;

    Future<void> _showMyDialogHesapSil() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('BURAYA RANDOM MOTİVASYON SÖZÜ -- VTDEN'),
          content: const Text("Hesabınızı silmeniz durumunda verileriniz silinecek ve telafisi olmayacaktır."),
          actions: <Widget>[
            TextField(maxLines: 1,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,

                obscureText: true,controller: controlPasswordold,decoration: InputDecoration(icon: Icon(Icons.lock),  hintText: "Password",
                    labelText:"Password")),
            TextButton(
              onPressed: () =>  Navigator.pop(context, 'Vazgeç'),
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () => hesapSil(),
              child: const Text('Hesabımı Sil', style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      );
    }

    Future<void> _showMyDialogSifreDegistir() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            scrollable: true,
            title: const Text('Şifre Değiştir'),

          actions: <Widget>[


            TextField(maxLines: 1,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,

                obscureText: true,controller: controlPasswordold,decoration: InputDecoration(icon: Icon(Icons.lock),  hintText: "Password",
                    labelText:"Password - old")),
            TextField(maxLines: 1,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,

                obscureText: true,controller: controlPasswordNew,decoration: InputDecoration(icon: Icon(Icons.lock),  hintText: "Password",
                    labelText:"Password - new")),
            TextField(maxLines: 1,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,

                obscureText: true,controller: controlPasswordNew2,decoration: InputDecoration(icon: Icon(Icons.lock),  hintText: "Password",
                    labelText:"Password - new")),
            TextButton(
              onPressed: () =>  Navigator.pop(context, 'Vazgeç'),
              child: const Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () => sifreDegistir(),
              child: const Text("Şifre Değiştir"),
            )]
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 247, 247,1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(63, 114, 175,1),
        title: Text("SETTINGS"),
      ),
      body: Container(

        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.name,
                    
                    decoration:  InputDecoration(icon: Icon(Icons.person), hintText: "Username",
                          labelText:username,enabled: false,  iconColor: Colors.red )),
                  TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.name,

                    decoration:  InputDecoration(icon: Icon(Icons.email), hintText: "E-mail",
                          labelText:email,enabled: false, iconColor: Colors.red )),
                  TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.url,

                      controller: urlCont,decoration:  InputDecoration(icon: Icon(Icons.photo), hintText: "Resim Bağlantısı",
                          labelText:"Resim Bağlantısı" ,iconColor: Colors.red )),
                  TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.name,

                      controller: bioCont,decoration:  InputDecoration(icon: Icon(Icons.short_text_sharp), hintText: "Bio",
                          labelText:"Bio" ,iconColor: Colors.red )),

                  TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.name,

                      controller: schoolCont,decoration:  InputDecoration(icon: Icon(Icons.school), hintText: "Okul hedefi",
                          labelText:"Okul", iconColor: Colors.red )),
                  TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.name,

                      controller: bolumCont,decoration:  InputDecoration(icon: Icon(Icons.school_sharp), hintText: "Bölüm hedefi",
                          labelText:"Bölüm", iconColor: Colors.red )),
                  Divider(),
                  MyStatefulWidget(),


              /*    TextField(maxLines: 1,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,

                      obscureText: true, /*controller:controlPassword*/decoration: InputDecoration(icon: Icon(Icons.lock),  hintText: "Password",
                          labelText:"New password"),),*/





                  TextButton.icon(onPressed: () {
                        save();
                  }, icon: Icon(Icons.app_registration_sharp), label: Text("SAVE")),


                  TextButton(onPressed: _showMyDialogSifreDegistir, child: Text("Şifre Değiştir", style: TextStyle(color: Colors.blueGrey))),
                  TextButton(onPressed: _showMyDialogHesapSil, child: Text("HESAP SİL", style: TextStyle(color: Colors.red)))
                /* TextButton(onPressed: () {
                    register(controlUsername,controlEmail,controlEmail2,controlPassword,controlPassword2, context);
                  },child: Text("REGISTER")),*/


                ], //column children
              ),),), //column
        ), //container
      ),
    );
  }
}

///////////////////////




//////////////////////














class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
bool bioGoster = set.bioShow;
bool hedefGoster = set.uniShow;
bool girisSesi = set.girisSesi;
bool profilTepkisi = set.profilTepkisi;
bool motivasyonBildirimi = set.motivasyonBildirimi;
bool oturumAcik = true; /////////// düzenlenecek --- locale kaydedileek
class _MyStatefulWidgetState extends State<MyStatefulWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Divider(),
       // Text(""),


        CheckboxListTile(

          checkColor: Colors.white,
        title: Text("Bio göster"),
          value: bioGoster,
          onChanged: (bool? value) {
            setState(() {
              bioGoster = value!;
            });
          },

        ),

        CheckboxListTile(
          checkColor: Colors.white,
          title: Text("Okul ve bölüm hedefi göster"),
          value: hedefGoster,
          onChanged: (bool? value) {
            setState(() {
              hedefGoster = value!;
            });
          },
        ),
        CheckboxListTile(
          checkColor: Colors.white,
          title: Text("Giriş sesi olsun"),
          value: girisSesi,
          onChanged: (bool? value) {
            setState(() {
              girisSesi = value!;
            });
          },
        ),

        CheckboxListTile(
          checkColor: Colors.white,
          title: Text("Profil tepkisi al"),
          value: profilTepkisi,
          onChanged: (bool? value) {
            setState(() {
              profilTepkisi = value!;
            });
          },
        ),
        CheckboxListTile(
          checkColor: Colors.white,
          title: Text("Motivasyon bildirimi al"),
          value: motivasyonBildirimi,
          enabled: false,
          onChanged: (bool? value) {
            setState(() {
              motivasyonBildirimi = value!;
            });
          },
        ),
        CheckboxListTile(
          checkColor: Colors.white,
          title: Text("Oturumu açık tut"),
          value: oturumAcik,
          enabled: false,
          onChanged: (bool? value) {
            setState(() {
              oturumAcik = value!;
            });
          },
        ),


      ],
    );
  }
}
