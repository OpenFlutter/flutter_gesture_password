import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gesture_password/gesture_password.dart';

class CircleItemPainter extends CustomPainter {
  CircleItemPainter(
      this.itemAttribute, this.touchPoint, this.circleList, this.lineList);

  final Offset touchPoint;
  final List<Circle> circleList;
  final List<Circle> lineList;
  final ItemAttribute itemAttribute;

  @override
  void paint(Canvas canvas, Size size) {
    //没选中小圆
    final normalCirclePaint = new Paint()
      ..color = itemAttribute.normalColor
      ..style = PaintingStyle.fill;

    //选中小圆
    final selectedCirclePaint = new Paint()
      ..color = itemAttribute.selectedColor
      ..style = PaintingStyle.fill;

    //选中大圆
    final selectedBigCirclePaint = new Paint()
      ..color = itemAttribute.selectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = itemAttribute.circleStrokeWidth;

    //线
    final linePaint = new Paint()
      ..color = itemAttribute.selectedColor
      ..style = PaintingStyle.fill
      ..strokeWidth = itemAttribute.lineStrokeWidth;

    for (int i = 0; i < circleList.length; i++) {
      Circle circle = circleList[i];
      canvas.drawCircle(
          circle.offset, itemAttribute.smallCircleR, normalCirclePaint);
      if (circle.isSelected()) {
        canvas.drawCircle(
            circle.offset, itemAttribute.smallCircleR, selectedCirclePaint);
        canvas.drawCircle(
            circle.offset, itemAttribute.bigCircleR, selectedBigCirclePaint);
      }
    }
    if (lineList.length > 0) {
      for (int i = 0; i < lineList.length; i++) {
        canvas.drawLine(
            lineList[i].offset,
            i == (lineList.length - 1) ? touchPoint : lineList[i + 1].offset,
            linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(CircleItemPainter old) => true;
}
