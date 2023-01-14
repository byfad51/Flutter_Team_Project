import 'package:flutter/material.dart';
import 'package:girisapp/deneme.dart';
import 'package:girisapp/user.dart';
import 'package:girisapp/data.dart';
Widget denemelerim(BuildContext context, User myUser) {

  return Container(

    child: Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.all(15),
          padding: EdgeInsetsDirectional.all(10),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromRGBO(231, 11, 81, 1),
          ),
          child: Container(
            /*
                There will be some line graph codes.
               */
          ),
        ),
        Container(
          height: 475,
          margin: EdgeInsetsDirectional.all(2),
          padding: EdgeInsetsDirectional.all(5),

          child: ListView.builder(
            itemCount: DENEME_DUMMY.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          child: Text(
                            DENEME_DUMMY[index].name,
                            style: TextStyle(
                              fontSize:20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: Text(
                          "Netler:",
                          style: TextStyle(
                            fontSize:15,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            child: Text(
                              "Türkçe: ${DENEME_DUMMY[index].turkD}",
                              style: TextStyle(
                                fontSize:10,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            child: Text(
                              "Sosyal: ${DENEME_DUMMY[index].sosD}",
                              style: TextStyle(
                                fontSize:10,
                              ),
                            ),
                          ),
                        ],

                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            child: Text(
                              "Matematik: ${DENEME_DUMMY[index].matD}",
                              style: TextStyle(
                                fontSize:10,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            child: Text(
                              "Fen: ${DENEME_DUMMY[index].fenD}",
                              style: TextStyle(
                                fontSize:10,
                              ),
                            ),
                          ),
                        ],

                      ),
                       Spacer(),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.arrow_right_alt_outlined)
                      )
                    ],
                  ),
                ),
              );
            },


          ),
        ),
      ], //Children of Column
    ),
  );
}
