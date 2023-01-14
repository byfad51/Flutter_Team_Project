import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:girisapp/search_profile.dart';
import 'package:girisapp/successLogin/settings.dart';
import 'package:girisapp/user.dart';
import 'main.dart';
import 'data.dart';

//enum Menu { itemOne, itemTwo, itemThree, itemFour }
TextEditingController controlUsername =TextEditingController() ;
class profile extends StatefulWidget {

  const profile({super.key});

  @override
  State<profile> createState() => _profile();

}
bool bioBool = set.bioShow;
bool hedefBool=set.uniShow;
bool tepkiBool = set.profilTepkisi;
class _profile  extends State<profile>{

  //late UserSettings sett;
  /*
Widget search1(BuildContext context){
*/ void cek(){
    setState(() {
      profileInfo();
      tepkiCek();
      bioBool = set.bioShow;
      hedefBool=set.uniShow;
    });
  }
Future<void> go() async{
  myInfo = await userInfo(context: context);

}
  void _searchMember(BuildContext ctx){
    double high =  MediaQuery.of(ctx).size.height;
      showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:
                () {}, //use this with gesturedetector to prevent close the bottomsheet when you click inside the sheet
            child: Card(
              elevation: 5,
              child: Container(
                height: high,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    TextField(maxLines: 1,
                        keyboardAppearance: Brightness.light,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,controller: controlUsername,decoration:
                        InputDecoration(icon: Icon(Icons.person), hintText: "Username",
                            labelText:"Username" )),
                    TextButton.icon(onPressed: () async {

                      go();
                       // ignore: use_build_context_synchronously


                    }, icon: Icon(Icons.search), label: Text("FIND PERSON")),
                    Text("Kullanıcının tam adını girmeniz gerekmektedir.", style: TextStyle(color: Colors.red),)
                  ],)
                ),
              ), //container
            ), //card
          ); //gesturedetector return
        }, //showModalBottomSheet builder
      ); //s
      // howModalBottomSheet function

  }
Widget tepkiler(BuildContext context){
  return Container(

    child: ListView.builder(

      itemCount: 5,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => setState(
                  () => Navigator.of(context).pushNamed('/denemedesc')),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(63, 114, 175, 0.70),
                borderRadius: BorderRadius.circular(15)
            ),

            child: Text("deneme")
          ),
        );
      },
    ),
  );
}

Widget build(BuildContext context){
  cek();
//String bio = sett.bio;
/*setState(() {
  profileInfo();
  bioBool = set.bioShow;
  hedefBool=set.uniShow;
});*/


  return

    Scaffold(
        floatingActionButton: FloatingActionButton(onPressed:() {
          _searchMember(context);
          }, backgroundColor: Colors.blue,
          child: const Icon(Icons.search),),
    body:

    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(
        height: 125,
        width: 125,
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
            child:Image.network(set.resimURL )

        ),
      ),
      Container(child: Column(children: [
        Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
        child:Text(myUser.username, style: TextStyle(fontSize: 25, color: Colors.brown),),),

      ])),
      Visibility(
        child: Card(
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Text(bio),
              ListTile(

                leading: Icon(Icons.short_text_sharp),
                title: Text(set.bio),

              ),

            ],
          ),
        ),
        // maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: bioBool,
      ),
      Visibility(
        child: Card(
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(

                leading: Icon(Icons.school),
                title: Text(set.uniName),

                subtitle: Text(set.bolumName),

              ),

            ],
          ),
        ),
        // maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: hedefBool,
      )
      ,

      Flexible(child: tepkiLister())
     // tepkiLister()

    ],
  ),)
  ;

}

}

/*
class _ContactListItem extends ListTile {

  _ContactListItem(UserSettings set) :
        super(
          title : Text(set.bio),
          subtitle: Text(contact.email),
          leading: CircleAvatar(
              child: Text(contact.fullName[0])
          )
      );

}*/

/*
const ListTile(

leading: Icon(Icons.short_text_sharp),
title: Text("bio"),

),

const ListTile(

leading: Icon(Icons.school),
title: Text("Abdullah Gül Üniversitesi"),

subtitle: Text('Bilgsiayar'),
trailing: Icon(Icons.computer),
),*/

class tepkiLister extends StatelessWidget{

  Widget build(BuildContext context){
    Size devicesize = MediaQuery.of(context).size;

    return Visibility(
      child: ListView.builder(
          itemCount: tepkilerList.length,
          itemBuilder: (context, index) {
            List innerList = tepkilerList[index];
            return Card(
              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(

                    leading: Icon(Icons.message),
                    title: Text(innerList[1].toString(),style: TextStyle(color: Colors.black54)),

                    subtitle: Text(innerList[0].toString(),style: TextStyle(color: Colors.black38)),

                  ),

                ],
              ),
            );

          }),
      maintainAnimation: true,
      maintainState: true,
      visible: tepkiBool,
    );
  }
}