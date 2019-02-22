# gesture_password

##### Flutter的手势密码

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
![image](https://github.com/zhangruiyu/flutter_gesture_password/blob/master/wow.gif)

## How to use ?

1. Depend on it
 
```yaml
dependencies:
  gesture_password: "^0.0.4"
```

2. Install it
 
```sh
$ flutter packages get
```

3. Import it

```dart
import 'package:gesture_password/gesture_password.dart';
import 'package:gesture_password/mini_gesture_password.dart';
```

## 属性
* width 控件宽度(xia-weiyang想法)
* selectedColor 选中的颜色
* normalColor:  没选中的颜色
* lineStrokeWidth: 线宽
* circleStrokeWidth: 选中外圈圆宽
* smallCircleR: 小圆半径
* bigCircleR: 大圆半径
* focusDistance: 选中差值 越大越容易选中
* successCallback 选择4个以上松手回调,返回值为选中的index相加的字符串
* failCallback 选择4下以上松手回调
* selectedCallback 经过任意一个后回调,返回值为选中的index相加的字符串

## Example
```dart
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
```

##### 有需求的话,后期再加入其他的吧
