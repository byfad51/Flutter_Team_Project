import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'login.dart';
import 'user.dart';
late CollectionReference users;

void main() async{
  /*await Hive.initFlutter();

  var box = await Hive.openBox('mybox');*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  users = FirebaseFirestore.instance.collection('users');
  runApp(const MyApp());

}

 TextEditingController controlUsername = TextEditingController();
 TextEditingController controlEmail = TextEditingController();
 TextEditingController controlEmail2 = TextEditingController();
 TextEditingController controlPassword = TextEditingController();
 TextEditingController controlPassword2 = TextEditingController();
 TextEditingController controlGirisUsername = TextEditingController();
 TextEditingController controlGirisPassword = TextEditingController();

late User myUser;
class MyApp extends StatelessWidget {

  const MyApp({super.key});
  /*
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: datalarDatalar(),
        ),

      ],
      child: MaterialApp(
          title: 'BEKLET LOGIN',
          /* theme: ThemeData(

        primarySwatch: Colors.blue,
      ),*/
          home: const MyHomePage(title: 'BEKLET - Giriş Yap'),
          routes: {
            '\register': (ctx) => const RegisterScreen(),

          }
      ),
    );
  }*/
 @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'BEKLET LOGIN',
     /* theme: ThemeData(

        primarySwatch: Colors.blue,
      ),*/
      home: const MyHomePage(title: 'BEKLET - Giriş Yap'),
        routes: {
          '\register': (ctx) => const RegisterScreen(),

        }
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: const Color.fromRGBO(249, 247, 247,1),
      appBar: AppBar(
        backgroundColor:  const Color.fromRGBO(63, 114, 175,1),
        title: const Text("Kayıt Ol"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Üye olmak için tüm kutuları eksiksiz doldurunuz."),
                TextField(maxLines: 1,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,controller: controlUsername,decoration:
                    const InputDecoration(icon: Icon(Icons.person), hintText: "Kullanıcı Adı",
                    labelText:"Kullanıcı Adı" )),
                TextField( maxLines: 1,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,

                    autofocus: true,controller: controlEmail,decoration:
                    const InputDecoration(icon: Icon(Icons.email),  hintText: "E-posta",
                    labelText:"E-posta" )),
                TextField(maxLines: 1,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: controlEmail2,decoration: const InputDecoration(icon: Icon(Icons.email),  hintText: "E-posta (tekrar)",
                    labelText:"E-posta (tekrar)" ,)),
                TextField(maxLines: 1,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,

                    obscureText: true,controller: controlPassword,decoration: const InputDecoration(icon: Icon(Icons.lock),  hintText: "Şifre",
                    labelText:"Şifre")),
                TextField(maxLines: 1,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,controller: controlPassword2,decoration: const InputDecoration(icon: Icon(Icons.lock),  hintText: "Şifre (tekrar)",
                    labelText:"Şifre (tekrar)" )),
              /*  TextButton(onPressed: () {
                  register(controlUsername,controlEmail,controlEmail2,controlPassword,controlPassword2, context);
                 },child: Text("REGISTER", )),*/
                TextButton.icon(onPressed: () {
                  register(controlGirisUsername, controlUsername, controlEmail, controlEmail2,
                      controlPassword, controlPassword2, context);
                }, icon: const Icon(Icons.app_registration), label: const Text("Kayıt Ol")),
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(5),
                  child: TextButton( child: const Text("Giriş Yap"),
                    onPressed: () {
                      Navigator.pop(context,"go to login");
                    },),
                )
              ], //column children
            ),),), //column
      ),
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

   _loginPressed() async {
 login(controlGirisUsername, controlGirisPassword);
    /* if(log.isLoged) {

     }*/
  }



  void _registerPressed(BuildContext ctx) {
      Navigator.of(context).pushNamed(
      '\register',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 247, 247,1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(63, 114, 175,1),
        title: Text(widget.title),
      ),
      body:Center( child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 175,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child:Image.asset("asset/logo1.png", )

              ),
            ),
            const Text(
              'You need to login to use app.',
            ),
            TextField(maxLines: 1,controller: controlGirisUsername,
                keyboardAppearance: Brightness.light,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              decoration: const InputDecoration(icon: Icon(Icons.person),hintText: "Username", labelText: "Username"),),
            TextField(maxLines: 1,controller: controlGirisPassword,
                keyboardAppearance: Brightness.light,
                obscureText: true,decoration: const InputDecoration(icon: Icon(Icons.lock),hintText: "Password",  labelText: "Password")),
           /* TextButton(onPressed: _loginPressed,
              
              child: Text("LOGIN", ), )*/
            TextButton.icon(onPressed: _loginPressed, icon: const Icon(Icons.login), label: const Text("LOGIN")),
           Container(
             padding: const EdgeInsets.all(0),
             margin: const EdgeInsets.all(5),
             child: TextButton( child: const Text("REGISTER"),
               onPressed: () {
               _registerPressed(context);
             },),
           )
          ],
        ),),),
      ),
    );
  }
}
