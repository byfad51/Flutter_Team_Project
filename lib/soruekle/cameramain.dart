import 'dart:io';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'Notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:path_provider/path_provider.dart';
import 'readimage.dart' as rd;
/*
void main() async {
  //String x = "XXX";
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(
    //name: "comp205-f",
   // options: const FirebaseOptions(
     // apiKey: "AIzaSyBmxk6-MGjyA3_mY0gUaxxT23O7Oxqf2v0",
     // appId: "1:980944249696:android:07eea970c89aba30f87405",
     // messagingSenderId: "980944249696-tn52aavvobvhknhljjgg1hpebjo4j8f4.apps.googleusercontent.com",
     // projectId: "comp205fl",
     // storageBucket: "comp205fl.appspot.com",
    //),
  //);
  //await Firebase.initializeApp();
  runApp(MaterialApp(home:MyApp()));
}*/
var num = _MyAppState().imageFileList!.length;

class MyAppCamera extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppCamera> {
  //final FirebaseStorage _storage = FirebaseStorage.instance;
  List<XFile>? imageFileList = [];
  var imagePicker;
  var uuid = Uuid();
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    tz.initializeTimeZones();
  }
  Future<void> _getImages() async {
    // Open the device's image picker
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      NotificationService().showNotification(1, "Seç", "Resimler Başarıyla Seçildi.", 1);
      Fluttertoast.showToast(
          msg: "Resimler Başarıyla Seçildi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(219, 226, 239, 1),
          textColor: const Color.fromRGBO(17, 45, 78, 1),
          fontSize: 16.0
      );
      setState(() {

      });
    }
  }

  Future<void> _uploadImages() async {
    // Iterate over the list of images
    //_imageFileList.forEach
    //int i = 0;
    final directory = await getApplicationDocumentsDirectory();
    print(directory);
    final List<File> selectedPostImages = imageFileList!.map<File>((XFile) => File(XFile.path)).toList();
    for(var imageFile in selectedPostImages){
      final file = File('${directory.path}/${uuid.v4().toString()}.png');
      await file.writeAsBytes((await imageFile.readAsBytes()));
      // Update the state to show the new image
      setState(() {
        imageFile = file;
      });
    }
    if (selectedPostImages!.isNotEmpty) {
      NotificationService().showNotification(2, "Yükle", "Resimler Başarıyla Yüklendi.", 1);
      Fluttertoast.showToast(
          msg: "Resimler Başarıyla Yüklendi.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(219, 226, 239, 1),
          textColor: const Color.fromRGBO(17, 45, 78, 1),
          fontSize: 16.0
      );
    }
    imageFileList?.clear();
    for (var imageFile in selectedPostImages!) {
      // Generate a unique file name for the image
      //String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = uuid.v4().toString();
      // Create a reference to the file in Firebase Storage
      //Reference reference = _storage.ref().child(fileName);
      //Reference reference = _storage.ref().child(fileName+i.toString());
      //i++;
      // Upload the file to Firebase Storage
      // UploadTask uploadTask = reference.putFile(imageFile).whenComplete(() => geturl(reference));
      // UploadTask uploadTask = reference.putFile(imageFile);
      // await reference.putFile(imageFile);
      //reference.putFile(imageFile);
      //var downloadUrl = await reference.getDownloadURL();
      //debugPrint(downloadUrl);
      //String url = await reference.getDownloadURL();

      // Do something with the URL (e.g. save it to a database)
     // print('File uploaded: $url');
      // Get the URL for the uploaded file
      //await uploadTask.onComplete;

    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(219, 226, 239, 1),

        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: imageFileList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(imageFileList![index].path),
                          height: 200,
                          width: 200,
                        );
                      }),
                ),
              ),
              Text('Seçilen Resimler: ${imageFileList!.length}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: const Color.fromRGBO(17, 45, 78, 1),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: const Color.fromRGBO(219, 226, 239, 1),
                                size: 24.0,
                                semanticLabel: "",
                              ),
                            ),
                          ),
                          TextSpan(text: 'Sorularım'),
                        ],
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => rd.MyHomePage())),
                  ),
                  MaterialButton(
                    color: const Color.fromRGBO(17, 45, 78, 1),
                    onPressed: _getImages,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                Icons.add_a_photo,
                                color: const Color.fromRGBO(219, 226, 239, 1),
                                size: 24.0,
                                semanticLabel: "",
                              ),
                            ),
                          ),
                          TextSpan(text: 'Resim Ekle'),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: const Color.fromRGBO(17, 45, 78, 1),
                    onPressed: _uploadImages,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                Icons.upload,
                                color: const Color.fromRGBO(219, 226, 239, 1),
                                size: 24.0,
                                semanticLabel:
                                '',
                              ),
                            ),
                          ),
                          TextSpan(text: 'Yükle'),
                        ],
                      ),
                    ),
                    //Text('CAMERA'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
