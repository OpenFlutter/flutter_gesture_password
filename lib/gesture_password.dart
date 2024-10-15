import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gesture_password/circle_item_painter.dart';

class GesturePassword extends StatefulWidget {
  final ValueChanged<String>? successCallback;
  final ValueChanged<String>? selectedCallback;
  final VoidCallback? failCallback;
  final ItemAttribute attribute;
  final double height;
  final double? width;

  GesturePassword({
    required this.successCallback,
    this.failCallback,
    this.selectedCallback,
    this.attribute = ItemAttribute.normalAttribute,
    this.height = 300.0,
    this.width,
  });

  @override
  _GesturePasswordState createState() => _GesturePasswordState();
}

class _GesturePasswordState extends State<GesturePassword> {
  Offset touchPoint = Offset.zero;
  List<Circle> circleList = <Circle>[];
  List<Circle> lineList = <Circle>[];

  @override
  void initState() {
    num hor =
        (widget.width ?? MediaQueryData.fromWindow(ui.window).size.width) / 6;
    num ver = widget.height / 6;
    //每个圆的中心点
    for (int i = 0; i < 9; i++) {
      num tempX = (i % 3 + 1) * 2 * hor - hor;
      num tempY = (i ~/ 3 + 1) * 2 * ver - ver;
      circleList.add(Circle(Offset(tempX.toDouble(), tempY.toDouble()), i.toString()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = Size(
        widget.width ?? MediaQueryData.fromWindow(ui.window).size.width,
        widget.height);
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox? box = context.findRenderObject() as RenderBox?;
          Offset? offset = box?.globalToLocal(details.globalPosition);
          touchPoint = offset ?? Offset.zero;
          //防止绘画越界
          if (touchPoint.dy < 0) {
            touchPoint = Offset(touchPoint.dx, 0.0);
          }
          if (touchPoint.dy > widget.height) {
            touchPoint = Offset(touchPoint.dx, widget.height);
          }
          Circle? circle = getOuterCircle(touchPoint);
          if (circle != null) {
//            print('circle.isUnSelected()${circle.isUnSelected()}');
            if (circle.isUnSelected()) {
              lineList.add(circle);
              circle.setState(Circle.CIRCLE_SELECTED);
              if (widget.selectedCallback != null) {
                widget.selectedCallback?.call(getPassword());
              }

//              print('circle.isUnSelected()2222${circle.isUnSelected()}');
            }
          }
          print(lineList.length);
//          print(lineList.map((f)=>f.offset));
        });
      },
      onPanEnd: (DragEndDetails details) {
        setState(() {
          if (circleList
                  .where((Circle itemCircle) => itemCircle.isSelected())
                  .length >=
              4) {
            widget.successCallback?.call(getPassword());
          } else {
            if (widget.failCallback != null) {
              widget.failCallback?.call();
            }
          }
          touchPoint = Offset.zero;
          lineList.clear();
          for (int i = 0; i < circleList.length; i++) {
            Circle circle = circleList[i];
            circle.setState(Circle.CIRCLE_NORMAL);
          }
        });
      },
      child: CustomPaint(
          size: size,
          painter: CircleItemPainter(
            widget.attribute,
            touchPoint,
            circleList,
            lineList,
          )),
    );
  }

  ///判断是否在圈里
  Circle? getOuterCircle(Offset offset) {
    for (int i = 0; i < 9; i++) {
      var cross = offset - circleList[i].offset;
      if (cross.dx.abs() < widget.attribute.focusDistance &&
          cross.dy.abs() < widget.attribute.focusDistance) {
        return circleList[i];
      }
    }
    return null;
  }

  String getPassword() {
    return lineList
        .map((selectedItem) => selectedItem.index.toString())
        .toList()
        .fold("", (s, str) {
      return s + str;
    });
  }
}

class Circle {
  static final CIRCLE_SELECTED = 1;
  static final CIRCLE_NORMAL = 0;
  Offset offset;
  String index;
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

class ItemAttribute {
  final Color selectedColor;
  final Color normalColor;
  final double lineStrokeWidth;
  final double circleStrokeWidth;
  final double smallCircleR;
  final double bigCircleR;
  final double focusDistance;
  static const ItemAttribute normalAttribute = const ItemAttribute(
      normalColor: const Color(0xFFBBDEFB),
      selectedColor: const Color(0xFF1565C0));

  const ItemAttribute({
    required this.normalColor,
    required this.selectedColor,
    this.lineStrokeWidth = 2.0,
    this.circleStrokeWidth = 2.0,
    this.smallCircleR = 10.0,
    this.bigCircleR = 30.0,
    this.focusDistance = 25.0,
  });
}
