import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gesture_password/mini_circle_view.dart';

class MiniGesturePassword extends StatefulWidget {
  final MiniItemAttribute attribute;
  final double height;

  MiniGesturePassword({
    Key? key,
    this.attribute = MiniItemAttribute.normalAttribute,
    this.height = 60.0,
  }) : super(key: key);

  @override
  MiniGesturePasswordState createState() => MiniGesturePasswordState();
}

class MiniGesturePasswordState extends State<MiniGesturePassword> {
  Offset touchPoint = Offset.zero;
  List<Circle> circleList = <Circle>[];
  String selectedStr = '';

  @override
  void initState() {
    num hor = widget.height / 6;
    num ver = widget.height / 6;
    //每个圆的中心点
    for (int i = 0; i < 9; i++) {
      num tempX = (i % 3 + 1) * 2 * hor - hor;
      num tempY = (i ~/ 3 + 1) * 2 * ver - ver;
      circleList.add(Circle(Offset(tempX.toDouble(), tempY.toDouble()), i));
    }
    super.initState();
  }

  setSelected(String str) {
    setState(() {
      selectedStr = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = Size(widget.height, widget.height);
    return Container(
      child: CustomPaint(
          size: size,
          painter: MiniCircleView(widget.attribute, circleList, selectedStr)),
    );
  }
}

class Circle {
  static final CIRCLE_SELECTED = 1;
  static final CIRCLE_NORMAL = 0;
  Offset offset;
  int index;
  int state = CIRCLE_NORMAL;

  Circle(this.offset, this.index);

  int getState() {
    return state;
  }

  setState(int state) {
    this.state = state;
  }

  bool isSelected() {
    return state == CIRCLE_SELECTED;
  }

  bool isUnSelected() {
    return state == CIRCLE_NORMAL;
  }
}

class MiniItemAttribute {
  final Color selectedColor;
  final Color normalColor;
  final double smallCircleR;
  static const MiniItemAttribute normalAttribute = const MiniItemAttribute(
      normalColor: const Color(0xFFBBDEFB),
      selectedColor: const Color(0xFF1565C0));

  const MiniItemAttribute({
    required this.normalColor,
    required this.selectedColor,
    this.smallCircleR = 6.0,
  });
}
