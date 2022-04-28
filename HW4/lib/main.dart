import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hw4_photoalbum/picture_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HW4_PhotoAlbum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> images = [];
  Object refresh = Object();
  void createImageWidget(XFile? pickedFile) async {
    if (pickedFile != null) {
      var imageFile =
          await decodeImageFromList(File(pickedFile.path).readAsBytesSync());
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        Image image = Image.file(File(pickedFile.path), fit: BoxFit.cover);
        images.add(ClipRRect(
            key: ValueKey<String>(pickedFile.path),
            borderRadius: BorderRadius.circular(8),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PictureView(
                                title: widget.title,
                                image: image,
                                width: imageFile.width,
                                height: imageFile.height,
                              )));
                },
                child: image)));
        refresh = Object();
      });
    }
  }

  void getPictureFromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
      createImageWidget(pickedFile);
    } catch (e) {
      print(e);
    }
  }

  void getPictureFromCamera() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
      createImageWidget(pickedFile);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final ButtonStyle style = ElevatedButton.styleFrom(
        onPrimary: Colors.blue,
        primary: const Color.fromARGB(255, 212, 212, 212));
    final ButtonStyle style2 = ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: const Color.fromARGB(255, 212, 212, 212));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GridView.count(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          key: ValueKey<Object>(refresh),
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          primary: false,
          padding: const EdgeInsets.all(20),
          children: images,
        ),
      ),
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
            style: style,
            onPressed: getPictureFromGallery,
            child: Row(
              children: const [Icon(Icons.photo_album), Text("Add from photo")],
            )),
        ElevatedButton(
            style: style2,
            onPressed: getPictureFromCamera,
            child: Row(
              children: const [Icon(Icons.camera), Text("Use camera")],
            ))
      ]),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
