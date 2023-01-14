import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:girisapp/denemelerim/denemelistesi.dart';

class DenemeHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void _toTheDenemeList() {
      Navigator.of(context).pushNamed('/denemelist');
    }


    Size devicesize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(7.5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(63, 114, 175, 0.6),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      "TYT Denemeleri",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: devicesize.height * 0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.dogrukaynak.com/content/daafc61f-f296-4a4a-ba44-412b49abe5a8.jpg"),
                          fit: BoxFit.fitWidth,
                        )),
                    child: Container(child: Text("")),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(7.5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(63, 114, 175, 0.6),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      "AYT Denemeleri",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: devicesize.height * 0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(63, 114, 175, 0.6),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.dogrukaynak.com/content/daafc61f-f296-4a4a-ba44-412b49abe5a8.jpg"),
                          fit: BoxFit.fitWidth,
                        )),
                    child: Container(child: Text("")),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _toTheDenemeList,
                    splashColor: Color.fromRGBO(17, 45, 78, 1),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        height: devicesize.height * 0.14,
                        width: devicesize.width * 0.42,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 114, 175, 0.6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "AYT Denemeleri",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                  ),
                  InkWell(
                    onTap: _toTheDenemeList,
                    splashColor: Color.fromRGBO(17, 45, 78, 1),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        height: devicesize.height * 0.14,
                        width: devicesize.width * 0.42,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 114, 175, 0.6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "TYT Denemeleri",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}