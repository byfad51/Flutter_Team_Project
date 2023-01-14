import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'cameramain.dart' as cm;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(219, 226, 239, 1),
      appBar: AppBar(
        title: const Text('Yüklenen Resimler'),
        backgroundColor: const Color.fromRGBO(17, 45, 78, 1),
      ),
      body: FutureBuilder(
              future: _getImageFiles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final imageFiles = snapshot.data;
                  return ListView.builder(
                    itemCount: imageFiles!.length,
                    itemBuilder: (context, index) {
                      return Image.file(imageFiles[index]);
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }

  Future<List<File>> _getImageFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync().where((f) => f is File).toList();
    final imageFiles = files.where((f) => f.path.endsWith('.png') || f.path.endsWith('.jpg')).toList();
    return imageFiles.cast<File>();
  }
}
