import 'package:flutter/material.dart';
import 'package:gesture_password/gesture_password.dart';
import 'package:gesture_password/mini_gesture_password.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  GlobalKey<MiniGesturePasswordState> miniGesturePassword =
  new GlobalKey<MiniGesturePasswordState>();

  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        key: scaffoldState,
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Column(
          children: <Widget>[
            new Center(
                child: new MiniGesturePassword(key: miniGesturePassword)),
            new Container(
              color: Colors.red,
              margin: const EdgeInsets.only(top: 100.0),
              child: new GesturePassword(
                successCallback: (s) {
                  print("密码为$s");
                  scaffoldState.currentState?.showSnackBar(
                      new SnackBar(content: new Text('successCallback:$s')));
                  miniGesturePassword.currentState?.setSelected('');
                },
                failCallback: () {
                  print('失败了');
                  scaffoldState.currentState?.showSnackBar(
                      new SnackBar(content: new Text('failCallback')));
                  miniGesturePassword.currentState?.setSelected('');
                },
                selectedCallback: (str) {
                  miniGesturePassword.currentState?.setSelected(str);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
