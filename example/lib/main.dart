import 'package:flutter/material.dart';
import 'package:gesture_password/gesture_password.dart';
import 'package:gesture_password/mini_gesture_password.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            new LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return new Container(
                  color: Colors.red,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: new GesturePassword(
                    width: 200.0,
                    successCallback: (s) {
                      print("successCallback$s");
                      scaffoldState.currentState?.showSnackBar(new SnackBar(
                          content: new Text('successCallback:$s')));
                      miniGesturePassword.currentState?.setSelected('');
                    },
                    failCallback: () {
                      print('failCallback');
                      scaffoldState.currentState?.showSnackBar(
                          new SnackBar(content: new Text('failCallback')));
                      miniGesturePassword.currentState?.setSelected('');
                    },
                    selectedCallback: (str) {
                      miniGesturePassword.currentState?.setSelected(str);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
